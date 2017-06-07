def test_image

pipeline {
  agent any
  stages {
    stage('Build Test Env') {
      steps {
        build_image('gvgf', 'latest', 'Dockerfile')
      }
    }
    stage('Pull repository') {
      steps {
        checkout([$class: 'GitSCM', branches: [[name: '**']], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'CleanBeforeCheckout']], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'github', url: 'https://github.com/btamayo/gvgf']]])
      }
    }
    stage('Pytest') {
      steps {
        sh 'pytest'
      }
    }
  }
}

def build_image(dockerfile_path = 'Dockerfile', image_name, tag = 'latest') {
  return {
    test_image = docker.build('${image_name}:${tag}', '-f ${dockerfile_path .')
  }
}