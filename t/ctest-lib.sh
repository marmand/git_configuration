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

test_sha1_cmp ()
{
  lhs=$1
  rhs=$2
  sed -i -re 's/[0-9a-f]{7}/0000000/g' ${lhs} &&
  sed -i -re 's/[0-9a-f]{7}/0000000/g' ${rhs} &&
  test_cmp ${lhs} ${rhs}
}

test_do_as ()
{
  SAVE_GIT_AUTHOR_NAME=${GIT_AUTHOR_NAME} &&
  GIT_AUTHOR_NAME=$1 &&
  shift &&
  export GIT_AUTHOR_NAME &&
  test_eval_ "$@" &&
  eval_ret=$? &&
  GIT_AUTHOR_NAME=${SAVE_GIT_AUTHOR_NAME} &&
  export GIT_AUTHOR_NAME &&
  return $eval_ret
}

test_do_in ()
{
  dir=$1 &&
  shift &&
  eval_ret= &&
  if ! test_path_is_dir "$dir"
  then
    echo "Creating $dir."
    test_create_repo "$dir"
  fi &&
  (
    cd "$dir"
    "$@"
  )
}
