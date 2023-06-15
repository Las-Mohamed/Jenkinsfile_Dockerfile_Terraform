node{
     parameters
    {
        booleanParam(defaultValue: true, description: '', name: 'Deploy')
        string(name: 'Environment', defaultValue: "", description: '')
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
}