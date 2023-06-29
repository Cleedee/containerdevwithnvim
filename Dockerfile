from alpine:3.18

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/.local/share/pypoetry/venv/bin

RUN apk update && apk upgrade --available 
RUN apk add --no-cache neovim
RUN apk add --no-cache neovim-doc
RUN apk add --update python3
RUN apk add --no-cache curl
RUN apk add --no-cache gcc
RUN apk add --no-cache python3-dev
RUN apk add --no-cache libc-dev
RUN apk add --update alpine-sdk linux-headers
RUN apk add --no-cache npm

# Instalação do Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -
RUN apk add --no-cache ripgrep

# NPM
RUN npm install -g typescript typescript-language-server
RUN npm install -g pyright

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

CMD ["tail", "-f", "/dev/null"]
