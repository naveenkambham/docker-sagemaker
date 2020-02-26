#!/bin/bash
if [[ "$1" = train ]]
then
    jupyter nbconvert --execute --ExecutePreprocessor.timeout=-1 --to notebook --inplace build.ipynb
else
    python -c "import t4; t4.Package.install('docker-sagemaker', registry='s3://docker-sagemaker', dest='.')"
    cp docker-sagemaker/lr_model lr_model
    rm -rf aleksey/
    python -m flask run --host=0.0.0.0 --port=8080
fi
