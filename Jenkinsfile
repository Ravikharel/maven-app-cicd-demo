pipeline{ 
    agent any 
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
                copyArtifacts filter: '**/*.war', fingerprintArtifacts: true, projectName: env.Jobname, target: '/',selector : specific(env.BUILDNUMBER)
                echo "Creating Docker images"
                sh "docker image build -t localimage:$BUILDNUMBER ."
            }
        }
    }
}