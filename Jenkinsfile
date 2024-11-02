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
                docker { image 'maven:3.8.7-openjdk-18' }
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
                docker build -t thejurist/demo_project:001 .
                
                '''
            }
        }
        //         stage('Build+push Image') {
        //     steps {
        //         sh '''
        //         cd ${WORKSPACE}/demo-project
        //         docker build -t thejurist/demo_project:001 .
        //         docker push thejurist/demo_project:001
        //         '''
        //     }
        // }
    }

    post {
        success {
            slackSend(channel: '#development-alerts', color: 'good', message: "SUCCESSFUL: Application s7yusuff-do-it-yourself-Cart Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        }
        unstable {
            slackSend(channel: '#development-alerts', color: 'warning', message: "UNSTABLE: Application s7yusuff-do-it-yourself-Cart Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        }
        failure {
            slackSend(channel: '#development-alerts', color: '#FF0000', message: "FAILURE: Application s7yusuff-do-it-yourself-Cart Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        }
        cleanup {
            deleteDir()
        }
    }
}
