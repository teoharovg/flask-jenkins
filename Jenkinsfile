pipeline {
  agent any
  stages {
    stage('build') {
      steps {
        sh '''
        virtualenv venv --distribute
        . venv/bin/activate'
        pip install -r requirements.txt
        '''
      }
    }
    stage('test') {
      steps {
        sh 'python application.py'
      }   
    }
  }
}
