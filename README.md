# Provision a new application server and deploy the following application #

## What is this repository for? ##
This repo contains a simple webapp that we will like a devOps engineer to create IaC to provision, deploy and host in their favourite cloud services provider


### How do I get set up? ###

* Choose your favourite cloud service provider. We prefer AWS, but you can use GCP or Azure .. or *gasp* Oracle Cloud

* Use an Infrastructure as code (IaC) tool like Cloud formation, Terraform, Google Cloud Deployment Manager or similar to specify the resources you need to host this application

* Create a pipeline to deploy and create your infrastruction in your chosen cloud services provider. You can use bitbucket's built in pipeline feature, or if you prefer, fork this entire repo to Github or Gitlabs and use their pipelines.

* Avoid if possible deploying from your local. This is fine when you are developing, but will be frowned on in the completed product.
 

### Dependencies ###
* Access to a cloud service provider. You can set up a trial account for this exercise. However do NOT supply your access keys to us. We will use our own sandbox account when running and deploying the completed code

### Acceptance Criteria ###
When you are done please supply these items

* Link to a bitbucket or Github or Gitlab repository with your completed project

* Tech stack that you are using documented in a README

* Documented reasons why you choose your given tech stack will be highly regarded as it helps us understand your decision making process

* A commit history in your repository that shows your development process will also be highly regarded

* Your tech stack should address these considerations :
    * Ability to refresh your entire stack using a deployment pipeline
  
    * Ability to update the stack with changes to the infra code
  
    * Ability to destroy your entire stack using a deployment pipeline
  
    * Ability to perform a zero or close to zero downtime update of the application


* Deployment instructions documented in a README

* How to run any infra validation tests if any documented in a README

### Laravel Application ###
This includes a Php laravel8 application, follow the steps to run the application to see what it is like. You may use the included dockerfile or treat is as a guide when configuring your chosen hosting platform.

1. Execute `docker-compose build`
1. Execute `docker-compose up -d`
1. Browse application `http://localhost:8000`
1. `docker-compose down` shut down application

### Who do I talk to for assistance? ###

* Source Repository owner or admin or your interview contact
