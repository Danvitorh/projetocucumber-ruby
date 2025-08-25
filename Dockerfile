FROM jenkins/jenkins:lts

USER root

# Instala dependências do sistema
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    gnupg \
    libgtk-3-0 \
    libdbus-glib-1-2 \
    ruby-full \
    build-essential \
    unzip \
    xvfb \
    fontconfig \
    && rm -rf /var/lib/apt/lists/*

# Instala Firefox recente
RUN wget -q https://ftp.mozilla.org/pub/firefox/releases/117.0/linux-x86_64/en-US/firefox-117.0.tar.bz2 -O /tmp/firefox.tar.bz2 && \
    tar -xjf /tmp/firefox.tar.bz2 -C /opt/ && \
    ln -s /opt/firefox/firefox /usr/bin/firefox && \
    rm /tmp/firefox.tar.bz2

# Instala geckodriver compatível
RUN wget -q https://github.com/mozilla/geckodriver/releases/download/v0.34.0/geckodriver-v0.34.0-linux64.tar.gz && \
    tar -xzf geckodriver-v0.34.0-linux64.tar.gz && \
    mv geckodriver /usr/local/bin/ && chmod +x /usr/local/bin/geckodriver && \
    rm geckodriver-v0.34.0-linux64.tar.gz

# Bundler correto
RUN gem install bundler -v 2.6.9

# Copia Gemfile e Gemfile.lock e instala gems
COPY --chown=jenkins:jenkins Gemfile* /usr/src/app/
WORKDIR /usr/src/app
RUN bundle install --path vendor/bundle

USER jenkins
ENV PATH="/usr/src/app/vendor/bundle/bin:/usr/local/bin:$PATH"
