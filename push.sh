# construct the ECR name.
account=$(aws sts get-caller-identity --query Account --output text)
region=$(aws configure get region)
fullname="${account}.dkr.ecr.${region}.amazonaws.com/docker-sagemaker:latest"

# create the repository in ECR.
aws ecr create-repository --repository-name "docker-sagemaker" > /dev/null

# Get the login command from ECR and execute it directly
$(aws ecr get-login --region ${region} --no-include-email)

# Build the docker image, tag it with the full name, and push it to ECR
docker build  -t "docker-sagemaker" quilt-sagemaker-demo/
docker tag "docker-sagemaker" ${fullname}

docker push ${fullname}