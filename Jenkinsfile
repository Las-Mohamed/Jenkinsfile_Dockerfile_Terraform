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
}
