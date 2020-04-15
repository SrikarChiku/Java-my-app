properties([parameters([string(defaultValue: '', description: '', name: 'version', trim: false)])])
pipeline {
   agent any
environment{
              JFROG_CREDS=credentials('jfrog_creds')
              GROUP_ID="com/jfrog/app"
              ARTIFACT_ID="jfrog-app"
              TYPE="SNAPSHOT"
          }
   stages {
      stage('Fetch') {
          
         steps {
                 script{
                     if("${params.version}".toLowerCase() == "latest"){
                    bat "jfrog rt dl  \"libs-snapshot-local/${GROUP_ID}/${ARTIFACT_ID}/\" --sort-by=created --sort-order=desc --limit=1"
                    }
                    else if( !("${params.version}" ==~ /(\d+)\.(\d+)\.(\d+)\.(\d+)/)){
                        echo "ERROR : ${params.version} is not the correct pattern- please check"
                    }
                    else{
                        def check=powershell label: '', returnStdout: true, script: "jfrog rt s libs-snapshot-local/${GROUP_ID}/${ARTIFACT_ID}/${ARTIFACT_ID}-${TYPE}-${params.version}.jar"
                        def length = check.size()
                        echo "${length}"
                        if("${length}" == "4"){
                            echo "WARNING: ${params.version} Couldnt not be found"
                            currentBuild.result="ABORTED"
                        }
                        else{
                             bat "jfrog rt dl \"libs-snapshot-local/${GROUP_ID}/${ARTIFACT_ID}/${ARTIFACT_ID}-${TYPE}-${params.version}.jar\""  

                        }
                    }
                }
         }
      }
   }
}

