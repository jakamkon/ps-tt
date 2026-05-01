#!/bin/bash

DEMO_ID=00  # Set your unique demo ID before running

# Create buckets
aws s3 rb s3://ps-demo-cli-client1-$DEMO_ID 
aws s3 rb s3://ps-demo-cli-client2-$DEMO_ID 
aws s3 rb s3://ps-demo-cli-client3-$DEMO_ID 
 