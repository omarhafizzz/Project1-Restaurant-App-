##################################################
# JENKINS OUTPUTS
##################################################

output "jenkins_public_ip" {
  description = "Jenkins Server Public IP"
  value       = aws_instance.jenkins.public_ip
}

output "jenkins_public_dns" {
  description = "Jenkins Server Public DNS"
  value       = aws_instance.jenkins.public_dns
}

output "jenkins_url" {
  description = "Jenkins UI URL"
  value       = "http://${aws_instance.jenkins.public_ip}:8080"
}

output "jenkins_ssh" {
  description = "SSH Command for Jenkins Server"
  value       = "ssh -i ${var.key_name}.pem ubuntu@${aws_instance.jenkins.public_ip}"
}

output "jenkins_installation_log" {
  description = "Watch Jenkins installation log live"
  value       = "ssh -i ${var.key_name}.pem ubuntu@${aws_instance.jenkins.public_ip} 'sudo tail -f /var/log/user-data.log'"
}

##################################################
# SONARQUBE OUTPUTS
##################################################

output "sonarqube_public_ip" {
  description = "SonarQube Server Public IP"
  value       = aws_instance.sonarqube.public_ip
}

output "sonarqube_public_dns" {
  description = "SonarQube Server Public DNS"
  value       = aws_instance.sonarqube.public_dns
}

output "sonarqube_url" {
  description = "SonarQube UI URL"
  value       = "http://${aws_instance.sonarqube.public_ip}:9000"
}

output "sonarqube_ssh" {
  description = "SSH Command for SonarQube Server"
  value       = "ssh -i ${var.key_name}.pem ubuntu@${aws_instance.sonarqube.public_ip}"
}

output "sonarqube_installation_log" {
  description = "Watch SonarQube installation log live"
  value       = "ssh -i ${var.key_name}.pem ubuntu@${aws_instance.sonarqube.public_ip} 'sudo tail -f /var/log/user-data.log'"
}

##################################################
# KUBERNETES OUTPUTS
##################################################

output "kubernetes_public_ip" {
  description = "Kubernetes Master Public IP"
  value       = aws_instance.kubernetes.public_ip
}

output "kubernetes_public_dns" {
  description = "Kubernetes Master Public DNS"
  value       = aws_instance.kubernetes.public_dns
}

output "kubernetes_api" {
  description = "Kubernetes API Server URL"
  value       = "https://${aws_instance.kubernetes.public_ip}:6443"
}

output "kubernetes_ssh" {
  description = "SSH Command for Kubernetes Master"
  value       = "ssh -i ${var.key_name}.pem ubuntu@${aws_instance.kubernetes.public_ip}"
}

output "kubernetes_installation_log" {
  description = "Watch Kubernetes installation log live"
  value       = "ssh -i ${var.key_name}.pem ubuntu@${aws_instance.kubernetes.public_ip} 'sudo tail -f /var/log/user-data.log'"
}

##################################################
# SUMMARY
##################################################

output "summary" {
  description = "DevOps Infrastructure Summary"
  value = <<-EOT

  ===================================================
              ✅ DevOps Infrastructure Ready
  ===================================================

  🔧 Jenkins
     URL  : http://${aws_instance.jenkins.public_ip}:8080
     SSH  : ssh -i ${var.key_name}.pem ubuntu@${aws_instance.jenkins.public_ip}
     Logs : ssh -i ${var.key_name}.pem ubuntu@${aws_instance.jenkins.public_ip} 'sudo tail -f /var/log/user-data.log'

  📊 SonarQube
     URL  : http://${aws_instance.sonarqube.public_ip}:9000
     SSH  : ssh -i ${var.key_name}.pem ubuntu@${aws_instance.sonarqube.public_ip}
     Logs : ssh -i ${var.key_name}.pem ubuntu@${aws_instance.sonarqube.public_ip} 'sudo tail -f /var/log/user-data.log'
     Login: admin / admin

  ☸️  Kubernetes (Single Node)
     API  : https://${aws_instance.kubernetes.public_ip}:6443
     SSH  : ssh -i ${var.key_name}.pem ubuntu@${aws_instance.kubernetes.public_ip}
     Logs : ssh -i ${var.key_name}.pem ubuntu@${aws_instance.kubernetes.public_ip} 'sudo tail -f /var/log/user-data.log'

  ===================================================
  EOT
}