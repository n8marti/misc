#!/bin/bash

# Send command output to both zenity and variable.
# https://stackoverflow.com/questions/12451278/capture-stdout-to-a-variable-but-still-display-it-in-the-console
{
    variable=$(
        snap refresh | tee >(zenity "${ZPROGDEFS[@]}" "${ZDEFAULTS[@]}" \
            2>/dev/null) /dev/fd5
    )
# Redirect /dev/fd5 to /dev/fd1 to "export" $variable out of commmand block.
} 5>&1
echo "$variable"
