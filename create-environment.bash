#!/usr/bin/env bash

main() {
    for i in {0..2}; do
        if ! multipass info "ansible0${i}"; then
            multipass launch --name "ansible0${i}"

            if (( i == 0 )); then
                ssh-keygen -t ed25519 -f ./.ssh/id_ansible -q N ""
                multipass mount ./ ansible00:/home/ubuntu/ansible
                multipass exec ansible00 -- bash <<EOF
  ssh-agent bash
  ssh-add /home/ubuntu/ansible/.ssh/id_ansible
  sudo apt install -y software-properties-common
  sudo add-apt-repository -y ppa:ansible/ansible
  sudo apt update
  sudo apt install -y ansible
EOF
            fi
        fi
    done

    return 0
}

main "$@"
return $?
