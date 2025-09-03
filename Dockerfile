# =============================================
# Dockerfile para Jenkins + Ruby 3.2 + Firefox ESR
# =============================================

# Base: Jenkins LTS
FROM jenkins/jenkins:lts

# Troca para root para instalar pacotes
USER root

# Atualiza pacotes e instala dependências do sistema
RUN apt-get update && \
    apt-get install -y \
    wget \
    curl \
    gnupg \
    unzip \
    build-essential \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    libyaml-dev \
    libsqlite3-dev \
    sqlite3 \
    libxml2-dev \
    libxslt1-dev \
    libcurl4-openssl-dev \
    software-properties-common \
    libffi-dev \
    libgdbm-dev \
    libncurses5-dev \
    automake \
    libtool \
    bison \
    libicu-dev \
    ca-certificates \
    git \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# Instalar Firefox ESR
RUN apt-get update && \
    apt-get install -y firefox-esr && \
    rm -rf /var/lib/apt/lists/*

# Instalar Geckodriver
RUN GECKO_VERSION="0.34.0" && \
    wget https://github.com/mozilla/geckodriver/releases/download/v${GECKO_VERSION}/geckodriver-v${GECKO_VERSION}-linux64.tar.gz && \
    tar -xvzf geckodriver-v${GECKO_VERSION}-linux64.tar.gz && \
    mv geckodriver /usr/local/bin/ && \
    chmod +x /usr/local/bin/geckodriver && \
    rm geckodriver-v${GECKO_VERSION}-linux64.tar.gz

# Instalar RVM e Ruby 3.2
RUN curl -sSL https://get.rvm.io | bash -s stable --ruby=3.2

# Adicionar RVM ao PATH
ENV PATH="/usr/local/rvm/bin:/usr/local/rvm/rubies/ruby-3.2.2/bin:$PATH"

# Instalar Bundler
RUN gem install bundler -v 2.7.1

# Voltar para usuário Jenkins
USER jenkins

# Definir diretório de trabalho
WORKDIR /var/jenkins_home/workspace

# Mensagem final
CMD ["bash"]
