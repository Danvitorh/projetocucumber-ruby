pipeline {
    agent any

    environment {
        // Adicione aqui o caminho para onde o Homebrew instala o geckodriver
        PATH = "/opt/homebrew/bin:$PATH"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Danvitorh/projetocucumber-ruby'
            }
        }

        stage('Verificar geckodriver') {
            steps {
                sh 'which geckodriver'
                sh 'geckodriver --version'
            }
        }

        stage('Instalar dependências') {
            steps {
                // Usar configuração moderna do bundler (opcional, mas recomendado)
                sh 'bundle config set path vendor/bundle'
                sh 'bundle install'
            }
        }

        stage('Rodar testes') {
            steps {
                sh 'bundle exec cucumber'
            }
        }
    }

    post {
        always {
            echo 'Pipeline finalizada.'
        }
    }
}
