#!/usr/bin/env bash

STATE_FILE="/tmp/pomodoro-state"
NOTIFIED_FLAG="/tmp/pomodoro-notified"
LOG_DIR="$HOME/.local/share/pomodoro"
LOG_FILE="$LOG_DIR/pomodoro.log"

# Durations in seconds
FOCUS_DURATION=1500   # 25 min
SHORT_DURATION=300    # 5 min
LONG_DURATION=900     # 15 min
LONG_BREAK_EVERY=4    # long break every N focus sessions

mkdir -p "$LOG_DIR"

get_duration() {
    case "$1" in
        focus) echo $FOCUS_DURATION ;;
        short) echo $SHORT_DURATION ;;
        long)  echo $LONG_DURATION ;;
        *)     echo $FOCUS_DURATION ;;
    esac
}

# State format: MODE|STATUS|VALUE|FOCUS_COUNT
# FOCUS_COUNT = completed focus sessions since last long break
read_state() {
    if [[ -f "$STATE_FILE" ]]; then
        IFS='|' read -r MODE STATUS VALUE FOCUS_COUNT < "$STATE_FILE"
        FOCUS_COUNT=${FOCUS_COUNT:-0}
    else
        MODE="focus"
        STATUS="idle"
        VALUE=0
        FOCUS_COUNT=0
    fi
}

write_state() {
    echo "${MODE}|${STATUS}|${VALUE}|${FOCUS_COUNT}" > "$STATE_FILE"
}

format_time() {
    local secs=$1
    if (( secs < 0 )); then secs=0; fi
    printf "%02d:%02d" $(( secs / 60 )) $(( secs % 60 ))
}

mode_icon() {
    case "$1" in
        focus) echo "󰔟" ;;
        short) echo "󰾩" ;;
        long)  echo "󰾩" ;;
    esac
}

mode_label() {
    case "$1" in
        focus) echo "Focus" ;;
        short) echo "Short Break" ;;
        long)  echo "Long Break" ;;
    esac
}

log_event() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') | $1" >> "$LOG_FILE"
}

# Determine next mode after current one completes
next_mode() {
    case "$MODE" in
        focus)
            if (( FOCUS_COUNT > 0 && FOCUS_COUNT % LONG_BREAK_EVERY == 0 )); then
                echo "long"
            else
                echo "short"
            fi
            ;;
        short|long)
            echo "focus"
            ;;
    esac
}

transition_to_next() {
    local prev_mode="$MODE"
    MODE=$(next_mode)
    STATUS="idle"
    VALUE=0
    write_state
    log_event "$(mode_label "$prev_mode") completed → next: $(mode_label "$MODE")"
}

cmd_status() {
    read_state

    local icon remaining_str class tooltip

    case "$STATUS" in
        running)
            local now remaining
            now=$(date +%s)
            remaining=$(( VALUE - now ))
            if (( remaining <= 0 )); then
                # Timer done — notify and transition
                if [[ ! -f "$NOTIFIED_FLAG" ]]; then
                    touch "$NOTIFIED_FLAG"
                    if [[ "$MODE" == "focus" ]]; then
                        FOCUS_COUNT=$(( FOCUS_COUNT + 1 ))
                        write_state
                        notify-send -u normal -a "Pomodoro" \
                            "$(mode_label "$MODE") complete! (#$FOCUS_COUNT)" \
                            "Click to start break." -i dialog-information
                    else
                        notify-send -u normal -a "Pomodoro" \
                            "$(mode_label "$MODE") complete!" \
                            "Click to start focus." -i dialog-information
                    fi
                    transition_to_next
                    rm -f "$NOTIFIED_FLAG"
                fi
                # Re-read after transition
                read_state
                icon=$(mode_icon "$MODE")
                class="idle"
                tooltip="$(mode_label "$MODE") — click to start"
                echo "{\"text\": \"${icon}\", \"tooltip\": \"${tooltip}\", \"class\": \"${class}\"}"
                return
            fi
            remaining_str=$(format_time "$remaining")
            icon=$(mode_icon "$MODE")
            class="$MODE"
            tooltip="$(mode_label "$MODE") — $remaining_str"
            echo "{\"text\": \"${icon} ${remaining_str}\", \"tooltip\": \"${tooltip}\", \"class\": \"${class}\"}"
            ;;
        paused)
            remaining_str=$(format_time "$VALUE")
            icon="󰏤"
            class="paused"
            tooltip="$(mode_label "$MODE") — Paused — $remaining_str"
            echo "{\"text\": \"${icon} ${remaining_str}\", \"tooltip\": \"${tooltip}\", \"class\": \"${class}\"}"
            ;;
        idle|*)
            icon=$(mode_icon "$MODE")
            class="idle"
            tooltip="$(mode_label "$MODE") — click to start (#$(( FOCUS_COUNT + 1 )) pomodoro)"
            echo "{\"text\": \"${icon}\", \"tooltip\": \"${tooltip}\", \"class\": \"${class}\"}"
            ;;
    esac
}

cmd_toggle() {
    read_state

    case "$STATUS" in
        running)
            # Pause
            local now remaining
            now=$(date +%s)
            remaining=$(( VALUE - now ))
            if (( remaining < 0 )); then remaining=0; fi
            STATUS="paused"
            VALUE=$remaining
            log_event "$(mode_label "$MODE") paused ($(format_time "$remaining") left)"
            ;;
        paused)
            # Resume
            local now
            now=$(date +%s)
            STATUS="running"
            VALUE=$(( now + VALUE ))
            log_event "$(mode_label "$MODE") resumed"
            ;;
        idle|*)
            # Start
            local dur now
            dur=$(get_duration "$MODE")
            now=$(date +%s)
            STATUS="running"
            VALUE=$(( now + dur ))
            log_event "$(mode_label "$MODE") started ($(format_time "$dur"))"
            ;;
    esac

    write_state
    rm -f "$NOTIFIED_FLAG"
}

cmd_skip() {
    read_state
    local prev_mode="$MODE"
    log_event "$(mode_label "$MODE") skipped"
    if [[ "$MODE" == "focus" ]]; then
        # Skipping focus doesn't count as completed
        MODE=$(next_mode)
    else
        MODE="focus"
    fi
    STATUS="idle"
    VALUE=0
    write_state
    rm -f "$NOTIFIED_FLAG"
}

cmd_reset() {
    MODE="focus"
    STATUS="idle"
    VALUE=0
    FOCUS_COUNT=0
    write_state
    rm -f "$NOTIFIED_FLAG"
    log_event "Timer reset"
}

case "${1:-status}" in
    status) cmd_status ;;
    toggle) cmd_toggle ;;
    skip)   cmd_skip ;;
    reset)  cmd_reset ;;
    *)      echo "Usage: $0 {status|toggle|skip|reset}" ;;
esac
