pipeline {
  agent {
    docker {
      image 'python:3.10'
    }
  }

  environment {
  }

  options {
    buildDiscarder(logRotator(numToKeepStr: '10'))
    ansiColor('xterm')
    timeout(time: 60, unit: 'MINUTES')
    disableConcurrentBuilds(abortPrevious: true)
  }

  stages {
    stage('lint') {
      steps {
        sh '''
            pip install -r requirements.txt

            set +e
            yamllint -c .yamllint.yml -f parsable . | tee yamllint.log
            ansible-lint -p --offline | tee ansible-lint.log
          '''
        recordIssues(tools: [
            ansibleLint(pattern: 'ansible-lint.log'),
            yamlLint(pattern: 'yamllint.log')
        ])
      }
    }
  }
}
