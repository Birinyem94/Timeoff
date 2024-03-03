# Timeoff

This repository contains the IAC and CI/CD workflow for Timeoff Application in Aws. 

It contains timeoff-management application (https://github.com/timeoff-management/timeoff-management-application) whose infrastructire has been provisioned by terraform, running in AWS as a container service (EKS), getting built and deployed automatically by a CI/CD automation in github. 

Technologies Used:
Container Service: AWS Elastic Kubernetes Service (ECS) for container orchestration.
CI/CD Automation: Github Action for building, testing, and deploying the application.
IaC Tool: Terraform for defining and provisioning AWS infrastructure.
Load Balancing: AWS Elastic Load Balancer (ELB) for distributing traffic across multiple instances.
Networking: AWS Virtual Private Cloud (VPC) for networking configuration.
Subnet Configuration: Public and private subnets for load balancer and application servers respectively.
Security Groups: For controlling inbound and outbound traffic.
Auto Scaling: AWS Auto Scaling for ensuring HA and scalability.
Monitoring: AWS CloudWatch for monitoring the infrastructure and application logs.

SSL Termination: AWS Certificate Manager (ACM) for SSL certificates.---#issues with ACM--in progress


Challenges Faced:
Getting the right version for some of the application dependencies 
SSL Certificate: Obtaining an SSL certificate for your application and configuring it for use with a load balancer proved challenging, especially that i encountered issues with domain validation or DNS configuration.

Improvements:
Timeoff App: updated version
Documentation: I should Document the project setup, including AWS configurations, CI/CD pipeline steps, Kubernetes resources, and SSL certificate management. This will help clarify the setup process and troubleshoot issues more effectively.
