# docker-sagemaker
Sagemaker is a fully managed machine lealrning service that helps machine leaarning engineers to build, train and deploy the ML models at scale. The major advantages with Sagemaker is it automates the typical iterative ML project development cycle build-train-deploy. This project shows how to host a fully custom machine learning models on AWS SageMaker and trigger the model training and deployment efficiently. As we are focussing on automating the ML model deployment process, a simple linear regression model is used. Sagemaker uses docker containers to run scripts, train algorithms and deploy models. Following are the major steps involved.

## Step 1: Create Docker Image
Docker images are useful to build the run time container for machine learning models. All the required libraries will be mentioned in the requirements.txt file and training model, data will be copied to the ECR. Sagemaker job requires that image define an Entry point and corresponding script file.

## Step 2: Register the image with AWS ECR
Sagemaker compatible image that was created in the Step 1 will be registered with ECR using Push.sh script. This script builds the docker image locally and pushes it to ECR.

## Step 3: Train the model on Docker Image
Now that traning model and required data has been uploaded to the container on AWS, we can trigger the training job whenever there is a new data available in the S3 bucket. This can triggered with a cron job or manually using the python API for sagemaker. Python code to trigger the tranining is in train_model_job.py file. Training model will be saved to a S3 bucket for the later deployement.

## Setp 4: Create the end point for model and expose it as a web service
Now that model has been trained on the new data, it's time to create an end point and expose the model as a web service. Python API for sagemaker can be used to load the model from S3 bucket and create end points. Code can be seen in deploy_model_job.py.
