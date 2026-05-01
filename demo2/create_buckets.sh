#!/bin/bash

DEMO_ID=00  # Set your unique ID before running

# Create buckets
aws s3 mb s3://ps-demo-cli-client1-$DEMO_ID
aws s3 mb s3://ps-demo-cli-client2-$DEMO_ID
aws s3 mb s3://ps-demo-cli-client3-$DEMO_ID

# Enable versioning on all buckets
echo "Enabling versioning on all buckets..."
aws s3api put-bucket-versioning \
    --bucket ps-demo-cli-client1-$DEMO_ID \
    --versioning-configuration Status=Enabled

aws s3api put-bucket-versioning \
    --bucket ps-demo-cli-client2-$DEMO_ID \
    --versioning-configuration Status=Enabled

# Small typo, big impact
# We've missed setting up versioning on client3
# Now, if a client remove file, it's gone forever
# aws s3api put-bucket-versioning \
#     --bucket ps-demo-cli-client2-$DEMO_ID \
#     --versioning-configuration Status=Enabled

# Uncomment to fix versioning for client3
aws s3api put-bucket-versioning \
   --bucket ps-demo-cli-client3-$DEMO_ID \
   --versioning-configuration Status=Enabled