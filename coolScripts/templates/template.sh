TEMPLATES_DIR=~/coolScripts/templates

print_usage() {
  cat <<EOF
Usage:
  $(basename "$0") [options] <language>

Copy a project/file template into the current directory (or a given destination).

Options:
  -f         Force overwrite (clobber existing files)
  -l         List available templates and exit
  -h         Show this help

Examples:
  $(basename "$0") python
EOF
}

list_templates() {
  local SUPPORTED=(python zig vhdl)
  printf "%s\n" "${SUPPORTED[@]}"
}

while getopts ":lh" opt; do
  case "$opt" in
    l) list_templates; exit 0 ;;
    h) print_usage; exit 0 ;;
    \?) echo "Unknown option: -$OPTARG" >&2; print_usage; exit 2 ;;
  esac
done
shift $((OPTIND - 1))

if [[ $# -lt 1 ]]; then
  echo "Error: missing <language>." >&2
  print_usage
  exit 2
fi

case $1 in
    "python")
        cp $TEMPLATES_DIR/py.py . ;;
    "vhdl")
        cp $TEMPLATES_DIR/vhd.vhd . ;
        cp $TEMPLATES_DIR/vhdl_ls.toml . ;;
    "zig")
        cp $TEMPLATES_DIR/zig.zig . ;;
esac
exit 0;
