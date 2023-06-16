# Pipeline Jenkins ---> Dockerfile ---> Terraform
------------------------------------------------------------------------------
Jenkinsfile (pipeline) permettant le déploiement de deux infrastructures (Prod et Staging)
dans lesquelles seront déployé un conteneur issu d'une image docker précédemment build et publiée sur DockerHub.
------------------------------------------------------------------------------
1 - Créer un projet pipeline dans Jenkins, sélectionner "github project" et renseigner l'url du repo git contenant le Jenkinsfile. Sélectionner "this project is parameterized" afin de créer des paramètres dans le déploiement du pipeline.

2 - Dans Pipeline, sélectionner "pipeline script from SCM", "git" et reseigner le repo et la branche.

3 - Créer des credentials azure service principal dans Jenkins.

4 - Créer le Jenkinsfile sur github qui contiendra toutes les instructions du pipeline : 
- Paramètres "choices" pour avoir le choix d'apply ou de destroy.
- Environment : Appel des Credentials Jenkins (Azure service principal).
- Checkout scm : lire le Jenkinsfile à partire de github.
- Build l'image Docker grâce au Dockerfile présent.
- Connexion à DockerHub (-u username -p token_DockerHub) et push de l'image.
- Login à azure grâce à l'appel des Credentials Jenkins.
  
  Tous les fichiers.tf sont présents sur le repo pour permettre le dépoloiement de l'infra grâce à terraform.
  Ces fichiers contiennent "ini-script.sh" qui correspond aux cutom_data que l'on injectera dans l'infra

- Terraform init dans le module parent (StagingEnvironment).
- Terraform apply ou destroy correspondant à la variable du paramètre "choices".
- Sanity Check : "input "Does the staging environment is ${params.Action}ed?"" permet la validation manuelle pour réaliser la suite du Jenkinsfile qui correspond au déploiement en Prodenvironment.

5 - Afin de permettre la surveillance et la maintenance, se rendre sur le portail azure et sélectionner la VM. Dans l'onglet à gauche Supervision--->Insight--->Performances (il est possible de créer des alertes en 	 
    fonction des besoins)
		

