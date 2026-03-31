pipeline {
    agent { label 'Jenkins-Agent' }

    tools {
        maven 'Maven'
        jdk 'JDK17'
    }

    environment {
        DOCKER_IMAGE = "sandeep2862/demo-spring-boot-app:${BUILD_NUMBER}"
        SONAR_URL = "http://3.25.89.170:9000/" // Your SonarQube IP
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/sandeepaksm/demo-spring-boot-app.git'
            }
        }

        stage('Build & Test') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Static Code Analysis') {
            steps {
                // Ensure you have a 'sonarqube-token' credential in Jenkins
                withCredentials([string(credentialsId: 'sonarqube-token', variable: 'SONAR_AUTH_TOKEN')]) {
                    sh "mvn sonar:sonar -Dsonar.login=${SONAR_AUTH_TOKEN} -Dsonar.host.url=${SONAR_URL}"
                }
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    // Requires Docker installed on Jenkins-Agent
                    sh "docker build -t ${DOCKER_IMAGE} ."

                    withCredentials([usernamePassword(credentialsId: 'docker-hub-cred', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                        sh "echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin"
                        sh "docker push ${DOCKER_IMAGE}"
                    }
                }
            }
        }

        stage('Update K8s Manifest') {
    steps {
        withCredentials([string(credentialsId: 'github-token', variable: 'GITHUB_TOKEN')]) {
            sh """
                git config user.email "sandeepaksm@gmail.com"
                git config user.name "sandeepaksm"
                
                # Update the image tag
                sed -i 's|image: .*/demo-spring-boot-app:.*|image: sandeep2862/demo-spring-boot-app:${BUILD_NUMBER}|g' k8s/deployment.yaml
                
                # Only commit and push if the file was actually changed
                if ! git diff --exit-code k8s/deployment.yaml; then
                    git add k8s/deployment.yaml
                    git commit -m "Update image to version ${BUILD_NUMBER}"
                    git push https://${GITHUB_TOKEN}@github.com/sandeepaksm/demo-spring-boot-app.git HEAD:master
                else
                    echo "No changes detected in deployment.yaml. Skipping commit."
                fi
            """
        }
    }
}
    }
}
