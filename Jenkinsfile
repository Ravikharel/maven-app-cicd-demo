pipeline{
    agent any
    environment {
        dockerImage = "suryaraj/devops-evening"
    }
    stages{
        stage('Build Java App'){
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
            steps{
              copyArtifacts filter: '**/*.war', fingerprintArtifacts: true, projectName: env.JOB_NAME, selector: specific(env.BUILD_NUMBER)
              echo "creating docker image"
              sh 'whoami'
              sh 'docker build -t $dockerImage:$BUILD_NUMBER .'
            }
        }
        stage('Push Image'){
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