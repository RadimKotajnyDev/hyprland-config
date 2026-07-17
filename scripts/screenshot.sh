#!/usr/bin/env bash
#
# Spectacle-like screenshots for Hyprland.
#
# Usage: screenshot.sh <mode>
#   region   - drag-select a rectangle, then open the annotation editor (default)
#   window   - capture the active window, then open the editor
#   screen   - capture the focused monitor, then open the editor
#   region-copy - drag-select a rectangle straight to the clipboard (no editor)
#
# Editor modes open satty; there you copy (Ctrl+C) or save (Ctrl+S) the annotated
# shot to ~/Pictures/Screenshots. The region-copy mode saves + copies immediately.

set -euo pipefail

mode="${1:-region}"
save_dir="${XDG_PICTURES_DIR:-$HOME/Pictures}/Screenshots"
mkdir -p "$save_dir"
filename="$save_dir/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"

notify() { command -v notify-send >/dev/null 2>&1 && notify-send -a Screenshot "$@" || true; }

# Grab a geometry / raw capture depending on the mode, emitting PNG on stdout.
capture() {
    case "$mode" in
        region)
            grim -g "$(slurp -d)" -
            ;;
        region-copy)
            grim -g "$(slurp -d)" -
            ;;
        window)
            local geom
            geom=$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
            grim -g "$geom" -
            ;;
        screen)
            local out
            out=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
            grim -o "$out" -
            ;;
        *)
            echo "unknown mode: $mode" >&2
            exit 1
            ;;
    esac
}

# slurp aborted (Esc) -> exit quietly without an error popup.
img=$(capture) || exit 0
[ -n "$img" ] || exit 0

if [ "$mode" = "region-copy" ]; then
    printf '%s' "$img" | tee "$filename" | wl-copy -t image/png
    notify "Copied to clipboard" "Saved $filename"
    exit 0
fi

# Open satty: annotate, then it saves to $filename and copies to the clipboard.
printf '%s' "$img" | satty \
    --filename - \
    --output-filename "$filename" \
    --early-exit \
    --copy-command wl-copy
