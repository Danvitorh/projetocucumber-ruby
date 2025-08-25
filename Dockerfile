# Usa a imagem oficial do Jenkins como base
FROM jenkins/jenkins:lts

# Troca para o usuário root (para poder instalar pacotes)
USER root

# Instala Firefox e dependências do Ruby
RUN apt-get update && \
    apt-get install -y firefox-esr ruby-full build-essential && \
    rm -rf /var/lib/apt/lists/*

# Instala o Bundler na versão que seu projeto pede
RUN gem install bundler -v 2.6.9

# Volta para o usuário padrão do Jenkins
USER jenkins
