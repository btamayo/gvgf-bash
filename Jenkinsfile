node {
    def test_image

    stage('Pull repo') {
        checkout([$class: 'GitSCM', branches: [[name: '**']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '134d1586-2a3b-4dee-8118-7376c7b4a069', url: 'https://github.com/btamayo/gvgf']]])
    }

	stage('Print ENV') {
        echo sh(returnStdout: true, script: 'env')
	}

  stage('Build Test Docker Image') {
  	test_image = docker.build('python_test', ' -f Dockerfile .')
  }

  stage('Run tests inside test image') {
      test_image.inside {
          sh(returnStdout: true, script: 'mono GitVersion_3.6.5/GitVersion.exe')
          sh('pytest')
          // @TODO: Pytest exit code 5 means no tests were found
      }
  }
}
