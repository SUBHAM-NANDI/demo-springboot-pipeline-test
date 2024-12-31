pipeline {
    agent any

    tools {
        jdk "jdk21"
        maven "maven3"
    }

    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }

    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', changelog: false, poll: false, url: 'https://github.com/SUBHAM-NANDI/demo-springboot-pipeline-test.git'
            }
        }
        stage('Code Compile') {
            steps {
                bat "mvn clean compile"
            }
        }
        stage('Unit Test') {
            steps {
                bat "mvn test"
            }
        }
        // stage('Sonarqube Analysis') {
        //     steps {
        //         withSonarQubeEnv('sonar-server') {
        //             bat """
        //             "${SCANNER_HOME}\\bin\\sonar-scanner" ^
        //             -D"sonar.projectName=demo-springboot-pipeline-test" ^
        //             -D"sonar.java.binaries=." ^
        //             -D"sonar.projectKey=demo-springboot-pipeline-test"
        //             """
        //         }
        //     }
        // }
        stage('OWASP Dependency Check') {
            steps {
                dependencyCheck additionalArguments: ' --scan ./ ', odcInstallation: 'dependency-check'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }
        stage('Build Artifact') {
            steps {
                bat "mvn clean install"
            }
        }
        stage('Docker Build') {
            steps {
                script {
                    withDockerRegistry(credentialsId: '219893d6-9473-4660-8a2e-b6d192b8139e', toolName: 'docker') {
                        bat "docker build -t sonar-demo-0.0.1.jar ."
                        bat "docker tag sonar-demo-0.0.1.jar localhost:5000/sonar-demo"
                        bat "docker push localhost:5000/sonar-demo"
                    }
                } 
            }
        }
    }
}
