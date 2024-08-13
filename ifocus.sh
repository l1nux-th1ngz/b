#!/bin/bash

# Check if any arguments are provided
if [ $# = 0 ]; then
    cat <<EOF
Usage: $(basename "${0}") process_name [executable_name] [--take-first]
    process_name       As recognized by 'xdo' command
    executable_name    As used for launching from terminal
    --take-first       In case 'xdo' returns multiple process IDs
EOF
    exit 0
fi

# Get window ID by class name and then fallback to instance name
id=$(xdo id -N "${1}" || xdo id -n "${1}")

# Default to process_name for executable name
executable=${1}
shift

# Process additional arguments
while [ -n "${1}" ]; do
    case ${1} in
    --take-first)
        # Take only the first window ID if multiple are returned
        id=$(head -1 <<<"${id}" | cut -f1 -d' ')
        ;;
    *)
        # Override the executable name
        executable=${1}
        ;;
    esac
    shift
done

# If no window ID is found, launch the executable
if [ -z "${id}" ]; then
    ${executable}
else
    # If window IDs are found, move them to the current workspace and focus them
    while read -r instance; do
        i3-msg "[id=${instance}] move workspace current"
        i3-msg "[id=${instance}] focus"
    done <<<"${id}"
fi
