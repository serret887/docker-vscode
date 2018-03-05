FROM ubuntu:16.04

ARG NODE_VERSION=9

RUN echo 'Installing OS dependencies' \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y curl make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev gcc libxml2-dev libxslt1-dev python3-pip python3-dev python3-tk \
    git 

RUN echo "Installing nodejs" \
    && curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
    && apt-get install -y nodejs 

RUN echo "Installing Python Environment"  \
    && git clone https://github.com/pyenv/pyenv.git ~/.pyenv \
    && git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv \
    && echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc \
    && echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc \
    && echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc \
    && echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile \
    && /bin/bash -c "source ${HOME}/.bashrc"
    
RUN echo "Installing VS CODE" \
    && curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
    && mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg \
    && sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' \
    && apt-get update \
    && apt-get install code -y\