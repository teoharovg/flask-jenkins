pipeline {
  agent any
  stages {
    stage('build') {
      steps {
        sh 'virtualenv venv --distribute'
        sh '. venv/bin/activate'
        sh 'pip install -r requirements.txt'
      }
    }
    stage('test') {
      steps {
        sh 'python application.py'
      }   
    }
  }
}
