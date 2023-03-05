pipeline {
    agent any
    triggers { cron('0 * * * *') }
    options { buildDiscarder(logRotator(numToKeepStr: '10')) }
    environment {
        REPO_URL = 'gowthi1404'}
        // dockerhub = credentials('Docker')} /*dockerhub reponame*/
    stages {
        stage('vcs') {
            steps {
                git url:'https://github.com/GOWTHI143/maven-hello-world.git',
                branch:'qa'
            }
        }
        stage('build') {
            tools { jdk 'JAVA8' }
            steps {
                sh'''cd my-app
                    mvn package'''
            }
        }
        stage('sonar_scan') {
            steps {
                withSonarQubeEnv('SONAR') {
                    sh ''' cd my-app
                    mvn package sonar:sonar'''
                }
            }
        }
        stage('build image') {
            steps {
                script {
                    sh """ docker image build -t ${env.REPO_URL}/mvn-hello-${GIT_BRANCH}:${env.BUILD_NUMBER} .
                    """
                }
            }
        }
        stage('Pushing image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'Docker', passwordVariable: 'docker_pass', usernameVariable: 'docker_user')]) {
                    sh "docker login -u=${docker_user} -p=${docker_pass}" } }
                    sh"""docker image push ${env.REPO_URL}/mvn-hello-${GIT_BRANCH}:${env.BUILD_NUMBER}"""
                }
            }
        }
    }
