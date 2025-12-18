pipeline {
    agent { label 'docker-agent' }
    
    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
        timestamps()
        timeout(time: 1, unit: 'HOURS')
    }
    
    environment {
        MAVEN_HOME = '/usr/share/maven'
        JAVA_HOME = '/opt/java/openjdk'
        PATH = "${MAVEN_HOME}/bin:${JAVA_HOME}/bin:${PATH}"
    }
    
    stages {
       
/*         stage('Build') {
            agent {
                docker { 
                    image 'maven:3.9.6-eclipse-temurin-21'
                    args '-v maven-repo:/tmp/workspace/maven-cache'
                    reuseNode true 
                }
            }
            environment {
                MAVEN_OPTS = '-Dmaven.repo.local=/tmp/workspace/maven-cache'
            }
            steps {
                sh 'mvn compile'
            }
            
        }

        stage('Deploy Artifact') {
            agent {
                docker { 
                    image 'maven:3.9.6-eclipse-temurin-21'
                    args '-v maven-repo:/tmp/workspace/maven-cache'
                    reuseNode true 
                }
            }
            environment {
                MAVEN_OPTS = '-Dmaven.repo.local=/tmp/workspace/maven-cache'
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'jenkins2nexus-deployement', usernameVariable: 'MAVEN_USER', passwordVariable: 'MAVEN_PWD')]) {
                    sh 'mvn deploy -Djenkins-username=$MAVEN_USER -Djenkins-pwd=$MAVEN_PWD -s settings.xml' 
                }
            }
        } */
        stage('Build Site') {
            agent {
                docker { 
                    image 'maven:3.9.6-eclipse-temurin-21'
                    args '-v maven-repo:/tmp/workspace/maven-cache'
                    reuseNode true 
                }
            }
            environment {
                MAVEN_OPTS = '-Dmaven.repo.local=/tmp/workspace/maven-cache'
            }
            steps {
                sh 'mvn site:site'
            }
        }
        stage('Deploy Site') {
            agent {
                docker { 
                    image 'maven:3.9.6-eclipse-temurin-21'
                    args '-v maven-repo:/tmp/workspace/maven-cache'
                    reuseNode true 
                }
            }
            environment {
                MAVEN_OPTS = '-Dmaven.repo.local=/tmp/workspace/maven-cache'
            }
            steps {
                sh 'mvn site:deploy -Ddeploy-siteweb-url=http://home_tc-public-share/projets/ -s settings.xml'
            }
        }
        
        
    }
    
    post {
       
        success {
            echo "✅ Build réussi pour la branche ${BRANCH_NAME}"
            script {
                echo "Nettoyage des ressources..."
            }
            cleanWs()
        }
        
        failure {
            echo "❌ Build échoué pour la branche ${BRANCH_NAME}"
        }
        
        unstable {
            echo "⚠️ Build instable pour la branche ${BRANCH_NAME}"
        }
    }
}
