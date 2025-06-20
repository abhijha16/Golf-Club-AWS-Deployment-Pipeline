![Technologies](https://img.shields.io/badge/technologies-Html%20-green.svg)
![Technologies](https://img.shields.io/badge/technologies-CSS%20-green.svg)
![Technologies](https://img.shields.io/badge/technologies-Javascript%20-green.svg)
![Technologies](https://img.shields.io/badge/technologies-Docker%20-green.svg)

# Golf-Club-AWS-Deployment-Pipeline
## Overview
This project showcases a fully **automated CI/CD pipeline** for a static Golf Club website, built using **Jenkins, Docker**, and hosted on **AWS EC2**.

The frontend was developed using basic HTML, CSS, and JavaScript. I took charge of the entire DevOps lifecycle: from automating quality and security checks to building and deploying Docker containers. The pipeline was built from scratch, integrating tools like **SonarQube, Retire.js, Docker Hub, and GitHub webhooks**.

## 🔁 CI/CD Workflow Overview
Whenever code is pushed to the main branch of this repository, a GitHub webhook automatically triggers a Jenkins pipeline. Here's what happens next:

- Jenkins clones the repository.
- SonarQube runs static code analysis to ensure code quality.
- Retire.js scans JavaScript dependencies for known vulnerabilities.
- A Docker image is built using Nginx to serve the static files.
- The image is pushed to Docker Hub.
- Jenkins triggers a separate job called GOLF_CD which pulls the latest image and runs it on a live AWS EC2 instance.

This results in seamless deployment with zero manual intervention.
