
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
              kubernetesDeploy(
                kubeconfigId: 'kubeconfig',
                configs: 'simple_app-kube.yml',
                enableConfigSubstitution: true
                )
            }
    }
  }
}

