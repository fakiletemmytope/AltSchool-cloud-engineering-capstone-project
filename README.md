# AltSchool-cloud-engineering-capstone-project

## Introduction
In today’s cloud-centric world, deploying applications with scalability and reliability is crucial. Amazon’s Elastic Kubernetes Service (EKS) provides a managed Kubernetes environment that simplifies the orchestration of containerized applications. In this article, I'll walk you through the process of configuring an EKS cluster, deploying a web application (Sock-Shop), and setting up a CI/CD pipeline using Jenkins (Hosted on AWS EC2 Instance), all while leveraging Terraform and CloudFormation for infrastructure management.

### Prerequisites
Before we dive in, ensure you have:
•	Basic knowledge of AWS services, particularly EKS and CloudFormation.
•	Experience with Terraform.
•	Familiarity with Jenkins for Continuous Integration and Continuous Deployment (CI/CD).

## Setting Up Jenkins For CI/CD
I setup the Jenkins server using AWS EC2 instances using terraform as seen in: [ecs-jenkin Folder.](Terraform/ecs-jenkins) The [jenkins-installations.sh file](Terraform/ecs-jenkins/jenkins-installations.sh) shows all the packages that were installed on the jenkins server for smooth CI/CD.

## Jenkins CI/CD Pipeline Configuration

### Setting Up Jenkins with GitHub Webhook

Integrate Jenkins with GitHub by setting up a webhook. This allows GitHub to notify Jenkins whenever changes are pushed to the repository. This process is set up on both GitHub webhook and setting up a pipeline the Jenkins server . As show below:

![GitHub Webhook](images/Screenshot%202024-08-17%20023603.png)

![Jenkns setup](images/Screenshot%202024-08-17%20023934.png)


### Creating a CI/CD Pipeline

I wrote a [Jenkinsfile](Jenkins-Pipeline/Jenkinsfile.deploy) that orchestrates the CI/CD pipeline on the jenkins server whenever a push is made to the github repository.

The jenkins file orchestrates the following configuration and deployment on AWS:

#### Setting Up AWS EKS Cluster, Node-Group and CloudFormation

The AWS Cloudformation EKS Cluster and Node-Group and set-up using terraform and it orchestrates by enkins using the files in the [eks-clouformation folder.](Terraform/eks-cloudformation/)

To establish a robust networking structure, CloudFormation is used to create VPC and networking resources using an already existing [template](https://s3.us-west-2.amazonaws.com/amazon-eks/cloudformation/2020-10-29/amazon-eks-vpc-private-subnets.yaml) 

The cluster is created using an already existing policy on the aws account.

#### Deploying the Web Application, Grafana, Prometheus, and Alertmanager

With EKS and networking set up, it’s time to deploy our applications. Below are deployment specifications for our web app and monitoring services are orchestrated by jenkins as seen in the [Jenkinsfile](Jenkins-Pipeline/Jenkinsfile.deploy):

1. sh 'aws eks update-kubeconfig --region us-east-1 --name eks-cluster-for-capstone-project' for configuring the kubeconfig file.
2. "kubectl apply -f ${filePath}"
where the filepath are: Deployment/manifests, Deployment/manifests-alerting and Deployment/manifests-monitoring for the deployment of the webapp, (prometheus and gravana) and alertmanager respectiely.

![Web-page](images/Screenshot%202024-08-16%20154134.png)
![Web-page](images/Screenshot%202024-08-16%20154228.png)
![Web-page](images/Screenshot%202024-08-16%20154719.png)
![Web-page](images/Screenshot%202024-08-16%20155421.png)
![Gravana](images/Screenshot%202024-08-17%20025658.png)

## Architecture Design
Below is an architecture diagram illustrating the ecosystem we've built. It showcases the EKS cluster, node groups, networking components, and CI/CD pipeline. (insert image)

## Conclusion
In this article, we covered the step-by-step process of configuring an AWS EKS cluster with Terraform, deploying a web application and monitoring tools using kubectl, and setting up a Jenkins CI/CD pipeline. Leveraging these modern tools and practices enhances the reliability and scalability of your applications, paving the way for successful cloud deployment.
Feel free to modify the configurations according to your requirements and start deploying your applications today!

