#!/bin/bash
location=Lovisa
output=$(curl -s fi.wttr.in/$location?format="%l:+%C+%t(%f)")
echo "$output"
if [ -z "$output" ]; then
    echo 'Sää: ei internetyhteyttä'
fi
