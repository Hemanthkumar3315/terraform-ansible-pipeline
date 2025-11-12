pipeline {
  agent any

  environment {
    TF_DIR = "${WORKSPACE}/localstack-terraform"
  }

  stages {

    stage('Checkout Code') {
      steps {
        echo "Using local project directory"
        sh 'ls -la'
      }
    }

    stage('Terraform Init') {
      steps {
        dir("${TF_DIR}") {
          sh 'terraform init -input=false'
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        dir("${TF_DIR}") {
          sh 'terraform apply -auto-approve'
        }
      }
    }

    stage('Run Ansible Playbook') {
      steps {
        dir("${TF_DIR}") {
          sh 'ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.ini playbook.yml'
        }
      }
    }

    stage('Verify Deployment') {
      steps {
        echo "Verifying deployment..."
        sh 'curl -I http://localhost || true'
      }
    }
  }

  post {
    always {
      echo "✅ Pipeline completed (Terraform + Ansible)"
    }
    success {
      echo "🎉 Infrastructure successfully deployed via Jenkins!"
    }
    failure {
      echo "❌ Pipeline failed. Check console logs for details."
    }
  }
}

