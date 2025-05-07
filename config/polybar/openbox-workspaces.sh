#!/bin/bash
# Lists openbox workspaces and highlights the active one

mapfile -t lines < <(wmctrl -d)

printf "Työtila: "
for i in "${!lines[@]}"; do
  line="${lines[$i]}"
  if [[ $line == *'*'* ]]; then
    # active workspace
    printf "%%{F#ffb52a}%d%%{F-} " "$i"
  else
    printf "%d " "$i"
  fi
done
