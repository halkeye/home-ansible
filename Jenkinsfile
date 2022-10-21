pipeline {
  agent {
    docker {
      image 'python:3.10'
    }
  }

  environment {
    ANSIBLE_VAULT_FILE = credentials('ansible-vault')
    HOME = "${WORKSPACE}"
  }

  options {
    buildDiscarder(logRotator(numToKeepStr: '10'))
    ansiColor('xterm')
    timeout(time: 60, unit: 'MINUTES')
    disableConcurrentBuilds(abortPrevious: true)
  }

  triggers {
    cron(env.BRANCH_NAME == 'master' ? 'H/30 * * * *' : '')
  }



  stages {
    stage('lint') {
      steps {
        sh '''
            export PATH="${HOME}/.local/bin:${PATH}"
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
    stage('Apply'){
      when { branch 'main' }
      steps {
        sshagent(credentials: ['ansible-ssh-key']) {
          sh 'export PATH="${HOME}/.local/bin:${PATH}" && make'
        }
      }
    }
  }
}
