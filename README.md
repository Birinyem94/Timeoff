# Timeoff

This repository contains the IAC and CI/CD workflow for Timeoff Application in Aws. 

It contains timeoff-management application (https://github.com/timeoff-management/timeoff-management-application) whose infrastructire has been provisioned by terraform, running in AWS as a kubernetes service (EKS), getting built and deployed automatically by a CI/CD automation in github. 

Technologies Used:
Container Service: AWS Elastic Kubernetes Service (EKS) for container orchestration.
CI/CD Automation: Github Actions for building, testing, and deploying the application.
IaC Tool: Terraform for defining and provisioning AWS infrastructure.
Load Balancing: AWS Elastic Load Balancer (ELB) for distributing traffic across multiple instances.
Networking: AWS Virtual Private Cloud (VPC) for networking configuration.
Subnet Configuration: Public and private subnets for load balancer and application servers respectively.
Security Groups: For controlling inbound and outbound traffic.
Auto Scaling: AWS Auto Scaling for ensuring HA and scalability.
Monitoring: AWS CloudWatch for monitoring the infrastructure and application logs.


<img width="1356" alt="Screen Shot 2024-03-04 at 6 58 34 AM" src="https://github.com/Birinyem94/Timeoff/assets/120755263/94b08523-fcdf-45a7-98a3-d67fbce97be1">


Challenges Faced:
AWS Certificate Manager (ACM) for SSL certificates.---#issues with ACM, i was not approved for one but i managed to get it sorted 
how to create an organization and gain access into the app 
pod crashing at some point

Improvements:
Timeoff App: updated version
Documentation: I should Document the project setup, including AWS configurations, CI/CD pipeline steps, Kubernetes resources, and SSL certificate management. This will help clarify the setup process and troubleshoot issues more effectively.
