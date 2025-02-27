# Advanced Development Container

This repository contains a VS Code Development Container configuration based on CloudPosse's Geodesic image, enhanced with additional development tools and features.

[![Build Dev Container](https://github.com/d1srupt3d/devcontainer/actions/workflows/container_build.yml/badge.svg)](https://github.com/d1srupt3d/devcontainer/actions/workflows/container_build.yml)

## Features

- Based on CloudPosse Geodesic:
  - Terraform
  - AWS CLI
  - kubectl
  - helm
  - helmfile
  - chamber
  - gomplate
  - yq
  - jq
  - sops
  - goofys
  - and [many more](https://github.com/cloudposse/geodesic)
- Pre-installed development tools:
  - Python 3 with pip
  - Go
  - Rust with Cargo
  - TypeScript/Node.js (via n version manager)
  - GitHub CLI (gh)
  - Lazygit
  - Neovim
  - Ripgrep
  - Ansible
- Customized ZSH shell with:
  - Starship prompt
  - Oh-my-zsh with plugins:
    - git
    - docker
    - kubectl
    - terraform
    - aws
    - zsh-autosuggestions
    - zsh-syntax-highlighting
- Custom MOTD (Message of the Day)

## Usage

### Local Development

1. Install VS Code and Docker
2. Install the "Remote - Containers" extension
3. Clone this repository
4. Open in VS Code and click "Reopen in Container"

### Using Pre-built Container

```bash
# Pull the container
docker pull ghcr.io/d1srupt3d/devcontainer:latest

# Run the container
docker run -it \
    -v $(pwd):/workspace \
    -v ~/.aws:/root/.aws \
    -v ~/.ssh:/root/.ssh \
    -v ~/.gitconfig:/root/.gitconfig \
    -v /var/run/docker.sock:/var/run/docker.sock \
    ghcr.io/d1srupt3d/devcontainer:latest
```

### Quick Start with `dev` Command

1.Download the appropriate script for your shell:

For Bash users:

```bash
mkdir -p ~/.local/bin
curl -o ~/.local/bin/dev.bash https://raw.githubusercontent.com/d1srupt3d/devcontainer/main/scripts/dev.bash
chmod +x ~/.local/bin/dev.bash
```

For Zsh users:

```bash
mkdir -p ~/.local/bin
curl -o ~/.local/bin/dev.zsh https://raw.githubusercontent.com/d1srupt3d/devcontainer/main/scripts/dev.zsh
chmod +x ~/.local/bin/dev.zsh
```

2.Add to your shell configuration:

For Bash (~/.bashrc):

```bash
source ~/.local/bin/dev.bash
```

For Zsh (~/.zshrc):

```bash
source ~/.local/bin/dev.zsh
```

3.Reload your shell configuration:

```bash
# For Bash
source ~/.bashrc

# For Zsh
source ~/.zshrc
```

4.Use the container:

```bash
# Start container in current directory
dev

# Or specify a directory
dev /path/to/project
```

Features of the `dev` command:

- Shell completion for directory paths
- Automatic Docker daemon check
- Mounts common configuration directories:
  - AWS credentials (~/.aws)
  - SSH keys (~/.ssh)
  - Git config (~/.gitconfig)
- Passes through common environment variables
- Uses host network for local development
- Automatically removes container on exit

## Updates

This container is automatically built and published to GitHub Container Registry. You can find the latest version at `ghcr.io/d1srupt3d/devcontainer:latest`.
