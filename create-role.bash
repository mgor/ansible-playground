#!/usr/bin/env bash

main() {
  local role="$1"

  if [[ ! -d "./roles" ]]; then
    >&2 echo "./roles does not exist, are you in the wrong directory?"
    return 1
  fi

  if [[ -d "./roles/${role}" ]]; then
    >&2 echo "role \"${role}\" already exist"
    return 1
  fi

  mkdir -p "./roles/${role}/"{files,handlers,meta,templates,tasks,vars}

  return $?
}

main "$@"
exit $?
