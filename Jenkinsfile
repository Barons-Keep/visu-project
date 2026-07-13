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
          def buildJob = build(
            job: 'visu-project/verify',
            propagate: true,
            wait: true,
            parameters: [
              string(name: 'GIT_REVISION', value: "${env.GIT_COMMIT}"),
              string(name: 'GMS_RUNTIME', value: "YYC"),
              string(name: 'OVERRIDE_DEPENDENCIES', value: "{}"),
              booleanParam(name: 'EDITOR', value: true ),
            ]
          )
        }
      }
    }
  }
}
