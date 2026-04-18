# 🍽️ Project1 - Online Restaurant App

![CI/CD](https://img.shields.io/badge/CI%2FCD-Jenkins-blue)
![Docker](https://img.shields.io/badge/Container-Docker-2496ED)
![Kubernetes](https://img.shields.io/badge/Orchestration-Kubernetes-326CE5)
![Terraform](https://img.shields.io/badge/IaC-Terraform-7B42BC)
![SonarQube](https://img.shields.io/badge/Code%20Quality-SonarQube-4E9BCD)
![Trivy](https://img.shields.io/badge/Security-Trivy-1904DA)
![AWS](https://img.shields.io/badge/Cloud-AWS-FF9900)
![Node.js](https://img.shields.io/badge/App-Node.js-339933)

**A full-stack online restaurant application deployed with a complete DevOps CI/CD pipeline on AWS**

<div align="center">

<img src="https://raw.githubusercontent.com/omarhafizzz/Project1-Restaurant-App-/main/Photos%20and%20screenshots/Screenshot_18-4-2026_5755_18_194_139_54.jpeg" />
<img src="https://raw.githubusercontent.com/omarhafizzz/Project1-Restaurant-App-/main/Photos%20and%20screenshots/Screenshot_18-4-2026_5829_3_127_151_36.jpeg" />
<img src="https://raw.githubusercontent.com/omarhafizzz/Project1-Restaurant-App-/main/Photos%20and%20screenshots/Screenshot_18-4-2026_51315_3_127_151_36.jpeg" />
<img src="https://raw.githubusercontent.com/omarhafizzz/Project1-Restaurant-App-/main/Photos%20and%20screenshots/Screenshot_18-4-2026_51511_18_184_215_48.jpeg" />
<img src="https://raw.githubusercontent.com/omarhafizzz/Project1-Restaurant-App-/main/Photos%20and%20screenshots/Screenshot_18-4-2026_51630_18_184_215_48.jpeg" />
<img src="https://raw.githubusercontent.com/omarhafizzz/Project1-Restaurant-App-/main/Photos%20and%20screenshots/Screenshot_18-4-2026_5135_3_127_151_36.jpeg" />
<img src="https://raw.githubusercontent.com/omarhafizzz/Project1-Restaurant-App-/main/Photos%20and%20screenshots/Screenshot_18-4-2026_51026_eu-central-1_console_aws_amazon_com.jpeg" />
<img src="https://raw.githubusercontent.com/omarhafizzz/Project1-Restaurant-App-/main/Photos%20and%20screenshots/Screenshot_18-4-2026_5735_18_184_215_48.jpeg" />
<img src="https://raw.githubusercontent.com/omarhafizzz/Project1-Restaurant-App-/main/Photos%20and%20screenshots/Screenshot_2026-04-18_051416.png" />
<img src="https://raw.githubusercontent.com/omarhafizzz/Project1-Restaurant-App-/main/Photos%20and%20screenshots/Screenshot_2026-04-18_051716.png" />
<img src="https://raw.githubusercontent.com/omarhafizzz/Project1-Restaurant-App-/main/Photos%20and%20screenshots/Screenshot_2026-04-18_051752.png" />
<img src="https://raw.githubusercontent.com/omarhafizzz/Project1-Restaurant-App-/main/Photos%20and%20screenshots/Screenshot_18-4-2026_5855_hub_docker_com.jpeg" />

</div>

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Infrastructure](#-infrastructure)
- [Architecture](#-architecture)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [CI/CD Pipeline](#-cicd-pipeline)
- [Getting Started](#-getting-started)

---

## 🔍 Overview

**Project1** is an online restaurant web application (inspired by Swiggy) that allows users to browse menus and place food orders online. The project is built with a fully automated DevOps pipeline covering infrastructure provisioning, code quality analysis, security scanning, containerization, and deployment to Kubernetes on AWS.

### Key Features

- 🍕 Online restaurant browsing and food ordering UI
- 🔄 Automated CI/CD pipeline (Jenkins)
- 🐳 Containerized with Docker
- ☸️ Orchestrated with Kubernetes
- 🔍 Code quality analysis with SonarQube
- 🔒 Security scanning with Trivy (FS + Image)
- 🏗️ Infrastructure as Code with Terraform
- ☁️ Deployed on AWS EC2 (eu-central-1)

---

## 🏗️ Infrastructure

Infrastructure is fully provisioned using **Terraform** on AWS — this is the foundation that the entire pipeline runs on.

### EC2 Instances (eu-central-1)

| Server | Type | Purpose |
|--------|------|---------|
| devops-project-jenkins | c7i-flex.large | CI/CD + Docker + Trivy + kubectl |
| devops-project-sonarqube | c7i-flex.large | Code quality analysis |
| devops-project-kubernetes | t3.small | Single-node K8s cluster |

### Security Groups

| Port | Service |
|------|---------|
| 8080 | Jenkins |
| 9000 | SonarQube |
| 6443 | Kubernetes API |
| 30832 | Application (NodePort) |

### Terraform Outputs

After `terraform apply`, outputs are printed automatically:

```
jenkins_url            = "http://18.184.215.48:8080"
sonarqube_url          = "http://3.127.151.36:9000"
kubernetes_api         = "https://18.194.139.54:6443"
kubernetes_public_ip   = "18.194.139.54"
```

### Deploy Infrastructure

```bash
cd terraform/
terraform init
terraform plan
terraform apply -auto-approve
```

### Destroy Infrastructure

```bash
terraform destroy -auto-approve
```

---

## 🏛️ Architecture

```
┌──────────────────────────────────────────────────────────────┐
│                   AWS Cloud (eu-central-1)                   │
│                                                              │
│  ┌────────────────────────────────────────────────────────┐  │
│  │                        VPC                             │  │
│  │                                                        │  │
│  │  ┌───────────────┐    ┌───────────────┐               │  │
│  │  │    Jenkins    │    │  SonarQube    │               │  │
│  │  │c7i-flex.large │    │c7i-flex.large │               │  │
│  │  │    :8080      │    │    :9000      │               │  │
│  │  └───────────────┘    └───────────────┘               │  │
│  │                                                        │  │
│  │  ┌────────────────────────────────────────────────┐   │  │
│  │  │         Kubernetes Node (t3.small)              │   │  │
│  │  │    omar-app (2 Pods) — NodePort :30832          │   │  │
│  │  └────────────────────────────────────────────────┘   │  │
│  └────────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────────┘

GitHub → Jenkins → SonarQube → DockerHub → Kubernetes
```

---

## 🛠️ Tech Stack

| Category | Technology |
|----------|-----------|
| **Application** | Node.js |
| **Frontend** | HTML, CSS, JavaScript |
| **Containerization** | Docker |
| **Container Registry** | Docker Hub (`omarhafiz/p2`) |
| **Orchestration** | Kubernetes |
| **CI/CD** | Jenkins 2.492.3 |
| **Code Quality** | SonarQube v9.9.8 |
| **Security Scan** | Trivy (FS Scan + Image Scan) |
| **Infrastructure** | AWS EC2 (eu-central-1) |
| **IaC** | Terraform |

---

## 📁 Project Structure

```
Project1-Restaurant-App-/
├── src/                         # Application source code
├── public/                      # Static assets
├── Photos and screenshots/      # Project screenshots
├── Kubernetes/
│   ├── deployment.yml           # Kubernetes deployment (2 replicas)
│   └── service.yml              # LoadBalancer service — port 30832
├── terraform/
│   ├── main.tf                  # EC2 instances, VPC, Security Groups
│   ├── variables.tf             # Input variables
│   └── outputs.tf               # Jenkins, SonarQube, K8s URLs
├── Dockerfile                   # Container definition
├── Jenkinsfile                  # CI/CD pipeline definition
├── package.json                 # Node.js dependencies
└── README.md
```

---

## 🔄 CI/CD Pipeline

The Jenkins pipeline runs automatically on every push to `main` and completes in approximately **3 minutes 32 seconds**.

### Pipeline Stages

```
Tool Install → Clean Workspace → Checkout from Git → SonarQube Analysis
     → Quality Gate → Install System Dependencies → Install Node Dependencies
          → TRIVY FS SCAN → Docker Build & Push → TRIVY Image Scan → Deploy to Kubernetes
```

### Stage Details

| Stage | Description | Duration |
|-------|-------------|----------|
| **Tool Install** | Install JDK17 + Node16 | 0.15s |
| **Clean Workspace** | Clear previous build artifacts | 0.29s |
| **Checkout from Git** | Pull latest code from GitHub | 1.1s |
| **SonarQube Analysis** | Static code analysis | 8.3s |
| **Quality Gate** | Fail pipeline if quality is poor | 1.0s |
| **Install System Dependencies** | System-level packages | 3.1s |
| **Install Dependencies** | `npm install` | 13s |
| **TRIVY FS SCAN** | Scan source code for vulnerabilities | 12s |
| **Docker Build & Push** | Build & push `omarhafiz/p2:latest` | 2m 28s |
| **TRIVY Image Scan** | Scan Docker image for CVEs | 21s |
| **Deploy to Kubernetes** | `kubectl apply` deployment + service | 1.5s |

### SonarQube Results

| Metric | Result |
|--------|--------|
| Quality Gate | ✅ **Passed** |
| Bugs | 0 — Rating **A** |
| Vulnerabilities | 0 — Rating **A** |
| Code Smells | 0 — Rating **A** |
| Security Hotspots | 3 |
| Duplications | 0.0% on 222 Lines |

---

## 🚀 Getting Started

### Prerequisites

- AWS Account with CLI configured
- Terraform >= 1.3.0
- Key pair `My_Key` in `eu-central-1`
- Docker installed locally

### 1. Clone the Repo

```bash
git clone https://github.com/omarhafizzz/Project1-Restaurant-App-.git
cd Project1-Restaurant-App-
```

### 2. Provision Infrastructure with Terraform

```bash
cd terraform/
terraform init
terraform apply -auto-approve
```

> Terraform will output the IPs for Jenkins, SonarQube, and Kubernetes automatically.

### 3. Setup Jenkins

- Open `http://<jenkins-ip>:8080`
- Install plugins: `Docker Pipeline`, `SonarQube Scanner`, `Kubernetes CLI`, `NodeJS`
- Add credentials:
  - `dockerhub` — Docker Hub credentials
  - `SonarQube-Token` — SonarQube token
  - `kubernetes` — Kubernetes kubeconfig
- Configure SonarQube server URL in Jenkins System settings

### 4. Run the Pipeline

- Create a new Pipeline pointing to this repo
- Click **Build Now**
- Pipeline completes in ~3.5 minutes ✅

### 5. Access the App

```
http://<kubernetes-ip>:30832
```

---

## 🐳 Docker Hub

Image is pushed automatically by Jenkins on every successful build:

```
omarhafiz/p2:latest
```

Docker Hub: [hub.docker.com/u/omarhafiz](https://hub.docker.com/u/omarhafiz)

---

## ☸️ Kubernetes

The app runs as **2 pods** on the Kubernetes node:

```bash
kubectl get pods
# NAME                        READY   STATUS    RESTARTS   AGE
# omar-app-859f9d9798-bsr25   1/1     Running   0          22m
# omar-app-859f9d9798-c4svh   1/1     Running   0          22m

kubectl get svc
# NAME        TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
# omar-app    LoadBalancer   10.103.87.6     <pending>     80:30832/TCP   2m55s
```

---

## 👨‍💻 Author

**Omar Hafiz**
- Docker Hub: [omarhafiz](https://hub.docker.com/u/omarhafiz)
- GitHub: [omarhafizzz](https://github.com/omarhafizzz)

---

<div align="center">
Built with ❤️ | Project1 v1.0 | DevOps Graduation Project 2026
</div>
