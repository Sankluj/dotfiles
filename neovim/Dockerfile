FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:neovim-ppa/stable && \
    apt-get update && \
    apt-get install -y \
      neovim \
      python3-dev \
      git \
      curl \
      build-essential \
      cmake

# Installing node
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

# Remove ppa and clean apt install files
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create a user
RUN useradd -ms /bin/bash newuser
USER newuser
WORKDIR /home/newuser

# Create directories and add init files
RUN mkdir -p ~/.config/nvim

# Get Vundle
RUN mkdir ~/.config/nvim/bundle
RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim

# Install the plugins first
ADD --chown=newuser ./init.vim.install .config/nvim/init.vim
RUN nvim -c 'PluginInstall' -c 'qa!'
RUN ~/.vim/bundle/youcompleteme/install.py --ts-completer
# Concat the plugins configuration file to the init file
ADD --chown=newuser ./init.vim.final .config/nvim
RUN cat ~/.config/nvim/init.vim.final >> ~/.config/nvim/init.vim
RUN rm ~/.config/nvim/init.vim.final

# Define default work directory
WORKDIR /data
# Define default command.
ENTRYPOINT [ "nvim" ]
