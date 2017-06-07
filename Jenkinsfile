pipeline {
  agent any
  stages {
    stage('Pull repository') {
      steps {
        checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'CleanBeforeCheckout']], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'github', url: 'https://github.com/btamayo/gvgf']]])
      }
    }
    stage('Pytest') {
      steps {
        sh 'pytest'
      }
    }
  }
}
