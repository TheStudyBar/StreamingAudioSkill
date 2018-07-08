#!/bin/sh

rm -rf deploy
mkdir deploy

dep ensure

GOOS=linux go build -o ./deploy/streaming_audio_skill
pushd deploy
zip streaming_audio_skill.zip streaming_audio_skill
popd
aws cloudformation package \
   --template-file streaming_audio_skill.yaml \
   --output-template-file serverless-deploy_streaming_audio_skill.yaml \
   --s3-bucket tsbalexaskills
aws cloudformation deploy\
 --template-file serverless-deploy_streaming_audio_skill.yaml\
  --stack-name streaming-audio-skill-lambda\
  --capabilities CAPABILITY_IAM
