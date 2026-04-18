# 🍽️ Project1 - Online Restaurant App

![CI/CD](https://img.shields.io/badge/CI%2FCD-Jenkins-blue)
![Docker](https://img.shields.io/badge/Container-Docker-2496ED)
![Kubernetes](https://img.shields.io/badge/Orchestration-Kubernetes-326CE5)
![Terraform](https://img.shields.io/badge/IaC-Terraform-7B42BC)
![SonarQube](https://img.shields.io/badge/Code%20Quality-SonarQube-4E9BCD)
![Trivy](https://img.shields.io/badge/Security-Trivy-1904DA)

A full-stack online restaurant application deployed with a complete CI/CD pipeline on Kubernetes.

---

## 📋 Table of Contents

- [About the Project](#about-the-project)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [CI/CD Pipeline](#cicd-pipeline)
- [Infrastructure](#infrastructure)
- [Getting Started](#getting-started)
- [Pipeline Stages](#pipeline-stages)

---

## 🍕 About the Project

**Project1** is an online restaurant web application that allows users to browse menus and place orders online. The project is built with a fully automated DevOps pipeline covering code quality, security scanning, containerization, and deployment to Kubernetes.

---

## 🏗️ Architecture

```
GitHub → Jenkins → SonarQube → Docker Hub → Kubernetes
                     ↓
                   Trivy (Security Scan)
                     ↓
                 Terraform (Infrastructure)
```

---

## 🛠️ Tech Stack

| Category | Tool |
|---|---|
| **Application** | Node.js |
| **CI/CD** | Jenkins |
| **Code Quality** | SonarQube |
| **Containerization** | Docker |
| **Container Registry** | Docker Hub |
| **Orchestration** | Kubernetes (Minikube) |
| **Security Scanning** | Trivy |
| **Infrastructure as Code** | Terraform |

---

## 🔄 CI/CD Pipeline

The Jenkins pipeline consists of the following stages:

```
Clean Workspace
      ↓
Checkout from Git
      ↓
SonarQube Analysis
      ↓
Quality Gate Check
      ↓
Install System Dependencies
      ↓
Install Node Dependencies
      ↓
Trivy FS Scan
      ↓
Docker Build & Push
      ↓
Trivy Image Scan
      ↓
Deploy to Kubernetes
```

---

## 🏗️ Infrastructure

Infrastructure is provisioned using **Terraform** on AWS:

- **EC2 Instance** - Jenkins Server
- **EC2 Instance** - Kubernetes Node
- **Security Groups** - Configured for Jenkins (8080), Kubernetes (6443), App (30832)

---

## 🚀 Getting Started

### Prerequisites

- AWS Account
- Terraform installed
- Docker installed
- kubectl installed

### 1. Provision Infrastructure with Terraform

```bash
cd terraform/
terraform init
terraform plan
terraform apply
```

### 2. Access Jenkins

```
http://<jenkins-server-ip>:8080
```

### 3. Run the Pipeline

1. Create a new Pipeline in Jenkins
2. Paste the Jenkinsfile content
3. Add required credentials:
   - `dockerhub` - Docker Hub credentials
   - `SonarQube-Token` - SonarQube token
   - `kubernetes` - Kubernetes kubeconfig

### 4. Access the Application

```
http://<kubernetes-node-ip>:30832
```

---

## 📊 Pipeline Stages Details

### 🔍 SonarQube Analysis
Static code analysis to ensure code quality and detect bugs.

### 🔒 Trivy Security Scan
- **FS Scan** - Scans the source code for vulnerabilities
- **Image Scan** - Scans the Docker image for vulnerabilities

### 🐳 Docker Build & Push
Builds the Docker image and pushes it to Docker Hub:
```
omarhafiz/p2:latest
```

### ☸️ Kubernetes Deployment
Deploys the application using:
- `deployment.yml` - Application deployment
- `service.yml` - LoadBalancer service on port 30832

---

## 📁 Project Structure

```
project1/
├── Kubernetes/
│   ├── deployment.yml
│   └── service.yml
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── Dockerfile
├── Jenkinsfile
├── package.json
└── README.md
```

---

## 👨‍💻 Author

**Omar Hafiz**
- Docker Hub: [omarhafiz](https://hub.docker.com/u/omarhafiz)
- GitHub: [omarhafizzz](https://github.com/omarhafizzz)
