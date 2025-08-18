FROM jenkins/jenkins:lts

USER root

# Instalar Ruby e dependências
RUN apt-get update && \
    apt-get install -y ruby-full build-essential git && \
    gem install bundler

USER jenkins