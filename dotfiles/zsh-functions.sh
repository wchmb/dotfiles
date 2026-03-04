list() {
  # Inspired by gdb/lldb list: peek at the context around a line
  # Do a `grep` and use the results with `list`
  # e.g: list src/mycode.c:34
  local file="${1%:*}"
  local line="${1##*:}"
  local start=$((line - 5))
  local end=$((line + 5))

  [ $start -lt 1 ] && start=1

  sed -n "${start},${end}p;$((end + 1))q" "$file"
}
alias l='list'
