#!groovy

// This is the full syntax for Jenkins Declarative Pipelines as of version 0.8.1.

pipeline {
  // Possible agent configurations - you must have one and only one at the top level.
  agent any
  agent none
  agent {
    label "whatever"
  }
  agent {
    docker "ubuntu:16.04"
  }
  agent {
    dockerfile true
  }
  agent {
    docker {
      image "ubuntu:16.04"
      label "docker-nodes"
      args "-v /tmp:/tmp"
    }
  }
  agent {
    dockerfile {
      filename "someOtherDockerfile"
      label "docker-nodes"
      args "-v /tmp:/tmp"
    }
  }

  // Environment
  environment {
    FOO = "bar"
    OTHER = "${FOO}baz"
    SOME_CREDENTIALS = credentials('some-id')
  }

  // Tools - only works when *not* on docker or dockerfile agent
  tools {
    // Symbol for tool type and then name of configured tool installation
    maven "maven3.3.9"
    jdk "jdk8"
  }

  options {
    // General Jenkins job properties
    buildDiscarder(logRotator(numToKeepStr:'1'))
    // Declarative-specific options
    skipDefaultCheckout()
    // "wrapper" steps that should wrap the entire build execution
    timestamps()
    timeout(time: 5, unit: 'MINUTES')
  }

  triggers {
    cron('@daily')
  }

  // Access parameters with 'params.PARAM_NAME' - that'll get you default values too.
  parameters {
    booleanParam(defaultValue: true, description: '', name: 'flag')
    // Newer core versions support "stringParam" as well
    string(defaultValue: '', description: '', name: 'SOME_STRING')
  }

  stages {
    stage("first stage") {
      // All sections within stage other than steps are optional.
      environment {
        // Overrides or adds to the existing environment
        FOO = "notBar"
      }
      tools {
        // Overrides tools of the same type defined globally
        maven "maven3.3.3"
      }
      agent {
        // Overrides the top-level agent. "agent none" at the stage level does nothing.
        label "some-other-label"
      }

      // Conditional execution of this stage - only run this stage if the when condition is true.
      when {
        // One and only one condition is allowed.

        // Only run if the branch matches this Ant-style pattern
        branch "master"

        // Only run if the environment contains this given variable name with this given value
        environment name: "FOO", value: "notBar"

        // Only run if this Scripted Pipeline expression doesn't return false or null
        expression {
          echo "You can run any Pipeline steps in here"
          return "foo" == "bar"
        }
      }

      // Runs at the end of the stage, depending on whether the conditions are met.
      post {
        // always means, well, always run.
        always {
          echo "Hi there"
        }
        // changed means when the build status is different than the previous build's status.
        changed {
          echo "I'm different"
        }
        // success, failure, unstable all run if the current build status is successful, failed, or unstable, respectively
        success {
          echo "I succeeded"
          archive "**/*"
        }
      }

      // steps is required and is where you put your stage's actual work
      steps {
        echo "I'm doing things, I guess."
        retry(5) {
          echo "Keep trying this if it fails up to 5 times"
        }

        // the script block allows you to run any arbitrary Pipeline script, even if it doesn't fit the Declarative subset.
        script {
          if ("sky" == "blue") {
            echo "You can't actually do loops or if statements etc in Declarative unless you're in a script block!"
          }
        }
      }
    }

    stage("second stage") {
      steps {
        // You can only use the parallel step if it's the *only* step in the stage.
        parallel(
          firstBlock: {
            echo "I'm on one parallel block"
          },
          secondBlock: {
            echo "I'm on the other block"
          }
        )
      }
    }
  }

  post {
    // always means, well, always run.
    always {
      echo "Hi there"
    }
    // changed means when the build status is different than the previous build's status.
    changed {
      echo "I'm different"
    }
    // success, failure, unstable all run if the current build status is successful, failed, or unstable, respectively
    success {
      echo "I succeeded"
      archive "**/*"
    }
  }
}
