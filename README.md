!https://cdn-images-1.medium.com/max/1000/1*xGM8vLqrOP-NldTIxrRJHw.png

Welcome to the inaugural article of my AWS series, specially crafted for junior developers diving into the world of cloud computing. In this series, we embark on a journey to demystify AWS services, starting with the foundational concept of AWS Identity and Access Management (IAM).

IAM serves as the cornerstone for securely managing access to AWS services and resources, making it the perfect starting point for our exploration. As junior developers, understanding IAM is crucial, as it lays the groundwork for building secure and scalable applications on AWS.

Throughout this series, we’ll delve into key IAM concepts, best practices, and practical examples to equip you with the knowledge and skills to navigate the AWS ecosystem confidently.

!https://cdn-images-1.medium.com/max/1000/1*iH9tU7cpNXONmyEkpPdE9w.png

So, let’s dive in and embark on this exciting journey together, as we unravel the intricacies of AWS IAM and set the stage for mastering cloud computing with AWS!

We will start by securing our AWS infrastructure. To get started with it we need to know AWS IAM, which stands for Identity and Access Management.

This will help to securely control access to AWS services and resources from unknown sources and grant the desired user permission.

AWS believes in providing the least privilege to the user and adding permission as per the requirements.

This topic is crucial for ensuring the security of AWS resources and will serve as the foundation for the upcoming phases of our preparation. We will delve into key concepts of IAM:

We can get access to AWS management by creating the root account. **The root account holds unparalleled access and privileges, making it a potential security risk, always secure your root account by using MFA and never share the credentials with anyone.** This is the powerhouse from where you can access all your AWS services and resources and has administrative access.

Best Practice: **IAM best practices suggest creating individual user accounts with appropriate permissions to perform specific tasks**, limiting the scope of potential security breaches.

### **What is an IAM User? :** Individual identities within your AWS account, each with a unique name and credentials (username and password or access keys) for accessing AWS services.

!https://cdn-images-1.medium.com/max/1000/1*24S5BLBXV5xAt91Ot_ZucA.png

demo_dev_2 user which the part of Developer_Group

When you create an IAM user in AWS, three identification mechanisms are provided:

1. **Friendly Name**: This is the name you specify for the IAM user, such as “Richard” or “Anaya.” It’s visible in the AWS Management Console and provides a human-readable identifier.
2. **Amazon Resource Name (ARN)**: The ARN uniquely identifies the IAM user across all AWS services and regions. It’s used for referencing IAM users in policies and resources, like this: **`arn:aws:iam::account-ID:user/Richard`**.
3. **Unique Identifier (ID)**: This is a unique identifier assigned to the IAM user by AWS. It’s primarily used for programmatic interactions and is not visible in the AWS Management Console.
- By default, there is no permission attached to the IAM User, we need to assign permissions individually to each user. We need to provide administrative permission to some while some need just to access the EC2 and S3.

What is we need to provide the same access to many IAM users, where they need to access the same AWS services e.g.: EC2, S3 And API Gateway. In that case, we will create the IAM Group.

### **What is IAM Group?:** Collections of users, allowing you to manage permissions more efficiently by assigning permissions to groups rather than individual users.

!https://cdn-images-1.medium.com/max/1000/1*EKspJvlp42hdgU4m20KZfw.png

IAM User Group

Grouping users simplifies the management of permissions because instead of assigning permissions to each user, you can assign permissions to the group as a whole. This allows for easier management of access control and ensures consistency across users who have similar roles or responsibilities within your organization.

**Get Started by creating our IAM User Group:**

Configuring an IAM User Group

> Users within AWS IAM are not bound to belong to a specific group; instead, they can be granted individual permissions tailored to their unique needs and responsibilities. This granular approach to access control ensures that each user has precisely the level of access required to fulfil their role effectively.
> 

> Moreover, AWS IAM allows users to belong to multiple groups simultaneously. This versatility enables organizations to create dynamic and adaptable access management systems, where users can seamlessly inherit permissions from multiple groups based on their evolving responsibilities within the organization.
> 

!https://cdn-images-1.medium.com/max/1000/1*71YfMvUxLpkUWvZjsxYZkw.png

You can see there are 2 users in our Developer Group

!https://cdn-images-1.medium.com/max/1000/1*Ov40ayPv4FAmmqBeFJVSFg.png

