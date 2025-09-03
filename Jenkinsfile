pipeline {
    agent any

    environment {
        PATH = "/usr/local/bin:$PATH"
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
                sh 'bundle config set path vendor/bundle'
                sh 'bundle install'
            }
        }

        stage('Rodar testes') {
            steps {
                sh '''
                export DISPLAY=:99
                bundle exec cucumber
                '''
            }
        }

        stage('Check Firefox & Geckodriver') {
            steps {
                sh 'which firefox || echo "Firefox not found"'
                sh 'firefox --version || echo "Firefox version not found"'
                sh 'which geckodriver || echo "Geckodriver not found"'
                sh 'geckodriver --version'
            }
        }
    }

    post {
        always {
            echo 'Pipeline finalizada.'
        }
    }
}
