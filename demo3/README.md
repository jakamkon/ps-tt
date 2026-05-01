# Demo 3: Terraform-Based Resource Management

## Goal

Understand in practice how Terraform solves the pitfalls of managing cloud resources using command-line scripts.

## Key terms

Drift detection - detecting the difference between current and desired configuration  
Idempotence - running the same commands multiple times will always produce the same result: either create/configure a resource if it does not exist, or do nothing if it already does

## We will focus on three solutions:
1. Plan preview before changes: Terraform shows a summary of what will be created, modified, or deleted before making any changes.
2. Drift detection: Terraform compares actual infrastructure configuration against the desired configuration defined in code.
3. Idempotent: running the same command twice will not cause errors or unintended changes.


## Task

Create three S3 buckets with versioning enabled (deletion protection) using Terraform.

## Prerequisites

- IAM User with programmatic access and credentials configured via **aws configure**
- Permissions: **s3:CreateBucket**, **s3:DeleteBucket**, **s3:PutBucketVersioning**, **s3:GetBucketVersioning**, **s3:ListBucket**

## Steps

0. Before running each command change the value of `demo_id` variable in main.tf from `"00"` to your unique number which can be the day and month of your birthday combined.

[Fix 1] Initialize the terraform working directory:
1. Run terraform init:

   ```bash
   % terraform init
   ```

   Terraform will immediately catch a bug in the configuration: a duplicate resource definition:

   ```
   Error: Duplicate resource "aws_s3_bucket_versioning" configuration
   
     on main.tf line 43:
     43: resource "aws_s3_bucket_versioning" "user2" {
   
   A aws_s3_bucket_versioning resource named "user2" was already declared at main.tf:30,1-46.
   Resource names must be unique per type in each module.
   ```

   Notice that **no changes were made**: Terraform validated the configuration and stopped before touching any infrastructure.

   Compare this to Demo 2: the CLI script ran immediately and made changes without any validation.

2. Fix the bug in **main.tf**: comment out the duplicate `aws_s3_bucket_versioning "user2"` block (lines 43–48) and uncomment the `aws_s3_bucket_versioning "user3"` block at the bottom of the file (lines 51-56)

3. Run terraform init again:

   ```bash
   % terraform init
   Initializing the backend...
   Initializing provider plugins...
   - Finding hashicorp/aws versions matching "~> 6.42.0"...
   - Installing hashicorp/aws v6.42.0...
   - Installed hashicorp/aws v6.42.0 (signed by HashiCorp)
   Terraform has created a lock file .terraform.lock.hcl to record the provider
   selections it made above. Include this file in your version control repository
   so that Terraform can guarantee to make the same selections by default when
   you run "terraform init" in the future.

   Terraform has been successfully initialized!

   You may now begin working with Terraform. Try running "terraform plan" to see
   any changes that are required for your infrastructure. All Terraform commands
   should now work.

   If you ever set or change modules or backend configuration for Terraform,
   rerun this command to reinitialize your working directory. If you forget, other
   commands will detect it and remind you to do so if necessary.
   ```

Terraform will successfully install the provider plugin for AWS that will allow us
to work with S3 buckets.

4. Run terraform plan:

   ```bash
   % terraform plan

Terraform used the selected providers to generate the following execution plan. Resource
actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_s3_bucket.user1 will be created
  + resource "aws_s3_bucket" "user1" {
      + acceleration_status         = (known after apply)
      + acl                         = (known after apply)
      + arn                         = (known after apply)
      + bucket                      = "ps-demo-tf-client-user1-00"
      + bucket_domain_name          = (known after apply)
      + bucket_namespace            = (known after apply)
      + bucket_prefix               = (known after apply)
      + bucket_region               = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + object_lock_enabled         = (known after apply)
      + policy                      = (known after apply)
      + region                      = "eu-central-1"
      + request_payer               = (known after apply)
      + tags_all                    = (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)

      + cors_rule (known after apply)

      + grant (known after apply)

      + lifecycle_rule (known after apply)

      + logging (known after apply)

      + object_lock_configuration (known after apply)

      + replication_configuration (known after apply)

      + server_side_encryption_configuration (known after apply)

      + versioning (known after apply)

      + website (known after apply)
    }

  # aws_s3_bucket.user2 will be created
  + resource "aws_s3_bucket" "user2" {
      + acceleration_status         = (known after apply)
      + acl                         = (known after apply)
      + arn                         = (known after apply)
      + bucket                      = "ps-demo-tf-client-user2-00"
      + bucket_domain_name          = (known after apply)
      + bucket_namespace            = (known after apply)
      + bucket_prefix               = (known after apply)
      + bucket_region               = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + object_lock_enabled         = (known after apply)
      + policy                      = (known after apply)
      + region                      = "eu-central-1"
      + request_payer               = (known after apply)
      + tags_all                    = (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)

      + cors_rule (known after apply)

      + grant (known after apply)

      + lifecycle_rule (known after apply)

      + logging (known after apply)

      + object_lock_configuration (known after apply)

      + replication_configuration (known after apply)

      + server_side_encryption_configuration (known after apply)

      + versioning (known after apply)

      + website (known after apply)
    }

  # aws_s3_bucket.user3 will be created
  + resource "aws_s3_bucket" "user3" {
      + acceleration_status         = (known after apply)
      + acl                         = (known after apply)
      + arn                         = (known after apply)
      + bucket                      = "ps-demo-tf-client-user3-00"
      + bucket_domain_name          = (known after apply)
      + bucket_namespace            = (known after apply)
      + bucket_prefix               = (known after apply)
      + bucket_region               = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + object_lock_enabled         = (known after apply)
      + policy                      = (known after apply)
      + region                      = "eu-central-1"
      + request_payer               = (known after apply)
      + tags_all                    = (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)

      + cors_rule (known after apply)

      + grant (known after apply)

      + lifecycle_rule (known after apply)

      + logging (known after apply)

      + object_lock_configuration (known after apply)

      + replication_configuration (known after apply)

      + server_side_encryption_configuration (known after apply)

      + versioning (known after apply)

      + website (known after apply)
    }

  # aws_s3_bucket_versioning.user1 will be created
  + resource "aws_s3_bucket_versioning" "user1" {
      + bucket = (known after apply)
      + id     = (known after apply)
      + region = "eu-central-1"

      + versioning_configuration {
          + mfa_delete = (known after apply)
          + status     = "Enabled"
        }
    }

  # aws_s3_bucket_versioning.user2 will be created
  + resource "aws_s3_bucket_versioning" "user2" {
      + bucket = (known after apply)
      + id     = (known after apply)
      + region = "eu-central-1"

      + versioning_configuration {
          + mfa_delete = (known after apply)
          + status     = "Enabled"
        }
    }

  # aws_s3_bucket_versioning.user3 will be created
  + resource "aws_s3_bucket_versioning" "user3" {
      + bucket = (known after apply)
      + id     = (known after apply)
      + region = "eu-central-1"

      + versioning_configuration {
          + mfa_delete = (known after apply)
          + status     = "Enabled"
        }
    }

Plan: 6 to add, 0 to change, 0 to destroy.

──────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take
exactly these actions if you run "terraform apply" now.
   ```

   You get a full preview of exactly what will be created — before anything happens.
   All three buckets will have versioning enabled this time.


