FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:neovim-ppa/unstable && \
    apt-get update && \
    apt-get install -y \
      neovim \
      python-dev \
      python-pip \
      git

RUN pip install --user neovim

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create directories and add init files
RUN mkdir /root/.config
RUN mkdir /root/.config/nvim
ADD . /root/.config/nvim

# Get Vundle
RUN mkdir /root/.config/nvim/bundle
RUN git clone https://github.com/VundleVim/Vundle.vim.git /root/.config/nvim/bundle/Vundle.vim

# Install the plugins first
RUN mv /root/.config/nvim/init.vim.install /root/.config/nvim/init.vim
RUN nvim -c 'PluginInstall' -c 'qa!'
# Concat the plugins configuration file to the init file
RUN cat /root/.config/nvim/init.vim.final >> /root/.config/nvim/init.vim
RUN rm /root/.config/nvim/init.vim.final

# Define working directory.
WORKDIR /data

# Define default command.
ENTRYPOINT [ "nvim" ]
