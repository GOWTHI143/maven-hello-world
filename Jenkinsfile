pipeline{
    agent any
    triggers { cron('0 * * * *')}
    options { buildDiscarder(logRotator(numToKeepStr: '10'))}
    environment{
        REPO_URL="gowthi1404"} /*dockerhub reponame*/
    stages{
        stage('vcs') {
            steps{
                git url:'https://github.com/GOWTHI143/maven-hello-world.git',
                branch:'qa'
            }
        }
        stage('build'){
            steps{
                tools{jdk 'JAVA8'}
                sh"mvn package"
            }
        }
        stage('sonar_scan') {
             steps{
                withSonarQubeEnv('SONAR') {
                    sh " mvn package sonar:sonar"
                }
            }
        }
    }
}