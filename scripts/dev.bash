#!/bin/bash

dev() {
    local workspace=${1:-$(pwd)}
    
    # Get host user/group IDs
    local USER_ID=$(id -u)
    local GROUP_ID=$(id -g)
    
    # Check if Docker is running
    if ! docker info >/dev/null 2>&1; then
        echo "Docker is not running. Please start Docker first."
        return 1
    }

    # Run the container with user mapping
    docker run -it --rm \
        -v "${workspace}:/workspace" \
        -v "${HOME}/.aws:/home/dev/.aws" \
        -v "${HOME}/.ssh:/home/dev/.ssh" \
        -v "${HOME}/.gitconfig:/home/dev/.gitconfig" \
        -v "${HOME}/.config/starship.toml:/home/dev/.config/starship.toml" \
        -v "${HOME}/.zshrc:/home/dev/.zshrc" \
        -v "/:/host" \
        -v "/var/run/docker.sock:/var/run/docker.sock" \
        --network host \
        -e "HOST_PATH=${workspace}" \
        -e "HOST_HOME=${HOME}" \
        -e "HOST_OS=$(uname)" \
        -e "LOCAL_USER_ID=${USER_ID}" \
        -e "LOCAL_GROUP_ID=${GROUP_ID}" \
        ghcr.io/d1srupt3d/devcontainer:latest
}

# Enable tab completion for directories
complete -d dev

# Bash completion for the dev command
_dev_completion() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -d -- "$cur") )
}
complete -F _dev_completion dev

alias dev='dev' 