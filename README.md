# Repository comprising of my configuration for Testing and Deploying my resume as a static website
This is part of the Cloud Resume Challenge by Forrest Brazeal (AWS version) [book](https://cloudresumechallenge.dev/).

## Testing and Deployment diagram:
![resumeDiagram drawio (1)](https://user-images.githubusercontent.com/109807058/207149434-1a3d9db0-7dab-4356-88a3-be7ba6b96c0a.png)

This repo contains two workflows:
### 1. [deployment-workflow.yml](https://github.com/b-abh-007/Resume-testing-and-deployment/blob/main/.github/workflows/deployment-workflow.yml)
The purpose behind this repo is to deploy the workflow using terraform, then test it using cypress.
This workflow primarily verifies the terraform version installed. Runs terraform init, and applies the changes with terraform apply to the make the changes in the AWS account.

### 2. [testing-workflow.yml](https://github.com/b-abh-007/Resume-testing-and-deployment/blob/main/.github/workflows/testing-workflow.yml)
This workflow runs cypress commands to test whether the website registers and increments the visitor counter after the deployment by terraform. It does so by 
  1. visiting the website, 
  2. registering the number of visitors, 
  3. refreshing the page, 
  4. checking if the visitor counter increments. 

However, this testing approach isn't entirely valid, because the visitor counter increments even when the same visitor simply refreshes the page. 
As a future step and a mod from the original challenge, we could acquire the API Gateway request metadata for the IP address associated with the browser making the API call. We could use this data, and set a specific timeframe by which the same viewer is considered re-visiting. 
