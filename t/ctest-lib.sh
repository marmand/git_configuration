configurate_with ()
{
  inc="$@"
  out=".git/config"
  cat >header <<-EOF &&
[alias]
EOF
  for include in ${inc}
  do
    cat ../../../${include}.inc >>tmp
  done &&
  cat header tmp >>${out} &&
  rm header tmp
}
