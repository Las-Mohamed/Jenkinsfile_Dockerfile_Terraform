pipeline {
    agent any
      parameters
    {
         choice choices: ['apply', 'destroy'], name: 'Action'                /*Parametre choix permettant de définir si on apply/destroy pour terraform*/
    }
    
    environment {
        MY_CRED = credentials('xxxxxxxxx-72b4-4064-b1d8-xxxxxxxxxxx')        /*Appel des credentials Jenkins correspondant au service principal Azure*/
     }
    
    stages {

         stage ('Clone') {
              steps {
                   checkout scm                        /*Clone et lecture à partir de Jenkinsfile disponible sur GitHub*/ 
              }
         }
        
        stage ('Build Image') {
            steps {
                 script {
                      docker.build("mowqa/pytoon")        /*Build et tag de l'image à partir du Dockerfile présent*/
                 }
                }                
            }
    
        stage ('Push Image') {
            steps {
                script {
                    sh "docker login -u <docker_username> -p <docker_token>        /*Login à DockerHub et push de l'image*/
                    sh "docker push mowqa/pytoon"
                }
            }
        }

        stage ('AZ Login') {
               steps {
                    script {
                         sh "az login --service-principal -u $MY_CRED_CLIENT_ID -p $MY_CRED_CLIENT_SECRET -t $MY_CRED_TENANT_ID"        /* Login à azure grâce aux crédential crées dans Jenkins*/
                    }
               }
          }

        stage ('Terraform init Staging') {
            steps {
                script {
                    sh "cd StagingEnvironment && terraform init -upgrade"            /*Se rend dans le module Parent(StagingEnvironment) contenant le provider pour executer la commande terraform init*/
                }    
            }
        } 
        stage ('Terraform apply/destroy Staging') {
          steps {
               script {
                    sh "cd StagingEnvironment && terraform ${params.Action} -auto-approve"        /*${params.Action} est une variable, elle correspond au paramètre "choix", apply ou destroy*/
               }
           }
      }
        stage('Sanity check') {
             steps {
                 input "Does the staging environment is ${params.Action}ed?"                /*input correspond à la question posée à l'utilisateur pour determiner si il continue à lire et executer le Jenkinsfile*/ 
            }
        }
        stage ('Terraform init Prod') {
            steps {
                script {
                    sh "cd ProdEnvironment && terraform init -upgrade"                    /*Mêmes commandes pour l'environnement Production*/
                }    
            }
        } 
        stage ('Terraform apply/destroy Prod') {
          steps {
               script {
                    sh "cd ProdEnvironment && terraform ${params.Action} -auto-approve"
               }
           }
      }
    }
    
}