5. Apply the configuration:

   ```bash
   % terraform apply
   ... # terraform plan output
   Plan: 6 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_s3_bucket.user1: Creating...
aws_s3_bucket.user3: Creating...
aws_s3_bucket.user2: Creating...
aws_s3_bucket.user2: Creation complete after 2s [id=ps-demo-tf-client-user2-00]
aws_s3_bucket.user3: Creation complete after 2s [id=ps-demo-tf-client-user3-00]
aws_s3_bucket_versioning.user3: Creating...
aws_s3_bucket_versioning.user2: Creating...
aws_s3_bucket.user1: Creation complete after 2s [id=ps-demo-tf-client-user1-00]
aws_s3_bucket_versioning.user1: Creating...
aws_s3_bucket_versioning.user2: Creation complete after 2s [id=ps-demo-tf-client-user2-00]
aws_s3_bucket_versioning.user3: Creation complete after 2s [id=ps-demo-tf-client-user3-00]
aws_s3_bucket_versioning.user1: Creation complete after 2s [id=ps-demo-tf-client-user1-00]

Apply complete! Resources: 6 added, 0 changed, 0 destroyed.
   ```
   Before the prompt you will see the same terraform plan output from the previous command.
   Type **yes** when prompted. Terraform will create all six resources.

   ```
   Apply complete! Resources: 6 added, 0 changed, 0 destroyed.
   ```

[Fix 1 Impact] You reviewed the changes before they were applied. No surprises, no configuration gaps.The bug caught in step 1 would have gone unnoticed in a CLI script.

[Fix 2] Drift detection
[Fix 3] Idempotency

5. Simulate configuration drift: suspend versioning on **ps-demo-tf-client-user1-[your-demo-id]** directly via the AWS CLI:

   ```bash
   % bash disable_versioning_on_1.sh
   ```

6. Run terraform plan to see what has been changed outside current configuration:

   ```bash
   % terraform plan
   
   aws_s3_bucket_versioning.user1: Refreshing state...
   
   Terraform will perform the following actions:
   
     # aws_s3_bucket_versioning.user1 will be updated in-place
     ~ resource "aws_s3_bucket_versioning" "user1" {
         ~ versioning_configuration {
             ~ status = "Suspended" -> "Enabled"
           }
       }
   
   Plan: 0 to add, 1 to change, 0 to destroy.
   ```

   Terraform detected the drift: real infrastructure has versioning `Suspended`, but the desired state is `Enabled`.

[Fix 2 Impact] Drift was detected automatically. In Demo 2 the script silently re-enabled versioning with no warning that it had been suspended. Here Terraform tells you exactly what drifted and what it will do to fix it.

7. Fix the drift by applying:

   ```bash
   % terraform apply
   ```

   Type **yes**. Terraform re-enables versioning on user1 only.

   ```
   Apply complete! Resources: 0 added, 1 changed, 0 destroyed.
   ```

8. Run terraform apply one more time:

   ```bash
   % terraform apply

   No changes. Your infrastructure matches the configuration.
   ```

[Fix 3 Impact] Idempotency: running apply when infrastructure already matches configuration does nothing. No errors, no duplicate resources, no unintended changes — unlike the CLI script in Demo 2.

## Cleanup

```bash
% terraform destroy

Destroy complete! Resources: 6 destroyed.
```
