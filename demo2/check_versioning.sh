#!/bin/bash

DEMO_ID=00  # Set your unique demo ID before running

aws s3api get-bucket-versioning --bucket ps-demo-cli-client1-$DEMO_ID --query Status --output text
aws s3api get-bucket-versioning --bucket ps-demo-cli-client2-$DEMO_ID --query Status --output text
aws s3api get-bucket-versioning --bucket ps-demo-cli-client3-$DEMO_ID --query Status --output text