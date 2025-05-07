#!/bin/bash
# This script is used to check the VRAM usage of the GPU.
# prints used/total VRAM in MB

smi=$(nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader)
# replace comma with /
smi=$(sed 's/, /\//g' <<< "$smi")
printf "$smi"
