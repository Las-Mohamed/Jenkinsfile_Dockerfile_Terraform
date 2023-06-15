pipeline {
    agent any
    stages {
     stage('Clone') {
         steps{
            checkout scm
         }
     }
    stage('Build Image') {
        steps{
            docker.build("mowqa/pytoon")
        }
    }
    stage('Push Image') {
        steps{
            sh 'docker login -u mowqa -p dckr_pat_is0y3bHt8AoE6BLlA7sv3NaKJMI'
            sh 'docker push mowqa/pytoon'
        }
      }
   }
}
