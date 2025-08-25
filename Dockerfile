# Base: Jenkins LTS oficial
FROM jenkins/jenkins:lts

# Troca para root para instalar pacotes
USER root

# Instala dependências do sistema
RUN apt-get update && \
    apt-get install -y \
        wget \
        curl \
        gnupg \
        libgtk-3-0 \
        libdbus-glib-1-2 \
        ruby-full \
        build-essential \
        unzip \
        x11-utils \
        xvfb \
        fontconfig && \
    rm -rf /var/lib/apt/lists/*

# Instala Firefox (versão recente, não ESR)
RUN wget -qO- https://ftp.mozilla.org/pub/firefox/releases/117.0/linux-x86_64/en-US/firefox-117.0.tar.bz2 | tar xjf - -C /opt/ && \
    ln -s /opt/firefox/firefox /usr/bin/firefox

# Instala geckodriver compatível com Firefox 117
RUN wget -q https://github.com/mozilla/geckodriver/releases/download/v0.34.0/geckodriver-v0.34.0-linux64.tar.gz && \
    tar -xzf geckodriver-v0.34.0-linux64.tar.gz && \
    mv geckodriver /usr/local/bin/ && \
    chmod +x /usr/local/bin/geckodriver && \
    rm geckodriver-v0.34.0-linux64.tar.gz

# Instala o Bundler na versão correta (2.7.1 para compatibilidade com Gemfile.lock)
RUN gem install bundler -v 2.7.1

# Instala gems essenciais do projeto
# Copie o Gemfile e Gemfile.lock primeiro para cache eficiente
COPY --chown=jenkins:jenkins Gemfile* /usr/src/app/
WORKDIR /usr/src/app
RUN bundle install --path vendor/bundle

# Volta para usuário Jenkins
USER jenkins

# Define PATH para gems e geckodriver
ENV PATH="/usr/src/app/vendor/bundle/bin:/usr/local/bin:$PATH"
