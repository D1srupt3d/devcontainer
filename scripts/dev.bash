#!/bin/bash

function dev {
    local CONTAINER_NAME="devcontainer"
    local MOUNT_PATH="${1:-$(pwd)}"
    local IMAGE="ghcr.io/d1srupt3d/devcontainer:latest"

    # Check if Docker is running
    if ! docker info >/dev/null 2>&1; then
        echo "Error: Docker is not running"
        return 1
    fi

    docker run -it \
        --name "${CONTAINER_NAME}-$(basename ${MOUNT_PATH})" \
        --rm \
        -v "${MOUNT_PATH}:/workspace" \
        -v "${HOME}/.aws:/root/.aws" \
        -v "${HOME}/.ssh:/root/.ssh" \
        -v "${HOME}/.gitconfig:/root/.gitconfig" \
        -v /var/run/docker.sock:/var/run/docker.sock \
        -e AWS_PROFILE \
        -e AWS_DEFAULT_REGION \
        -e GITHUB_TOKEN \
        -w /workspace \
        --network host \
        "${IMAGE}"
}

# Bash completion for the dev command
_dev_completion() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -d -- "$cur") )
}
complete -F _dev_completion dev

alias dev='dev' 