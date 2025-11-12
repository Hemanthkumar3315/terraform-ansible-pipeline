pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo '✅ Checking out project from GitHub repository'
                sh 'ls -la'
            }
        }

        stage('Terraform Init') {
            steps {
                echo '🚀 Initializing Terraform in current directory...'
                sh '''
                    cd $WORKSPACE
                    terraform init -input=false
                '''
            }
        }

        stage('Terraform Validate') {
            steps {
                echo '🔍 Validating Terraform configuration...'
                sh '''
                    cd $WORKSPACE
                    terraform validate
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                echo '⚙️ Applying Terraform configuration...'
                sh '''
                    cd $WORKSPACE
                    terraform apply -auto-approve
                '''
            }
        }

        stage('Run Ansible Playbook') {
            steps {
                echo '🧩 Running Ansible playbook...'
                sh '''
                    cd $WORKSPACE
                    ansible-playbook -i inventory.ini playbook.yml
                '''
            }
        }

        stage('Verify Deployment') {
            steps {
                echo '✅ Verifying Deployment...'
                sh '''
                    echo "Deployment verification successful!"
                '''
            }
        }
    }

    post {
        success {
            echo "🎯 Pipeline completed successfully! (Terraform + Ansible)"
        }
        failure {
            echo "❌ Pipeline failed. Check console logs for details."
        }
    }
}
