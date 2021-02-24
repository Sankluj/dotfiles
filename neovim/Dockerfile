FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:neovim-ppa/stable && \
    add-apt-repository -y ppa:longsleep/golang-backports && \
    apt-get update && \
    apt-get install -y \
      neovim \
      python3-dev \
      git \
      curl \
      build-essential \
      cmake \
      golang-go

# Installing node
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

# Remove ppa and clean apt install files
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Installing eslint globally
RUN npm install -g eslint eslint-plugin-prettier eslint-plugin-react

# Create directories and add init files
RUN mkdir /root/.config/nvim
ADD ./init.vim.install /root/.config/nvim

# Get Vundle
RUN mkdir /root/.config/nvim/bundle
RUN git clone https://github.com/VundleVim/Vundle.vim.git /root/.config/nvim/bundle/Vundle.vim

# Install the plugins first
RUN mv /root/.config/nvim/init.vim.install /root/.config/nvim/init.vim
RUN nvim -c 'PluginInstall' -c 'qa!'
RUN nvim -c 'GoInstallBinaries' -c 'qa!'
RUN ./root/.vim/bundle/youcompleteme/install.py --ts-completer
# Concat the plugins configuration file to the init file
ADD ./init.vim.final /root/.config/nvim
RUN cat /root/.config/nvim/init.vim.final >> /root/.config/nvim/init.vim
RUN rm /root/.config/nvim/init.vim.final

# Define working directory.
WORKDIR /data

# Define default command.
ENTRYPOINT [ "nvim" ]