**In the above image to can see there are 5 policies currently being attached to the user group same policies are also attached to the user demo_dev_1 and demo_dev_2 as they are part of the user group, you can verify this by checking the demo_dev_2 image above.**

How can we manage what permission to be provided to the user or group, where the IAM policy came into action? **IAM policy is a JSON-based document that defines the permissions for users, groups, and roles in IAM, determining what actions users and resources can perform in AWS.**

**Example Policy:**

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::example-bucket/*",
      "Principal":{
      "AWS": ["arn:aws:iam::1234567788:root"]
    },
    {
      "Effect": "Deny",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::example-bucket/*",
      "Condition": {
        "Bool": {"aws:SecureTransport": "false"}
      }
    }
  ]
}
```

**Key components of these policies include:**

1. **Version**: The version element specifies the version of the IAM policy language being used. It’s a required component and typically set to “2012–10–17”, which is the latest version as of now.
2. **Id**: The id element is an optional identifier for the policy. It can be used for reference purposes to uniquely identify the policy within an AWS account.
3. **Statement**: The statement element is the core of an IAM policy and contains one or more individual statements, each of which grants or denies permissions for specific actions and resources.
- **Sid**: The Sid (Statement ID) is an optional identifier for the statement. It’s used for reference purposes to uniquely identify the statement within the policy.
- **Effect**: The effect element specifies whether the statement allows or denies access. It can be set to “Allow” or “Deny”.
- **Principal**: The principal element specifies the AWS entity (account, user, role, or service) to which the policy applies.
- **Action**: The action element is a list of actions that the policy allows or denies. Actions are specified using AWS service namespaces, action names, or wildcards (*).
- **Resource**: The resource element is a list of resources to which the actions specified in the statement apply. Resources can be specific ARNs (Amazon Resource Names), resource types, or wildcards (*).
- **Condition**: The condition element is optional and allows you to specify conditions under which the policy is in effect. Conditions are based on key-value pairs and can use various operators and functions.

> The principle of least privilege (PoLP) dictates that an entity, whether it’s a user, application, or process, should only be granted the minimum level of access or permissions necessary to perform its function. In the context of AWS, this means that IAM policies, which control access to AWS resources, should be scoped down to the specific actions and resources required for a particular task or role.
> 

One should regularly review and audit IAM policies, roles, and permissions. We can use tools like AWS IAM Access Analyzer to identify overly permissive policies and IAM Access Advisor to monitor the usage of IAM permissions.

In essence, the use of JSON-based policies provides a flexible and structured approach to managing access control. It allows for the fine-tuning of permissions, ensuring that users or groups have precisely the level of access needed to fulfil their roles, while simultaneously upholding the security and integrity of the entire system.

### Now that we have covered the basic concept of the IAM, let’s move to the next part.

**How can users access AWS?**

Users can access AWS resources and services through various means, depending on their requirements and preferences. Here are some common methods:

### **AWS Management Console**

- The web-based interface which we were using in our tutorial allows users to access and manage AWS services through a graphical user interface (GUI).
- Users can sign in using their IAM credentials and interact with AWS resources using the console’s intuitive interface.

### **AWS Command Line Interface (CLI)**:

- The AWS CLI is a unified tool that provides users with a command-line interface to AWS services.
- Users can execute commands to perform various tasks, such as managing EC2 instances, uploading files to S3 buckets, and configuring IAM roles. The CLI offers flexibility and automation capabilities, making it ideal for scripting and batch-processing tasks.

Before using the AWS CLI we need to install the AWS CLI in our workspace.

We need an access key to connect the cli with aws account.

**What is an Access Key?** Access keys in AWS are long-term credentials used for programmatic access to AWS services and resources. They consist of an access key ID and a secret access key, which are used to authenticate requests made to AWS APIs, SDKs, and command-line tools.

**How do use connect the cli with aws?** By running the below command you can connect with your AWS account.

```
aws configure
```

When you will the above command you will be asked to enter secret_key and access_key

!https://cdn-images-1.medium.com/max/1000/1*QyuxpRt4CBrdRrOtg7ejbQ.png

**IAM Users can generate the access key from the security credentials section present on the right-side navigation menu**

1. **Security Best Practices:**
- **Rotate Access Keys Regularly**: Rotate access keys periodically to enhance security.
- **Store Keys Securely**: Store access keys securely and avoid exposing them in plaintext or sharing them publicly.

**Tutorial to create access keys and configure them:**

Guide to generate the access keys and configure them

**Guide to installing AWS cli:**

https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

Command to check if aws cli is installed or not:

```
aws --version
```

### **AWS Software Development Kits (SDKs)**:

- AWS provides SDKs for various programming languages, including Python, Java, JavaScript, and .NET.
- Developers can use these SDKs to integrate AWS services into their applications, allowing for programmatic access to AWS resources.
- SDKs offer a range of functionalities, such as authentication, API invocation, and error handling, simplifying the development process for AWS-based applications.

**IAM Complete Tutorial:**

---

!https://cdn-images-1.medium.com/max/1000/1*_rBt-QXnxuuJ0DJ-tgKaag.png

### Now as we move towards the aws infrastructure the first service we will look is EC2 - Elastic Compute Cloud.

Amazon EC2 stands out as one of the most prominent services within AWS, offering a flexible and scalable computing environment in the cloud. **Positioned as Infrastructure as a Service (IaaS)**

Amazon Elastic Compute Cloud (EC2) is a web service provided by Amazon Web Services (AWS) that enables users to rent virtual servers, known as instances, to run their applications.

EC2 instances offer resizable computing capacity in the cloud and allow users to scale their computing resources up or down as needed quickly.

Users can choose from a variety of operating systems, including various flavours of Linux, Windows, and other operating systems. Additionally, AWS provides a wide selection of Amazon Machine Images (AMIs), which are pre-configured templates containing the operating system, software, and configurations needed to launch an instance.

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/76ea8c6c-d05d-4b7d-9d0c-eb34686e3539/472bf8d6-90ec-4d0c-8493-d16df542ea74/Untitled.png)

Basic knowledge we need to have to launch the EC2 instance include below points.

1. **Instances**: EC2 instances are virtual servers in the cloud that run applications and host data. 
2. **AMI:** OS that will be installed on the server. We can choose from a range of pre-configured AMIs provided by AWS or create custom AMIs tailored to our specific needs.
3. **Security Groups**: Security groups act as virtual firewalls that control inbound and outbound traffic to EC2 instances. We can define rules that allow or deny specific types of traffic based on protocols, ports, and IP addresses.
4. **Key Pairs**:  Key-pair help in SSH into the instance and allow us to update or install any software required. 
5. **Instance Types**: EC2 offers a diverse range of instance types optimized for different use cases, including:
    - **General Purpose**: Balanced compute, memory, and networking resources for a wide range of applications.
    - **Compute Optimized**: High-performance compute instances for compute-intensive workloads.
    - **Memory Optimized**: Instances with large memory sizes for memory-intensive applications.
    - **Storage Optimized**: Instances with high local storage capacity for data-intensive workloads.

**We will be using on general purpose - t2.micro or t3.micro as there are under free-tier**

1. **EBS :** Storage option provided by aws for storing the data processed by ec2.

**So, as we have idea about the basic concept let launch an demo instance.** 

Now let’s Understand the each term above in much detail. 

### AMI (Amazon Machine Image):

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/76ea8c6c-d05d-4b7d-9d0c-eb34686e3539/1cc4398d-4a78-498f-ade1-4fac3788faa1/Untitled.png)

- An AMI is a pre-configured template that contains the operating system, software, configurations, and metadata required to launch an EC2 instance resulting in a faster launch of boot/configuration as all your software is pre-configured.
- You can select from a range of AWS-provided AMIs or create your own custom AMIs.
- ***AMI are region-specific. If you need to use them in another region copy it across it.***

We can choose from the Public AMI which are provided by the AWS or we can configure our own AMI and use it whenever required. When we will be looking into the autoscaling concept AMI will play a crucial role their. 

**Public AMI**: These are AMIs provided directly by AWS. They come pre-configured with various operating systems, applications, and software stacks. AWS maintains these AMIs, ensuring they are up-to-date and secure. You can easily access and launch these AMIs from the AWS Management Console or via the AWS CLI. Public AMIs are a convenient option if you’re looking for a standard configuration or if you’re just starting with AWS and want to explore different setups without creating your own.

**Your Own AMI**: This are the AMI which is created by us and we need to maintain this on our. Maintenance meaning updating the software versions, looking after the security risk etc.  This allow us to tailor the ec2 as per our requirement and we can use them for the quick launch when required. We replicate across multiple instances or when you need full control over the software stack running on your instances

Even we can sell them on the AWS Marketplace which is covered below. 

**AWS Market Place:** The AWS Marketplace for Amazon Machine Images (AMIs) is like a digital store where you can find ready-to-use software packages designed to run smoothly on AWS. These AMI are maintained by 3rd party vendor. They are allow optimized and setup to easily work with AWS. We can choose from a wide range of software solutions offered by different companies, and many of them have pay-as-you-go pricing, meaning you only pay for what you use. Deploying software from the Marketplace is easy — just a few clicks, and you’re up and running. Plus, you can read reviews from other users to help you pick the best option for your needs.

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/76ea8c6c-d05d-4b7d-9d0c-eb34686e3539/47874a52-c341-447d-8397-816286476248/Untitled.png)

### **EC2 Instance Types — Overview**

Amazon EC2 offers various instance types optimized to support different workloads and use cases. Each instance type is designed with a unique combination of CPU, memory, storage, and networking capacity to meet specific performance and cost requirements. Here are some common types of EC2 instances:

https://redblink.com/amazon-ec2-instance-types/

[types-of-ec2-instances.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/76ea8c6c-d05d-4b7d-9d0c-eb34686e3539/4b39aee6-ecaa-469d-85b0-117d0f8e5309/types-of-ec2-instances.png)

**General Purpose Instances:**

- **Usage**: Balanced compute, memory, and networking resources. Suitable for a wide range of applications including web servers, small to medium databases, and development environments.

**Compute-Optimized Instances:**

- **Usage**: High-performance compute instances optimized for compute-intensive workloads requiring high CPU resources.

**Memory-Optimized Instances:**

- **Usage**: Ideal for memory-intensive workloads such as in-memory databases, real-time big data analytics, and high-performance computing (HPC).

**Storage-Optimized Instances:**

- **Usage**: Designed for applications that require high I/O performance and low-latency storage such as NoSQL databases, data warehousing, and Elasticsearch.

**Accelerated Computing Instances:**

- **Usage**: Instances equipped with specialized hardware accelerators such as GPUs or FPGAs, suitable for compute-intensive and graphics-intensive workloads.

### **Security Group**

Security Groups serve as the cornerstone of network security within the AWS environment. **They acts as a virtual firewall that controls inbound and outbound traffic to an EC2 instance.** 

Security group contains allow rules. Rules can be reference by IP or other security group. 

**Security Groups (SGs) in AWS are stateful firewalls. This means that they automatically track the state of connections and allow return traffic for established connections without the need for explicit rules.**

Understanding and configuring them is essential for the traffic control. 

- Default Behavior

> Inbound Traffic: By default, all inbound traffic is blocked, emphasizing a secure-by-default approach to network communication.
> 
> 
> Outbound Traffic: Conversely, **all outbound traffic is authorized by default**, facilitating outbound communication without unnecessary constraints.
> 

Functionality of Security Group:

- **Inbound Rules**: Inbound rules specify the traffic allowed to reach an instance. For example, an inbound rule might allow incoming traffic on port 80 (HTTP) or port 22 (SSH). By default, inbound traffic is denied unless explicitly allowed by a rule.
- **Outbound Rules**: Outbound rules define the traffic allowed to leave an instance. These rules govern the traffic initiated by the instance, such as requests to access external resources or services. Outbound traffic is generally allowed by default, but you can create rules to restrict specific outbound traffic if necessary.
- **Stateful Filtering**: SGs use stateful filtering, meaning they automatically allow return traffic for connections that are initiated from within the instance. For example, if an instance sends a request to an external server, the response traffic is allowed back to the instance without the need for an explicit outbound rule.
- **Default Deny**: By default, SGs implement a "default deny" stance, meaning that all inbound traffic is denied unless explicitly permitted by a rule. This approach enhances security by minimizing the attack surface and preventing unauthorized access to instances.
- **Dynamic Updates**: Support dynamic updates, allowing you to modify rules in real-time to adapt to changing security requirements. Changes to SG rules take effect immediately, enabling quick response to security incidents or updates to application requirements.

**Good to Know:**

- **Multiple Attachments**: SGs can be attached to multiple instances, and conversely, one instance can have multiple SGs associated with it. This flexibility allows for granular control over network traffic and access permissions for different instances within a Virtual Private Cloud (VPC)
- **Regional and VPC Limitations**: Security Groups are confined to specific regions and VPC combinations. This localization ensures that security policies are consistently enforced within defined boundaries, promoting security and compliance across AWS deployments.
- **Separate Security Group for SSH**: It's recommended to have a separate security group specifically for SSH access into the instance. This practice enhances security by isolating SSH traffic and allowing administrators to apply specific rules and restrictions tailored to SSH access requirements.
- **Troubleshooting Security Group Issues**: If there are issues with accessing an instance, it's essential to consider potential security group issues. Incorrectly configured security group rules, such as restrictive ingress or egress rules, can prevent desired network communication and lead to connectivity issues. Thoroughly reviewing and troubleshooting security group configurations can help resolve such issues effectively.

Classic Ports:

**Port 22**: SSH (Secure Shell) - Used for secure remote login and command-line access to EC2 instances. SSH encrypts data during transmission, providing a secure communication channel between the client and server.

**Port 80**: HTTP (Hypertext Transfer Protocol) - The standard port for unencrypted web traffic. Websites accessed over HTTP transmit data in plain text, making it susceptible to interception and manipulation.

**Port 443**: HTTPS (Hypertext Transfer Protocol Secure) - The secure version of HTTP that utilizes SSL/TLS encryption to secure data transmitted between the client and server. HTTPS is commonly used for accessing secure websites, such as online banking and e-commerce sites.

**Port 21**: FTP (File Transfer Protocol) - Used for transferring files between a client and a server over a network. FTP operates in plain text, making it less secure compared to other file transfer protocols.

**Port 22** : SFTP (SSH File Transfer Protocol) - A secure file transfer protocol that operates over SSH. SFTP provides encrypted file transfer capabilities, ensuring the confidentiality and integrity of data during transmission.

---

### Elastic IP:

When you stop and restart your EC2 instance, its public IP address may change due to AWS's dynamic resource management. However, in scenarios where a static IP address is necessary for applications or services, AWS offers a solution called Elastic IP.

An Elastic IP address is a static IPv4 address that can be allocated and assigned to an EC2 instance. Unlike standard public IP addresses, Elastic IPs can be remapped to different instances within the same AWS region. This flexibility allows you to maintain a consistent IP address for your application, even if the underlying EC2 instance changes.

**Elastic IP is a public IPv4**

Once allocated, **an Elastic IP remains under your ownership as long as it is not released or disassociated.** Even if the associated EC2 instance is stopped or terminated, the Elastic IP remains available for reassignment.

**An Elastic IP can be associated with only one EC2 instance at a time.** When associated with a running instance, the instance's public IP address is replaced by the Elastic IP.

**It's important to note that Elastic IPs are billed by AWS only when they are not in use. If the Elastic IP is associated with an active EC2 instance or other AWS service, you won't incur additional charges for its usage.**

**Single Instance Attachment**: An Elastic IP can only be attached to one EC2 instance at a time. If you attach it to a different instance, it will detach from the previous one.

With an Elastic IP address, you can mask the failure of an instance or software by rapidly remapping the address to another instance in account. 

**Limitations:** AWS imposes a limit of 5 EIP addresses per account by default. This limitation encourages efficient usage and prevents excessive consumption of IP resources. However, it’s possible to request an increase in this limit by contacting AWS support.

**Caution on EIP Usage:**

- While Elastic IPs provide a convenient way to maintain consistent IP addresses for EC2 instances, relying heavily on them may indicate poor architectural decisions in some scenarios. Instead of solely depending on Elastic IPs, consider alternative approaches that offer more flexibility and scalability:
- **Use DNS Name Registration**: Rather than assigning an Elastic IP directly to an instance, utilize a random public IP address and register a DNS name to it. This approach allows you to decouple the IP address from the instance, making it easier to manage and scale your infrastructure without being tied to specific IP addresses.
- **Leverage Load Balancers**: In situations where high availability and scalability are priorities, consider using AWS Load Balancers instead of Elastic IPs. Load Balancers distribute incoming traffic across multiple EC2 instances, providing fault tolerance and automatic scaling without the need for static IP addresses.

---

### Elastic Block Store (EBS):

- Elastic Block Store — This is a network drive you can attach to your instance while it runs. It allows us to persist data even after the instance termination.
- Provides block-level storage volumes that you can attach to EC2 instances to store data persistently.
- EBS volumes are independent of EC2 instances, meaning they can persist even if the instance is stopped or terminated.

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/76ea8c6c-d05d-4b7d-9d0c-eb34686e3539/1d5d4045-2175-4745-9f82-aaf8fdd91677/Untitled.png)

**Free Tier: 30 GB of free EBS storage of type General Purpose(SSD) or Magnetic per month**

**Availability Zone (AZ) Lock**:

- It’s locked to an Availability Zone(AZ)
- An EBS Volume in us-east-1a cannot be attached to us-east-1b.
- To move a volume across, you first need to snapshot it.

**Easy Detachment and Attachment**

**EBS volumes can be detached from one EC2 instance and attached to another quickly, facilitating data migration and instance management.**

**Provisioned Capacity** 

EBS volumes can be provisioned with specific capacity requirements and can be scaled up over time to accommodate growing storage needs.

You can choose from different types of EBS volumes based on performance, durability, and cost requirements.

1. **General Purpose SSD (gp2)**:
    - Provides a balance of price and performance for a wide variety of workloads.
    - Suitable for most use cases, including boot volumes and low-latency interactive applications.
2. **Provisioned IOPS SSD (io1)**:
    - Designed for I/O-intensive workloads, such as large relational databases or NoSQL databases.
    - Allows you to specify the desired level of IOPS (input/output operations per second) to meet performance requirements.
3. **Throughput Optimized HDD (st1)**:
    - Optimized for frequently accessed, large, streaming workloads.
    - Ideal for big data applications, data warehouses, log processing, and streaming media workloads.
4. **Cold HDD (sc1)**:
    - Designed for less frequently accessed workloads with large, sequential I/O patterns.
    - Provides low-cost storage for data that is infrequently accessed but requires long-term retention.
5. **Magnetic (standard)**:
    - Legacy magnetic storage type that offers the lowest cost per gigabyte of all EBS volume types.
    - Suitable for workloads with low I/O requirements or where cost optimization is a primary consideration.

**Multiple Attachments**:

- An EC2 instance can have multiple EBS volumes attached to it, providing flexibility in storage configurations.
- Attach the same EBS volume to multiple EC2 instances int the AZ(**Only available for io1/io2 family**). We can attach same volume to up to 16 instances at time.

**Delete on Termination**

- By default, EBS volumes attached to EC2 instances have "delete on termination" enabled, but this behavior can be managed.
- If add additional storage volumes do not have this setting by default and can be configured as needed.

**EBS Snapshots:** 

**EBS snapshot is a point-in-time backup of an Elastic Block Store (EBS) volume in Amazon Web Services (AWS).** 

**It captures the data on the volume at the moment the snapshot is taken, including all the data blocks, regardless of whether they contain actual data or are empty.**

**We can Copy snapshots across AZ or Region.**

**EBS Snapshot Features:**

- **EBS Snapshot Archive:**
    - Move a snapshot to an archive tier that is 75% cheaper.
    - Take 24 to 72 hours to restore the archive
- **Recycle Bin for EBS Snapshots:**
    - Set up rules to retain deleted snapshots so you can restore them after an accidental deletion.
    - Specify retention (from 1 day to 1 year)
- **Fast Snapshot restore**

---

### **Amazon EFS - Elastic File System**

- **Managed NFS (Network File System)**: EFS is a fully managed NFS service that allows you to easily create and mount file systems on multiple EC2 instances.
- **Multi-AZ Availability**: EFS operates seamlessly across multiple Availability Zones (AZs), providing high availability and durability for your file systems.
- **Scalable and Pay-per-Use**: EFS automatically scales to meet the needs of your workload, allowing you to pay only for the storage and throughput you use without the need for capacity planning.
- **Performance and Scaling**:
    - Supports thousands of concurrent NFS clients and throughput exceeding 10 GB/s.
    - Scales to petabyte-scale file systems automatically to accommodate growing data requirements.
    - Offers different Performance Modes:
        - General Purpose: Suitable for latency-sensitive use cases like web servers and content management systems.
        - Max I/O: Optimized for high throughput and parallelism, ideal for big data processing and media workflows.
- **Throughput Modes**:
    - Bursting: Provides a baseline throughput of 50 MiB/s per TB of storage with the ability to burst up to 100 MiB/s.
    - Provisioned: Allows you to set a specific throughput regardless of storage size.
    - Elastic: Automatically adjusts throughput based on workload demands, supporting up to 3 GiB/s for reads and 1 GiB/s for writes.
- **Storage Classes**:
    - Standard: Designed for frequently accessed files with high availability and durability across multiple AZs.
    - Infrequent Access (EFS-IA): Provides lower-cost storage for infrequently accessed files, with the ability to enable EFS-IA using Lifecycle Policies for cost optimization.
- **Availability and Durability**:
    - Standard: Offers multi-AZ redundancy, making it suitable for production workloads.
    - One Zone: Operates within a single AZ, ideal for development and backup scenarios with over 90% cost savings compared to standard EFS.

Amazon EFS simplifies the management of file storage in AWS, offering a scalable, durable, and cost-effective solution for a wide range of use cases, from web hosting to big data analytics. Its flexibility and ease of use make it a valuable asset for organizations looking to manage their file-based workloads in the cloud.

---

### Placement Group

When we need to control over the EC2 instance placement, the placement group strategy can come handy. This allow us to configure how our ec2 instances will be place in aws infrastructure. A placement group is a logical grouping of EC2 instances within a single Availability Zone (AZ) that enables low-latency communication between instances.

**Strategies:**

**Cluster Placement Group**: In a cluster placement group, instances are placed closely together within a single Availability Zone (AZ), allowing for high-speed, low-latency communication between them.

- **Pros:** Great network (10 Gbps bandwidth)
- **Cons:** If AZ fails, all instances fail at the same time.

**Use Case:** Strategy maximizes network performance and is ideal for applications like high-performance computing (HPC) or distributed systems that require intense inter-instance communication.

**Spread Placement Group**: In a spread placement group, instances are spread across multiple underlying hardware racks within the same AZ. Spread placement groups are suitable for applications requiring high availability and reliability where failure of one instance doesn’t affect the performance of another.

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/76ea8c6c-d05d-4b7d-9d0c-eb34686e3539/4ffc1c0c-1031-4110-b939-2aeb8833a5df/Untitled.png)

- **Pros:**
    - Can span across Availability Zones (AZ)
    - Provides fault tolerance by ensuring that instances are physically isolated from each other.
    - EC2 Instances are on different Physical Hardware
- **Cons:** Limited to 7 instances per AZ per placement group.

**Use Case:** Application that need to maximize high availability. Critical Application where each instance must be isolated from failure from each other.

**Partition Placement Group**:  A Partition Placement Group is a feature in AWS that enables logical partitioning of EC2 instances to isolate them from each other while still sharing the same underlying hardware. Each partition represents a rack in the AWS infrastructure.

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/76ea8c6c-d05d-4b7d-9d0c-eb34686e3539/f01a9ba0-bd4a-4f5e-b66b-ef60d0bf38e0/Untitled.png)

- **Partitioning and Isolation**: Instances within a Partition Placement Group are logically partitioned to ensure isolation from instances in other partitions, even though they may share the same underlying hardware.
- **Availability and Scalability**: A Partition Placement Group can span multiple Availability Zones (AZs) within the same region, accommodating up to 7 partitions per AZ and supporting hundreds of EC2 instances.
- **Fault Isolation**: In the event of a failure, such as a partition failure, only the instances within that partition are affected. Instances in other partitions remain unaffected, ensuring high availability and fault tolerance for distributed workloads.
- **Performance Isolation**: Failures in one partition do not impact the performance of instances in other partitions, providing consistent performance for large-scale distributed and replicated workloads.

**Use Case:**

Partition Placement Groups are particularly beneficial for large-scale distributed and replicated workloads, such as big data processing or NoSQL databases. By leveraging partitioning and isolation, these groups provide enhanced fault tolerance and performance isolation, ensuring the reliability and scalability of distributed applications in the cloud.

---

### ENI — Elastic Network Interface

- ENI provides network access to an EC2 instance.
- Bound to a Specific availability zone (AZ).

Some of the key attributes of ENIs:

1. **Attachment**: ENIs can be attached to EC2 instances within the same VPC. Each ENI can only be attached to one instance at a time.
2. **Private IPv4 Addresses**: Each ENI is associated with one primary private IPv4 address within the IP address range of its subnet. It can also have multiple secondary private IPv4 addresses.
3. **Public IPv4 Addresses**: ENIs can optionally be associated with a public IPv4 address, allowing instances to communicate directly with the internet.
4. **Elastic IP Addresses (EIPs)**: In addition to public IPv4 addresses, ENIs can be associated with Elastic IP addresses (EIPs) for static, persistent public IP addressing.
5. **Security Groups**: ENIs can be associated with one or more security groups, which act as virtual firewalls controlling inbound and outbound traffic to and from associated instances.
6. **Subnet**: Each ENI belongs to a specific subnet within a VPC. This determines the IP address range and network configuration for the ENI.

---

### **Key Pair**:

- A key pair consists of a public key and a private key used for securely accessing EC2 instances. The public key is stored on the instance, while the private key is kept by the user. When connecting to an instance via SSH (Secure Shell) for Linux instances or RDP (Remote Desktop Protocol) for Windows instances, the private key is used for authentication.

---

### **Security Group**:

- A security group acts as a virtual firewall that controls inbound and outbound traffic to an EC2 instance.
- You can define rules within the security group to allow or deny specific types of traffic based on IP addresses, protocols, and ports. Security groups are associated with EC2 instances and provide an additional layer of security.

---

### **IAM Role**:

- An IAM role is a set of permissions that define what actions an EC2 instance can perform within your AWS environment. IAM roles are used to grant temporary access to AWS resources without the need for long-term credentials (such as access keys). EC2 instances can be associated with IAM roles to access other AWS services securely.

### Launching an EC2 instance involves several steps. Here’s a detailed guide on each step required to launch an EC2 instance:

1. **Sign in to the AWS Management Console**:
- Go to the AWS Management Console (https://aws.amazon.com/console/) and sign in using your AWS account credentials.

**2. Navigate to the EC2 Dashboard**:

- Once logged in, navigate to the EC2 service by either searching for “EC2” in the AWS Management Console search bar or selecting “EC2” under the “Compute” section.

**3. Choose an AMI (Amazon Machine Image)**:

- In the EC2 Dashboard, click on the “Launch Instance” button to begin the instance launch wizard.
- Select an AMI from the list provided. You can choose from AWS-provided AMIs, AWS Marketplace AMIs, or your own custom AMIs.

**4. Choose an Instance Type**:

- After selecting an AMI, you’ll need to choose an instance type. Each instance type offers different combinations of CPU, memory, storage, and networking capacity.
- Click on the instance type that best fits your requirements. You can use the filter options to narrow down the list based on your needs.

**5. Configure Instance Details**:

- In this step, you’ll configure additional settings for your instance, such as the number of instances to launch, network settings, IAM role, user data (optional script executed at launch), etc.
- Configure the network settings (VPC, subnet), enable or disable termination protection, add tags for easier instance management, and specify advanced details if necessary.

**6. Add Storage**:

- Next, you’ll add storage volumes (EBS volumes) to your instance. By default, a root volume is attached to the instance. You can add additional volumes if needed, specifying volume type, size, and encryption options.

**7. Configure Security Group**:

- Configure the security group settings for your instance. You can create a new security group or select an existing one. Security groups act as virtual firewalls, controlling inbound and outbound traffic to your instance based on defined rules.

**8. Review and Launch**:

- Review all the configurations you’ve made for your instance to ensure they’re correct. Double-check the instance type, storage, security groups, etc.
- If everything looks good, click on the “Launch” button to proceed.

**9. Create a Key Pair**:

- If you haven’t already created a key pair, you’ll be prompted to create one. Key pairs are used for securely connecting to your instance via SSH (for Linux) or RDP (for Windows).
- Choose an existing key pair or create a new one, then download the private key file (.pem) to your local machine. Keep this file safe, as it’s required for SSH/RDP access.

**10. Launch Instance**:

- After creating or selecting a key pair, click on the “Launch Instances” button to launch your EC2 instance.
- AWS will start provisioning the instance based on your configurations. Once the instance is successfully launched, you’ll see a confirmation message with details about the instance.

**11. Access and Manage Your Instance**:

- Once the instance is running, you can access and manage it using various methods, such as SSH (for Linux) or RDP (for Windows) for remote access, or AWS Systems Manager Session Manager for browser-based access.
- You can also manage your instances, monitor performance, and configure additional settings from the EC2 Dashboard in the AWS Management Console.

As you embark on your journey with AWS EC2, remember that it’s not just about launching virtual servers; it’s about unleashing your creativity, optimizing resources, and building resilient and scalable solutions in the cloud. With EC2 as your companion, the possibilities are endless, and the adventures are boundless. So go forth, explore, and conquer the digital frontier with AWS EC2 at your side!
