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
                    image 'alpine:latest'
                    reuseNode true 
                }
            }
            steps {
                script {
                    echo "📤 Déploiement du site Maven via SCP vers https://collonvillethomas.freeboxos.fr/public/projets/"
                    
                    // Déployer le site généré via SCP avec clé SSH
                    withCredentials([sshUserPrivateKey(credentialsId: 'home-ssh-key', keyFileVariable: 'SSH_KEY', usernameVariable: 'SITE_USER')]) {
                        sh '''
                            # Installer openssh-client dans Alpine
                            apk add --no-cache openssh-client
                            
                            # Créer un répertoire temporaire pour la clé SSH
                            mkdir -p ~/.ssh
                            cp $SSH_KEY ~/.ssh/id_rsa
                            chmod 600 ~/.ssh/id_rsa
                            
                            # Ajouter le serveur aux hosts connus (éviter la confirmation)
                            ssh-keyscan -H 192.168.0.132 >> ~/.ssh/known_hosts 2>/dev/null || true
                            pwd
                            cd  /tmp/workspace/tc-parent_${BRANCH_NAME}/target
                            scp -r ./ ${SITE_USER}@192.168.0.132:/mnt/nfs_storage_client/docker_share/tc-public-share/html/projets/

                            # Nettoyer la clé temporaire
                            rm -f ~/.ssh/id_rsa
                            
                            echo "✅ Site déployé avec succès sur https://collonvillethomas.freeboxos.fr/public/projets/"
                        '''
                    }
                }
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
