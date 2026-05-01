# Demo 2: Command-Line-Based Resource Management

## Goal

Understand in practice the pitfalls of managing cloud resources using command-line scripts.

## Key terms

Drift detection - detecting the difference between current and desired configuration 
Idempotence - running the same commands multiple times will always produce the same result: either create/configure a resource if it does not exist, or do nothing if it already does

## We will focus on three issues:
1. No preview before changes: the script runs immediately with no summary of what will be created, modified, or deleted.
2. No drift detection: the script has no built-in way to compare actual infrastructure configuration against the expected configuration
3. Not idempotent: running the same script twice may cause errors or unintended changes


## Task

Create three S3 buckets with versioning enabled (deletion protection) using a command-line script.

## Prerequisites

- IAM User with programmatic access and credentials configured via **aws configure**
- Permissions: **s3:CreateBucket**, **s3:DeleteBucket**, **s3:PutBucketVersioning**, **s3:GetBucketVersioning**

## Steps

0. Before running each script change the value of DEMO_ID from 00 to your unique 
   number which can be the day and month of your birthday combined.

[Issue 1] No preview before changes:

1. Run the script:

   ```bash
   % bash create_buckets.sh
   make_bucket: ps-demo-cli-client1-00
   make_bucket: ps-demo-cli-client2-00
   make_bucket: ps-demo-cli-client3-00
   Enabling versioning on all buckets...
   ```

   Notice there is no summary of what was created or configured.
   There's no preview of changes that will be made.

2. Check which buckets have versioning enabled : 

    ```bash
    % bash check_versioning.sh 
    Enabled
    Enabled
    None
    ```

    It seems that one of the buckets doesn't have versioning enabled 
    (output in the last line is None), but the create_buckets.sh script
    ran successfully.
    Scripts are often ad-hoc and here the output is not immediately clear,
    you have to look into the script to know for sure what the output means.

[Issue 1 Impact] Files in Client's 3 bucket are not protected from accidental deletion
                and we need to explicitly check if all of the operations were successful.
                You might not find out until it's too late that configuration is not consistent. Perhaps when a client will lose important files.
        
[Issue 2] No drift detection 
         (No easy way to detect if we change existing configuration or not)
[Issue 3] No idempotency 
         (When you run script multiple times the outcome might be different on every run)

3. Disable versioning on **ps-demo-cli-client1-[your-demo-id]**:

    ```bash
    % bash disable_versioning_on_1.sh
    ```
4. Check if the change was successful:

    ```bash
    % bash check_versioning.sh
    Suspended
    Enabled
    None   
    ``` 

5. Run the script again:

    ```bash
   % bash create_buckets.sh
    make_bucket failed: s3://ps-demo-cli-client1-00 An error occurred (BucketAlreadyOwnedByYou) when calling the CreateBucket operation: Your previous request to create the named bucket succeeded and you already own it.
    make_bucket failed: s3://ps-demo-cli-client2-00 An error occurred (BucketAlreadyOwnedByYou) when calling the CreateBucket operation: Your previous request to create the named bucket succeeded and you already own it.
    make_bucket failed: s3://ps-demo-cli-client3-00 An error occurred (BucketAlreadyOwnedByYou) when calling the CreateBucket operation: Your previous request to create the named bucket succeeded and you already own it.
    Enabling versioning on all buckets...
    ```

    ```bash
    % bash check_versioning.sh
    Enabled
    Enabled
    None
    ```

[Issue 2 Impact] No drift detection: we overwrite versioning configuration without knowing
                that we did it. No warning after "Enabling versioning on all buckets...".

                The versioning was suspended for Client 1 because client was uploading
                too many files and the S3 cost went through the roof. Now it's enabled
                and the cost will continue to increase.

[Issue 3 Impact] No idempotency: we run script to create resources twice. On the second run some resources like S3 Bucket will give an already created error, other like EC2 instances (Virtual servers) will create new resources on every run.


## Key takeaways
- You can solve all issues that we've discussed by 
  writing script with proper error handling and
  taking into the account all of the edge cases

- But, it's time consuming and we only worked with
  a single resource and single configuration option

- The more types of resources you will use and the more
  configuration option you need to support the harder
  it will be to maintain script-based solutions

## Cleanup

    ```bash
    % bash ./remove_buckets.sh 
    remove_bucket: ps-demo-cli-client1-00
    remove_bucket: ps-demo-cli-client2-00
    remove_bucket: ps-demo-cli-client3-00
    ```
