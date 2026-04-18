pipeline{
     agent any
     
     tools{
         jdk 'jdk17'
         nodejs 'node16'
     }
     environment {
         SCANNER_HOME=tool 'SonarQube-Scanner'
         DOCKER_PATH = '/usr/bin/docker'
     }
     
     stages {
         stage('Clean Workspace'){
             steps{
                 cleanWs()
             }
         }
         stage('Checkout from Git'){
             steps{
                 git branch: 'main', url: 'https://github.com/omarhafizzz/project1.git'
             }
         }
         stage("Sonarqube Analysis "){
             steps{
                 withSonarQubeEnv('SonarQube-Server') {
                     sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=project1 \
                     -Dsonar.projectKey=project1 '''
                 }
             }
         }
         stage("Quality Gate"){
            steps {
                 script {
                     waitForQualityGate abortPipeline: false, credentialsId: 'SonarQube-Token' 
                 }
             } 
         }
         stage('Install System Dependencies') {
             steps {
                 sh "sudo apt-get install libatomic1 -y"
             }
         }
         stage('Install Dependencies') {
             steps {
                 sh "npm install"
             }
         }
         stage('TRIVY FS SCAN') {
             steps {
                 sh "trivy fs . > trivyfs.txt"
             }
         }
         stage("Docker Build & Push"){
             steps{
                 script{
                     withCredentials([usernamePassword(
                         credentialsId: 'dockerhub',
                         usernameVariable: 'DOCKER_USER',
                         passwordVariable: 'DOCKER_PASS'
                     )]) {
                         sh """
                             ${DOCKER_PATH} login -u ${DOCKER_USER} -p ${DOCKER_PASS}
                             ${DOCKER_PATH} build -t p2 .
                             ${DOCKER_PATH} tag p2 omarhafiz/p2:latest
                             ${DOCKER_PATH} push omarhafiz/p2:latest
                         """
                     }
                 }
             }
         }
         stage("TRIVY"){
             steps{
                 sh "trivy image omarhafiz/p2:latest > trivyimage.txt" 
             }
         }
         stage('Deploy to Kubernetes'){
             steps{
                 script{
                     dir('Kubernetes') {
                         kubeconfig(credentialsId: 'kubernetes', serverUrl: '') {
                             sh 'kubectl delete --all pods'
                             sh 'kubectl apply -f deployment.yml'
                             sh 'kubectl apply -f service.yml'
                         }   
                     }
                 }
             }
         }
     }
 }