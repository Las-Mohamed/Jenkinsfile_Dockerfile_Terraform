/*node{
     parameters
    {
        booleanParam(defaultValue: true, description: '', name: 'Deploy')
        string(name: 'Environment', defaultValue: "", description: '')
        string(name: 'Action', defaultValue: "", description: '')
        choice(choices: ['StagingEnvironment', 'ProdEnvironment'], name: 'Environment')
        choice(choices: ['apply', 'destroy'], name: 'Action')
    }
    
    stage('Clone') {
        checkout scm
    }
    
    stage ('Build Image') {
        docker.build("mowqa/pytoon")
    }
    stage ('Push Image') {
        sh 'docker login -u mowqa -p dckr_pat_is0y3bHt8AoE6BLlA7sv3NaKJMI'
        sh 'docker push mowqa/pytoon'
    }
    stage ('Terraform init') {
        sh 'cd ${params.Environment} && terraform init -upgrade'
    }
    stage ('Terraform apply') {
        sh 'cd ${params.Environment} && terraform ${params.Action} -var="subscription_id=$AZURE_SUBSCRIPTION_ID" -var="client_id=$AZURE_CLIENT_ID" -var="client_secret=$AZURE_CLIENT_SECRET" -var="tenant_id=$AZURE_TENANT_ID" -auto-approve'
    }
}*/
pipeline {
    agent any
  
    parameters
    {
         choice choices: ['StagingEnvironment', 'ProdEnvironment'], name: 'Environment'
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
                    sh 'docker login -u mowqa -p dckr_pat_is0y3bHt8AoE6BLlA7sv3NaKJMI'
                    sh 'docker push mowqa/pytoon'
                }
            }
        }

        stage ('AZ Login") {
               steps {
                    script {
                         sh 'az login --service-principal -u $MY_CRED_CLIENT_ID -p $MY_CRED_CLIENT_SECRET -t $MY_CRED_TENANT_ID'
                    }
               }
          }

        stage ('Terraform init') {
            steps {
                script {
                    sh "cd ${params.Environment} && terraform ${params.Action} -auto-approve"
                }    
            }
        } 
        stage ('Terraform apply') {
          steps {
               script {
                    sh 'cd ${params.Environment} && terraform ${params.Action} -var=subscription_id=$AZURE_SUBSCRIPTION_ID -var=client_id=$AZURE_CLIENT_ID -var=client_secret=$AZURE_CLIENT_SECRET -var=tenant_id=$AZURE_TENANT_ID -auto-approve'
               }
          }
        }
    }    
}
