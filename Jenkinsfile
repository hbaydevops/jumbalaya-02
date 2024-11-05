pipeline {
    agent any
        environment {
		DOCKERHUB_CREDENTIALS=credentials('docker-hub-auth')
	}
    options {
        buildDiscarder(logRotator(numToKeepStr: '20'))
        disableConcurrentBuilds()
        timeout(time: 60, unit: 'MINUTES')
        timestamps()
    }
    stages {
        stage('Testing') {
            agent {
                docker { image 'maven:3.8.4-eclipse-temurin-17-alpine' }
            }
            steps {
                sh '''
                cd demo-project
                mvn test
                '''
            }
        }

        stage('SonarQube Analysis') {
            agent {
                docker { image 'sonarsource/sonar-scanner-cli:5.0.1' }
            }
            environment {
                CI = 'true'
                scannerHome = '/opt/sonar-scanner'
            }
            steps {
                withSonarQubeEnv('sonar') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }

        
        stage('Login') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }

        stage('Build+push Image') {
            steps {
                sh '''
                cd ${WORKSPACE}/demo-project
                docker build -t thejurist/demo_project:${BUILD_NUMBER} .
                docker push thejurist/demo_project:${BUILD_NUMBER}
                '''
            }
        }

    }
        stage('Update Image Tag in Helm Repo for ArgoCD') {
            steps {
                // Update the values.yaml file with the new Docker image tag
                sh """
                sed -i 's/tag:.*/tag: ${IMAGE_TAG}/' ./demo-project/chart/values.yaml
                """

                // Commit and push the changes
                sh """
                git config user.email "gbebejunior@gmail.com"
                git config user.name "Djurizt"
                git add ./demo-project/chart/values.yaml
                git commit -m "Update image tag to ${IMAGE_TAG}"
                git push origin main
                """
            }
        }
    
    post {
        success {
            echo "Image built, pushed, and ArgoCD will automatically deploy the new version."
        }
        failure {
            echo "Deployment failed!"
        }
    }
}
