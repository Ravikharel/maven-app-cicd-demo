pipeline{ 
    agent any 
    environment { 
        dockerImage='ravikharel/jenkins-project'
    }
    stages{ 
        stage('Build Java application'){ 
            steps{ 
                sh 'mvn -f pom.xml clean package'
            }
            post{ 
                success{
                    echo "Archiving the Artifacts...." 
                    archiveArtifacts artifacts: '**/*.war', followSymlinks: false

                }
            }
        }
        stage('Creating the docker image'){ 
            steps{ 
                copyArtifacts filter: '**/*.war', fingerprintArtifacts: true, projectName: env.JOB_NAME, selector: specific(env.BUILD_NUMBER) 
                echo "Creating Docker images"
                sh "docker image build -t $dockerImage:$BUILD_NUMBER ."
            }
        }
        stage('tagging and pushing the images'){ 
            steps{ 
                withDockerRegistry([credentialsId: 'dockerhub-credentials',url : '']){
                    sh '''
                    docker push $dockerImage:v1
                    '''
                }
            }
        }
    }
}