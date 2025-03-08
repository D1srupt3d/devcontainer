# Base Image
FROM cloudposse/geodesic:latest

# Disable ALL Geodesic welcome messages and MOTD
ENV GEODESIC_WELCOME=false
ENV GEODESIC_MOTD=false
ENV BANNER=""

# Metadata
LABEL org.opencontainers.image.source="https://github.com/d1srupt3d/devcontainer"
LABEL org.opencontainers.image.description="Advanced Development Environment based on Geodesic"
LABEL org.opencontainers.image.licenses="MIT"

# Remove existing MOTD and Geodesic scripts
RUN rm -f /etc/motd /etc/update-motd.d/* /etc/profile.d/banner.sh

# System Package Installation
RUN apt-get update && apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    curl \
    lsb-release \
    && apt-get update \
    # Install base packages
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    python3 \
    python3-pip \
    golang-go \
    rustc \
    cargo \
    neovim \
    ripgrep \
    # Install Node.js using n version manager
    && curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n -o n \
    && bash n lts \
    && rm n \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Development Tools Installation
# 1. GitHub CLI
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
    && apt-get install -y gh \
    && rm -rf /var/lib/apt/lists/*

# 2. Lazygit
RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') \
    && curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" \
    && tar xf lazygit.tar.gz lazygit \
    && install lazygit /usr/local/bin \
    && rm lazygit lazygit.tar.gz

# Language-specific Tools
# 1. TypeScript
RUN npm install -g typescript

# 2. Ansible
RUN pip3 install ansible

# Shell Configuration
# 1. Starship Prompt
RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes

# 2. Oh-my-zsh and Plugins
RUN git clone https://github.com/ohmyzsh/oh-my-zsh.git ~/.oh-my-zsh \
    && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
    && git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# 3. ZSH Configuration
RUN echo 'plugins=(git docker kubectl terraform aws zsh-autosuggestions zsh-syntax-highlighting)' >> ~/.zshrc \
    && echo 'eval "$(starship init zsh)"' >> ~/.zshrc

# Custom MOTD Configuration
RUN echo '\n\
    ██████╗ ███████╗██╗   ██╗ ██████╗ ██████╗ ███╗   ██╗\n\
    ██╔══██╗██╔════╝██║   ██║██╔════╝██╔═══██╗████╗  ██║\n\
    ██║  ██║█████╗  ██║   ██║██║     ██║   ██║██╔██╗ ██║\n\
    ██║  ██║██╔══╝  ╚██╗ ██╔╝██║     ██║   ██║██║╚██╗██║\n\
    ██████╔╝███████╗ ╚████╔╝ ╚██████╗╚██████╔╝██║ ╚████║\n\
    ╚═════╝ ╚══════╝  ╚═══╝   ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝\n\
\n\
                Development Environment v1.0\n' > /etc/motd \
    && echo 'cat /etc/motd' > /etc/profile.d/motd.sh \
    && chmod +x /etc/profile.d/motd.sh

# Final Configuration
WORKDIR /workspace
SHELL ["/bin/zsh", "-c"] 
