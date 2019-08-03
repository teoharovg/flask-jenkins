pipeline {
  agent any
  stages {
    stage('build') {
      steps {
        sh '''
        virtualenv venv --distribute
        . venv/bin/activate
        pip install -r requirements.txt
        '''
        archiveArtifacts artifacts: 'requirements.txt'

      }
    }
     stage('DeployToStaging') {
            when {
                branch 'master'
            }
            steps {
                withCredentials([usernamePassword(credentialsId: 'webserver_login', usernameVariable: 'USERNAME', passwordVariable: 'USERPASS')]) {
                    sshPublisher(
                        failOnError: true,
                        continueOnError: false,
                        publishers: [
                            sshPublisherDesc(
                                configName: 'staging',
                                sshCredentials: [
                                    username: "$USERNAME",
                                    encryptedPassphrase: "$USERPASS"
                                ], 
                                transfers: [
                                    sshTransfer(
                                        sourceFiles: 'application.py',
                                        remoteDirectory: '/tmp',
                                        execCommand: 'cd /tmp/ && pip install -r requirements.txt && python application.py'
                                    )
                                ]
                            )
                        ]
                    )
                }
            }
        }
      }   
    }
