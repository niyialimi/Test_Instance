pipeline {
    agent any
//  parameters {
//   credentials credentialType: 'com.cloudbees.jenkins.plugins.awscredentials.AWSCredentialsImpl', defaultValue: 'AWS_CREDS_AUTOMATION_ACCT', name: 'AWS_AUTOMATION_ACCOUNT_CRED', required: false
// }

    environment {
        PATH = "${PATH}:${getTerraformPath()}"
    }
    stages{

         stage('Initial Deployment Approval') {
              steps {
                script {
                def userInput = input(id: 'confirm', message: 'Start Pipeline?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Start Pipeline', name: 'confirm'] ])
             }
           }
        }

         stage('Terraform init'){
             steps {
                 //sh "returnStatus: true, script: 'terraform workspace new dev'"
                 sh "terraform init"
                 
         }
         }
         stage('Terraform plan'){
             steps {
                 //sh "returnStatus: true, script: 'terraform workspace new dev'"
                 //sh "terraform apply -auto-approve"
                 sh "terraform plan -out=tfplan -input=false"
             }
         }
        // stage('Dev Deployment Apply') {
        //       steps {
        //         script {
        //         def userInput = input(id: 'confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
        //      }
        //    }
        // }
        //  stage('Deploy into Dev'){
        //      steps {
        //          //sh "returnStatus: true, script: 'terraform workspace new dev'"
        //          //sh "terraform apply -auto-approve"
        //         //  sh "terraform destroy -input=false -auto-approve"
        //          sh "terraform apply  -input=false tfplan"
        //      }
        //  }

        //   stage('UAT Deployment Approval') {
        //       steps {
        //         script {
        //         def userInput = input(id: 'confirm', message: 'Deploy into UAT?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Deploy Into UAT', name: 'confirm'] ])
        //      }
        //    }
        // }

        // stage('Deploy into UAT'){
        //      steps {
        //          //sh "returnStatus: true, script: 'terraform workspace new dev'"
        //          //sh "terraform apply -auto-approve"
        //         //  sh "terraform destroy -input=false -auto-approve"
        //          sh "terraform apply  -input=false tfplan"
        //      }
        //  }

        stage('Terraform Destroy'){
             steps {
                 //sh "returnStatus: true, script: 'terraform workspace new dev'"
                 //sh "terraform apply -auto-approve"
                 sh "terraform destroy -input=false -auto-approve"
             }
         }
        
    }
}

 def getTerraformPath(){
        def tfHome= tool name: 'terraform-14', type: 'terraform'
        return tfHome
    }

//  def getAnsiblePath(){
//         def AnsibleHome= tool name: 'Ansible', type: 'org.jenkinsci.plugins.ansible.AnsibleInstallation'
//         return AnsibleHome
//     }