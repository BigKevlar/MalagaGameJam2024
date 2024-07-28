#!/bin/sh
echo -ne '\033c\033]0;una_sombra_en_el_polo\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Una Sombra en El Polo.exe.x86_64" "$@"
