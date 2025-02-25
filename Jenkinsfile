pipeline { 
    agent { 
        label 'vagrant'
    } 
    environment { 
        dockerImage = 'ravikharel/jenkins-project'
    }
    stages { 
        stage('Check User Groups') { 
            steps { 
                sh 'id'
                sh 'groups'
            }
        }

        stage('Build Java Application') { 
            steps { 
                sh 'mvn -f pom.xml clean package'
            }
            post { 
                success {
                    echo "Archiving the Artifacts...." 
                    archiveArtifacts artifacts: '**/*.war', followSymlinks: false
                }
            }
        }

        stage('Creating the Docker Image') { 
            steps { 
                script {
                    echo "Creating Docker image"
                    sh "docker build -t $dockerImage:$BUILD_NUMBER ."
                }
            }
        }

        stage('Tagging and Pushing the Image') { 
            steps { 
                script {
                    withDockerRegistry([credentialsId: 'dockerhub-credentials']) {
                        sh "docker push $dockerImage:$BUILD_NUMBER"
                    }
                }
            }
        }
        stage('Deploy the project'){ 
            steps{ 
                echo " Running the app on staging environment....."
                sh '''
                docker run -itd --name tomcatInstanceStaging -p 8082:8080 $dockerImage:$BUILD_NUMBER
                '''
            }
        }
    }
}
