pipeline{
    agent any
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
              sh 'docker build -t localtomcatimg:$BUILD_NUMBER .'
            }
        }
        stage('Package'){
            steps{
            sh "echo Packaging application"
            }
        }
        stage('Deploy app'){
            steps{
            sh "echo Deploying the app"
            }
        }
    }
}