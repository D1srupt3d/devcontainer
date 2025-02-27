#!/bin/zsh

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
        --name "${CONTAINER_NAME}-${MOUNT_PATH:t}" \
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

# ZSH completion for the dev command
_dev() {
    _arguments '1:directory:_path_files -/'
}
compdef _dev dev

alias dev='dev' 