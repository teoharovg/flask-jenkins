pipeline {
  agent any
  stages {
    stage('build') {
      steps {
        sh 'sudo yum install python36u'
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
