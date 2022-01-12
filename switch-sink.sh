#!/bin/bash

if [ ! -x "$(command -v pactl)" ]; then
    cat <<EOL >&2
$(basename $0): missing pactl
The PulseAudio "pactl" binary is required to use this program.
EOL
    exit 1
fi

if [ -z "$1" ]; then
    cat <<EOL >&2
$(basename $0): not enough arguments
Try '$(basename $0) --help' for more information.
EOL
    exit 1
fi

list_sinks() {
    echo "Available system Sinks:"
    echo "ID      NAME"
    pactl list short sinks
}

usage() {
    cat <<EOL
Usage: $(basename $0) [OPTION] ID/NAME
Switch the default output to the sink identified either by its ID or NAME
provided by the PulseAudio "pactl" binary.

  -h, --help            display this help and exit
  -l, --list-sinks      list the PulseAudio sinks available on the system
EOL
}

args=()
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
    -h | --help)
        usage
        exit 0
        ;;
    -l | --list)
        list_sinks
        exit 0
        ;;
    *)
        args+=("$1")
        shift
        ;;
    esac
done

newSink="${args[0]}"
echo "Set default sink: $newSink"
pacmd set-default-sink "$newSink"
pactl list short sink-inputs | while read stream; do
    streamId=$(echo $stream | cut '-d ' -f1)
    echo "Moving stream: $streamId"
    pactl move-sink-input "$streamId" "$newSink"
done
