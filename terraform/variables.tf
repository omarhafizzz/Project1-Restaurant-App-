variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "eu-central-1"
}

variable "aws_profile" {
  description = "AWS CLI Profile"
  type        = string
  default     = "default"
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public Subnet CIDR"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "Availability Zone"
  type        = string
  default     = "eu-central-1b"
}

variable "jenkins_instance_type" {
  description = "Jenkins EC2 Instance Type"
  type        = string
  default     = "c7i-flex.large"
}

variable "sonarqube_instance_type" {
  description = "SonarQube EC2 Instance Type"
  type        = string
  default     = "c7i-flex.large"
}

variable "kubernetes_instance_type" {
  description = "Kubernetes EC2 Instance Type"
  type        = string
  default     = "t3.small"
}

variable "jenkins_volume_size" {
  description = "Jenkins Root Volume Size (GB)"
  type        = number
  default     = 20
}

variable "sonarqube_volume_size" {
  description = "SonarQube Root Volume Size (GB)"
  type        = number
  default     = 20
}

variable "kubernetes_volume_size" {
  description = "Kubernetes Root Volume Size (GB)"
  type        = number
  default     = 20
}

variable "ami_id" {
  description = "Ubuntu 22.04 LTS AMI ID"
  type        = string
  default     = "ami-0faab6bdbac9486fb" # eu-central-1 Ubuntu 22.04
}

variable "key_name" {
  description = "EC2 Key Pair Name"
  type        = string
  default     = "My_Key"
}

variable "project_name" {
  description = "Project Name (used for tagging)"
  type        = string
  default     = "devops-project"
}

variable "environment" {
  description = "Environment Name"
  type        = string
  default     = "dev"
}

variable "allowed_ssh_cidr" {
  description = "CIDR allowed to SSH"
  type        = string
  default     = "0.0.0.0/0"
}