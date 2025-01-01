# demo-springboot-pipeline-test
![WhatsApp Image 2024-12-20 at 16 30 59](https://github.com/user-attachments/assets/24538f05-5616-474b-a0f0-e859b68c1e36)

# Sonar-Demo Spring Boot Project Pipeline

This repository contains a Spring Boot project with a CI/CD pipeline implemented using Jenkins. The setup includes a Dockerized application, automated build, testing, and security checks, making it production-ready.

---

## Project Overview

This project is a demo Spring Boot application demonstrating:
1. Building and deploying a Spring Boot application using Jenkins.
2. Dockerizing the application for container-based deployments.
3. Performing CI/CD tasks, including:
   - Code compilation.
   - Unit testing.
   - OWASP dependency analysis.
   - Docker image creation and pushing to a registry.

---

## Prerequisites

1. **Java Development Kit (JDK 17)**  
   The project uses OpenJDK as the base for the application.  
   Install JDK using Docker or any package manager on your system.

2. **Maven 3**  
   Required for dependency management and building the application.

3. **Jenkins**  
   Set up with the following tools configured:
   - JDK 21
   - Maven 3
   - SonarQube Scanner
   - OWASP Dependency Checker
   - Docker

4. **Docker**  
   Ensure Docker is installed and configured to build and push images.

---

## Directory Structure

```
/src                 # Source code for the Spring Boot application
/target              # Contains the built artifact (JAR file)
/Jenkinsfile         # Jenkins pipeline definition
Dockerfile           # Dockerfile to containerize the application
```

---

## Dockerfile Explanation

```dockerfile
# Use OpenJDK as the base image
FROM openjdk:17-oracle

# Identify the maintainer of the image
LABEL version="0.0.1"
LABEL maintainer="Subham Nandi"

# Set the working directory
WORKDIR /app

# Copy the JAR file into the container
COPY target/sonar-demo-0.0.1-SNAPSHOT.jar /app/sonar-demo-0.0.1-SNAPSHOT.jar

# Expose the application port
EXPOSE 8081

# Command to run the application
ENTRYPOINT ["java", "-jar", "/app/sonar-demo-0.0.1-SNAPSHOT.jar"]
```

---

## Jenkins Pipeline Overview

The Jenkins pipeline automates the following stages:

### 1. **Git Checkout**
   - Clones the main branch of the repository from GitHub.

### 2. **Code Compilation**
   - Compiles the source code using Maven.

### 3. **Unit Testing**
   - Executes the unit tests and verifies the code.

### 4. **OWASP Dependency Check**
   - Scans for vulnerabilities in project dependencies.
   - Publishes a dependency-check report.

### 5. **Build Artifact**
   - Creates the application JAR file using Maven.

### 6. **Docker Build**
   - Builds a Docker image for the application.
   - Tags the image and pushes it to a local Docker registry.

---

## Jenkinsfile

```groovy
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
        // Uncomment the following section to include SonarQube analysis
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
```

---
