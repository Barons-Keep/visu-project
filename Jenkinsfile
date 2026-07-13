pipeline {
  agent any

  options {
    timeout(time: 60, unit: 'MINUTES')
    buildDiscarder(logRotator(numToKeepStr: '14'))
  }

  stages {
    stage('Verify visu-project') {
      steps {
        script {
          String revision = "${env.GIT_COMMIT}"

          def buildJob = build(
            job: 'visu-project/verify',
            propagate: true,
            wait: true,
            parameters: [
              string(name: 'GIT_REVISION', value: revision),
            ]
          )
        }
      }
    }
  }
}
