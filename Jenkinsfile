pipeline {
    agent any
      parameters
    {
         choice choices: ['apply', 'destroy'], name: 'Action'
    }
    
    environment {
        MY_CRED = credentials('f2d10700-72b4-4064-b1d8-1a4882c4f29f')
     }
    
    stages {

         stage ('Clone') {
              steps {
                   checkout scm
              }
         }
        
        stage ('Build Image') {
            steps {
                 script {
                      docker.build("mowqa/pytoon")
                 }
                }                
            }
    
        stage ('Push Image') {
            steps {
                script {
                    sh "docker login -u mowqa -p dckr_pat_is0y3bHt8AoE6BLlA7sv3NaKJMI"
                    sh "docker push mowqa/pytoon"
                }
            }
        }

        stage ('AZ Login') {
               steps {
                    script {
                         sh "az login --service-principal -u $MY_CRED_CLIENT_ID -p $MY_CRED_CLIENT_SECRET -t $MY_CRED_TENANT_ID"
                    }
               }
          }

        stage ('Terraform init Staging') {
            steps {
                script {
                    sh "cd StagingEnvironment && terraform init -upgrade"
                }    
            }
        } 
        stage ('Terraform apply Staging') {
          steps {
               script {
                    sh "cd StagingEnvironment && terraform ${params.Action} -auto-approve"
               }
           }
      }
        stage('Sanity check') {
             steps {
                 input "Does the staging environment look ok?"
            }
        }
        stage ('Terraform init Prod') {
            steps {
                script {
                    sh "cd ProdEnvironment && terraform init -upgrade"
                }    
            }
        } 
        stage ('Terraform apply Prod') {
          steps {
               script {
                    sh "cd ProdEnvironment && terraform ${params.Action} -auto-approve"
               }
           }
      }
    }
    
}
