FROM debian:stable-slim

RUN apt-get update

RUN apt-get install -y python3
RUN apt-get install -y curl
RUN apt-get install -y gcc
RUN apt-get install -y python3-dev
RUN apt-get install -y npm
RUN apt-get install -y fd-find
RUN apt-get install -y tar
RUN apt-get install -y luarocks
RUN apt-get install -y gzip
RUN apt-get install -y unzip
RUN apt-get install -y pipx
RUN apt-get install -y ca-certificates
RUN apt-get install -y ripgrep
RUN apt-get install -y clang
RUN apt-get install -y libfuse2 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage \
    && chmod +x nvim-linux-x86_64.appimage

RUN ./nvim-linux-x86_64.appimage --appimage-extract \
    && ln -s /opt/squashfs-root/AppRun /usr/local/bin/nvim \
    && rm nvim-linux-x86_64.appimage

# Instalação do UV 
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# NPM
RUN npm install -g typescript typescript-language-server
RUN npm install -g pyright
RUN npm install -g @angular/cli
RUN npm install -g json-server
RUN npm install -g tailwindcss-language-server
RUN npm install -g tree-sitter-cli

# Python
RUN pipx install hererocks

# Criar diretório para os arquivos de configuração do Neovim
RUN mkdir -p /root/.config/nvim/lua

# Copiar arquivos de confiiguração do Neovim
# COPY config/ /root/.config/nvim/

# Copiar profile para /etc/profile
COPY ./profile /etc/profile

# Criar diretório para os projetos (deveria ser montado do host).
RUN mkdir -p /root/workspace

# Informar a localização padrão para iniciar o container
WORKDIR /root/workspace

EXPOSE 4200
EXPOSE 3000

CMD ["tail", "-f", "/dev/null"]
