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
    }
}