pipeline {
    agent { label 'docker-agent' }
    
    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
        timestamps()
        timeout(time: 1, unit: 'HOURS')
    }
    
    environment {
        MAVEN_HOME = '/usr/share/maven'
        JAVA_HOME = '/usr/lib/jvm/java-21-openjdk'
        PATH = "${MAVEN_HOME}/bin:${JAVA_HOME}/bin:${PATH}"
    }
    
    stages {
        /*stage('Checkout') {
            steps {
                script {
                    echo "Branche actuelle: ${BRANCH_NAME}"
                }
                checkout scm
            }
        }*/
        
        stage('Build') {
            agent {
                docker { 
                    image 'maven:3.9.6-eclipse-temurin-21'
                    // On garde juste le cache maven
                    args '-v maven-repo:/var/maven-cache'
                    reuseNode true 
                }
            }
            environment {
                MAVEN_OPTS = '-Dmaven.repo.local=/var/maven-cache'
            }
            steps {
                sh 'mvn -version' 
                sh 'mvn clean '
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
