pipeline {
  agent any
  stages {
    stage('build') {
      steps {
        sh 'sudo yum install \
            zlib-devel \
            bzip2 \
            bzip2-devel \
            readline-devel \
            sqlite \
            sqlite-devel \
            openssl-devel \
            xz \
            xz-devel \
            libffi-devel'
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
