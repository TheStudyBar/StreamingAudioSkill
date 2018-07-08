#!/bin/sh

rm -rf deploy
mkdir deploy
GOOS=linux go build -o ./deploy/hello
pushd deploy
zip hello.zip hello
popd
aws cloudformation package \
   --template-file hello.yaml \
   --output-template-file serverless-deploy_hello.yaml \
   --s3-bucket tsbalexaskills
aws cloudformation deploy\
 --template-file serverless-deploy_hello.yaml\
  --stack-name hello-lambda\
  --capabilities CAPABILITY_IAM