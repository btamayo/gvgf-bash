#!/usr/bin/env groovy

pipeline {
  agent any
  stages {
    stage('Initialize environment') {
      steps {
        checkout([$class: 'GitSCM', branches: [[name: '**']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '134d1586-2a3b-4dee-8118-7376c7b4a069', url: 'https://github.com/btamayo/gvgf']]])
        load 'Jenkinsfile-Scripted'
      }
    }    
  }

}

// pipeline {
//   agent any
//   stages {
//     stage('Pull repository') {
//       steps {
//         checkout([$class: 'GitSCM', branches: [[name: '**']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '134d1586-2a3b-4dee-8118-7376c7b4a069', url: 'https://github.com/btamayo/gvgf']]])
//       }
//     }

//     stage('Build Test Env') {
//      def test_image

//       steps {
//         test_image = docker.build('gvgf:latest -f Dockerfile', '.')
//       }
//     }
//     stage('Pytest') {
//       steps {
//         test_image.inside {
//         	sh 'pytest'
//         }
//       }
//     }
//   }
// }

// def build_image(dockerfile_path = 'Dockerfile', image_name, tag = 'latest') {
//   return {
//     test_image = docker.build('${image_name}:${tag}', '-f ${dockerfile_path .')
//   }
// }