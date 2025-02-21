pipeline{
    agent {
        label 'slave-node1'
    }
    environment {
        dockerImage = "suryaraj/devops-evening"
    }
    stages{
        stage('Build Java App'){
            agent {
              label 'slave-node1'
            }
            steps{
            sh 'mvn -f pom.xml clean package'
            }
            post{
                success {
                echo "Build completed, so archiving the war file"
                archiveArtifacts artifacts: '**/*.war', followSymlinks: false
                }
            }
        }
        stage('Create Docker image'){
            agent {
              label 'slave-node1'
           }
            steps{
              copyArtifacts filter: '**/*.war', fingerprintArtifacts: true, projectName: env.JOB_NAME, selector: specific(env.BUILD_NUMBER)
              echo "creating docker image"
              sh 'whoami'
              sh 'docker build -t $dockerImage:$BUILD_NUMBER .'
            }
        }
        stage('Trivy Scan for Docker Image') {
            steps {
                sh 'trivy image --exit-code 1 --severity HIGH,CRITICAL --ignore-unfixed $dockerImage:$BUILD_NUMBER'
            }
        }
        stage('Push Image'){
          agent {
            label 'slave-node1'
          }
            steps {
                withDockerRegistry([credentialsId: 'dockerhub-credentials', url: '']) {
                    sh '''
                    docker push $dockerImage:$BUILD_NUMBER
                    '''
                }
            }
        }
        stage('Deploy app'){
            steps{
            sh "echo Deploying the app"
            }
        }
    }
}