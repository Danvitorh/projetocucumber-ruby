pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/Danvitorh/projetocucumber-ruby'
            }
        }

        stage('Instalar dependências') {
            steps {
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
