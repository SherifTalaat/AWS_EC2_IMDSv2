# AWS EC2 IMDSv2 Helper Script

A simple PowerShell helper script based on [AWS PowerShell tools ](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-getting-set-up-windows.html) to update all EC2 instances metadata option for using HTTP Token to required (IMDSv2) instead of optional (IMDSv1).

## How it works?
1. Find active aws regions
2. Find EC2 instances in active aws regions
   - EC2 instances using IMDSv1 appears in red
   - EC2 instances using IMDSv2 appears in green
3. If any EC2 instances are running IMDSv1, user will get an option to update all instances to IMDSv2. Otherwise, user will get "No action is needed message".

**Disclaimer: This script doesn’t check for application dependencies on IMDSv1 or incompatibility with IMDSv2. This script is a helper script to update the instance metadata for EC2 instances using IMDSv1.**

Please ensure that your instance makes no IMDSv1 calls before setting IMDSv2 to required. You can do this by going to **AWS Console -> EC2 -> Select Instance -> Actions -> Instance settings -> Modify instance metadata options -> View MetadataNoToekn for your instance.**
![AWS IMDSv2 Script](https://github.com/SherifTalaat/AWS_EC2_IMDSv2/blob/main/screenshot2.png?raw=true)
This will redirect you to the CloudWatch metric, where you can find calls to Instance metadata without using a token (IMDSv1).


## How to use?
The easiest way to run this script is inside [AWS CloudShell](https://docs.aws.amazon.com/cloudshell/latest/userguide/working-with-cloudshell.html). <br>

1- Once you open AWS CloudShell, convert to the shell mode to PowerShell using *pwsh* command. <br>
2- Click **Actions ^**, then **Upload file**. <br>
3- Once upload the file to AWS Shell, use the following command to execute it and follow the instruction. <br>
<br>
***PS /home/cloudshell-user> ./IMDSv2.ps1***

![AWS IMDSv2 Script](https://github.com/SherifTalaat/AWS_EC2_IMDSv2/blob/main/screenshot1.png?raw=true)
