pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo "stage 1"
                echo 'Building..'
            }
        }
        stage('Test') {
            steps {
                echo "stage 2"
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo "stage 3"
                echo 'Deploying....'
            }
        } 
    }
    post{
        
    }
}