node{
    
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
        sh 'cd StagingEnvironment && terraform init -upgrade'
    }
    stage ('Terraform apply') {
        sh 'cd StagingEnvironment && terraform destroy -var="subscription_id=$AZURE_SUBSCRIPTION_ID" -var="client_id=$AZURE_CLIENT_ID" -var="client_secret=$AZURE_CLIENT_SECRET" -var="tenant_id=$AZURE_TENANT_ID" -auto-approve'
    }
}
