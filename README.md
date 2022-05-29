## Methods

I have identifed two methods which can deploy this docker based application to a remote server.

1. Use GitHub actions to build up infrastructure as well as dcokerize the application and then upload it to container registry and then pull it from registry and deploy it to a remote server.

2. Use Jenkins to automate the process of building up infrastructure as well as dockerizing the application and then uploading it to container registry and then pulling it from registry and deploying it to a remote server.

## Method I have used

In here I have used second method to deploy the application. Here my aim was to automate Jenkins build process when a push to GitHub is made using GitHub web hook.


## Used Tools and Technologies

1. Docker
2. Jenkins
3. GitHub

## Finished Parts

1. Create Infrastructure for application server using Terraform
2. Create Infrastructure for jenkin server using Terraform
3. Install Jenkins using 
4. Store the Sectrets in Secret Manager

## Failed Parts

1. Try to autmoate create admin user and install plugins and pipeline configuratin using bash.
2. Build the application using and deployed it to a remote server using Jenkins.