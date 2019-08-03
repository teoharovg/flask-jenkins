pipeline {
  agent any
  stages {
    stage('build') {
      steps {
        sh 'yum install python36u python36u-libs python36u-devel python36u-pip'
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
