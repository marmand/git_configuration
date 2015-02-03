configurate_with ()
{
  inc="$1"
  out="$2"
  cat >header <<-EOF &&
    [alias]
EOF
  cat header ../../../${inc}.inc >${out}
}
