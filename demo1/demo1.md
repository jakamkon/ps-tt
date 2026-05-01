## Creating S3 Buckets with Versioning (deletion protection) in AWS Console

**1. Open the AWS Management Console and go to S3** [1:15](https://loom.com/share/0fa19c2a807b4797b0afb070a7061c93?t=75)

![generated-image-at-00:01:15](https://loom.com/i/c3e15878976046a2805e93d5bfcdd463?workflows_screenshot=true)

- Start by signing in to the **AWS Management Console** ar **https://aws.amazon.com**
- Use the AWS web interface to access your account.
- From the console search bar, type **S3** and open the **S3 service**.
- This is where you can view and manage S3 buckets in the account.

**2. Create the first S3 bucket** [3:33](https://loom.com/share/0fa19c2a807b4797b0afb070a7061c93?t=213)

![generated-image-at-00:03:33](https://loom.com/i/ac4139f5954143199a65a7c3e4102cde?workflows_screenshot=true)

- Click **Create bucket**.
- Enter a bucket name, such as **demo-pl-bucket-1**. Replace 1 with a unique ID. 
- Leave most settings at their default values.
- Scroll to **Versioning** and enable it.
- Create the bucket.

**3. Create the second S3 bucket with the same settings** [4:49](https://loom.com/share/0fa19c2a807b4797b0afb070a7061c93?t=289)

![generated-image-at-00:04:49](https://loom.com/i/a6b23fb6c152435f83b539b309ce99df?workflows_screenshot=true)

- Click **Create bucket** again.
- Enter a second name, such as **demo-pl-bucket-2**. Replace 1 with a unique ID. 
- Keep the configuration the same as the first bucket.
- Enable **Versioning**.
- Create the bucket.

**4. Create the third S3 bucket with versioning enabled** [5:09](https://loom.com/share/0fa19c2a807b4797b0afb070a7061c93?t=309)

![generated-image-at-00:05:09](https://loom.com/i/4840d5dfea9844309ab236d7eebb9a68?workflows_screenshot=true)

- Create a third bucket, such as **demo-pl-bucket-3**. Replace 3 with a unique ID. 
- Use the same general setup as the previous buckets.
- Enable **Versioning** before creating it.
- At this point, you have three S3 buckets intended for financial files.

**5. Verify the buckets and their configuration manually** [6:13](https://loom.com/share/0fa19c2a807b4797b0afb070a7061c93?t=373)

![generated-image-at-00:06:13](https://loom.com/i/d7432e6aac014e98a536170e60b72f52?workflows_screenshot=true)

- Sort or review the bucket list by **Creation Date** to confirm the three buckets exist.
- Open each bucket individually.
- Check the **Properties** section to confirm whether **Versioning** is enabled.
- This manual verification is necessary because the console does not provide a simple high-level overview of all bucket settings at once.

**6. Understand the risks of manual infrastructure management** [7:52](https://loom.com/share/0fa19c2a807b4797b0afb070a7061c93?t=472)

![generated-image-at-00:07:52](https://loom.com/i/9371712a0fe24f69afba102ba35583f0?workflows_screenshot=true)

- Manual setup becomes **time-consuming** as the number of buckets increases.
- It is **error-prone**: one missed step can leave a bucket without versioning
- Missing versioning will remove the intended protection against accidental deletion.
- As the number of resources and configuration options grows, managing infrastructure this way becomes increasingly difficult.

**7. Recognize the challenge of reproducing the same setup elsewhere** [9:37](https://loom.com/share/0fa19c2a807b4797b0afb070a7061c93?t=577)

![generated-image-at-00:09:37](https://loom.com/i/6f198aace2f34002a56c4b7e0e10840f?workflows_screenshot=true)

- If you need to recreate the same buckets in another AWS account or environment, you must repeat the steps manually.
- The console does not automatically document the exact configuration process for you.
- This makes replication across environments slow and prone to mistakes.
- The overall takeaway is that manual cloud resource management does not scale well.

### Link to Loom

<https://loom.com/share/0fa19c2a807b4797b0afb070a7061c93>