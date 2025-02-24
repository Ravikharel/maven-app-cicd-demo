pipeline{ 
    agent any 
    stages{ 
        stage('build'){
            steps{
                
            sh 'echo HEllo world'
            } 
        }
        stage('Unit Test'){
            steps{
                
            sh 'echo Testing'
            } 
        }
        stage('build'){
            steps{
                
            sh 'echo Building an application '
            } 
        }
        stage('Package'){
            steps{
                
            sh 'echo Packaging the application'
            } 
        }
        stage('deploy'){
            steps{
                
            sh 'echo Deploying the application'
            } 
        }
    }
}