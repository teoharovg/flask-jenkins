
pipeline {
  agent any
  stages {
    stage('Build Docker Image') {
      when {
          branch 'master'
      }
      steps {
          script {
            app = docker.build("teoharov/flask_test")  
        }
      }
    }
   
   stage('Push Docker Image') {
        when {
            branch 'master' 
        }
        steps {
            script {
                docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                    app.push("${env.BUILD_NUMBER}")
                    app.push("latest")
                  
                }
            }
        }
   }
    
                  
    stage('DeployToProduction') {
            when {
                branch 'master'
            }
            steps {
                input 'Deploy to Production?'
                milestone(1)
                withCredentials([usernamePassword(credentialsId: 'webserver_id', usernameVariable: 'USERNAME', passwordVariable: 'USERPASS')]) {
                    script {
                        sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod_ip \"docker pull teoharov/flask_test:${env.BUILD_NUMBER}\""
                        try {
                            sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod_ip \"docker stop flask_test\""
                            sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod_ip \"docker rm flask_test\""
                        } catch (err) {
                            echo: 'caught error: $err'
                        }
                        sh "sshpass -p '$USERPASS' -v ssh -o StrictHostKeyChecking=no $USERNAME@$prod_ip \"docker run --restart always --name flask_test -p 5000:8080 -d teoharov/flask_test:${env.BUILD_NUMBER}\""
                    }
                }
            }
        }
    }
    }
