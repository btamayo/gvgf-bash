node {
  def test_image

  stage('Print ENV') {
    echo sh(returnStdout: true, script: 'env')
  }

  stage('Pull test image from repo') {
    test_image = docker.image('btamayo/python_test')
    test_image.pull()
  }

  stage('Test Env: Pull repo') {
    test_image.inside {
      checkout([$class: 'GitSCM', branches: [[name: '**']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '134d1586-2a3b-4dee-8118-7376c7b4a069', url: 'https://github.com/btamayo/gvgf']]])
    }
  }

  stage('Test') {
    test_image.inside {
      gitversion_json = sh(returnStdout: true, script: 'mono GitVersion_3.6.5/GitVersion.exe')
      echo gitversion_json
      sh('./setup_docker_testenv.sh')
      // @TODO: Pytest exit code 5 means no tests were found
      echo sh('pwd')
      echo sh('ls -Al')
      sh('cd gvgf/tests && && ls -Al && pytest --junitxml=report.xml')
      junit '*.xml'
    }
  }
}
