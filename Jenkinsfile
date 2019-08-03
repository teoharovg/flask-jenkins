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
        archiveArtifacts artifacts: 'dist/trainSchedule.zip'

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
                                        sourceFiles: 'dist/trainSchedule.zip',
                                        removePrefix: 'dist/',
                                        remoteDirectory: '/tmp',
                                        execCommand: 'virtualenv venv --distribute && . venv/bin/activate && pip install -r requirements.txt && unzip /tmp/trainSchedule.zip -d /opt/train-schedule && python application.py'
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
  }
}
