import sagemaker as sage
from sagemaker import Model

# get and pass the auth role and image path, same as before
# this step is unchanged from the training script
role = sage.get_execution_role()
sess = sage.Session()
account = sess.boto_session.client('sts').get_caller_identity()['Account']
region = sess.boto_session.region_name
image = '{}.dkr.ecr.{}.amazonaws.com/docker-sagemaker'.format(account, region)

# create a new Model object
clf = Model(
    # insert model path below
    model_data='s3://docker-sagemaker/lr_model.tar.gz',
    image=image,
    role=role,
    sagemaker_session=sess
)

# deploy it to an endpoint
predictor = clf.deploy(1, 'ml.c4.2xlarge')

# connect to the endpoint
predictor = sage.predictor.RealTimePredictor(
    'lr_model.tar.gz',
    sagemaker_session=sess,
    content_type="text/csv"
)