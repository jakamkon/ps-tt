#!/bin/bash

DEMO_ID=00  # Set your unique ID before running

aws s3api put-bucket-versioning \
    --bucket ps-demo-cli-client1-$DEMO_ID \
    --versioning-configuration Status=Suspended