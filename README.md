# docker-sagemaker
Hosting fully custom machine learning models on AWS SageMaker

## Step 1: Creating Docker Image
Docker images are useful to build the run time container for machine learning models. All the required libraries will be mentioned in the requirements.txt file and training model, data will be copied to the ECR. Sagemaker job requires that image define an Entry point and corresponding script file.

## Step 2: Register the image with AWS ECR
Sagemaker compatible image that was created in the Step 1 will be registered with ECR using Push.sh script. This script builds the docker image locally and pushes it to ECR. 
