# AWS EC2 IMDSv2 Helper Script

A simple PowerShell helper script based on [AWS PowerShell tools ](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-getting-set-up-windows.html) to update all EC2 instances metadata, in single AWS account, to use IMDSv2 instead of IMDSv1.

## How it works?
1. Find active aws regions
2. Find EC2 instances in active aws regions
   - EC2 instances using IMDSv1 appears in red
   - EC2 instances using IMDSv2 appears in green
3. If any EC2 instances are running IMDSv1, user will get an option to update all instances to IMDSv2. Otherwise, user will get "No action is needed message".

## How to use?
The easiest way to run this script is inside **AWS CloudShell**. <br>

1- Once you open AWS CloudShell, convert to the shell mode to PowerShell using *pwsh* command. <br>
2- Click **Actions ^**, then **Upload file**. <br>
3- Once upload the file to AWS Shell, use the following command to execute it and follow the instruction. <br>
<br>
***PS /home/cloudshell-user> ./IMDSv2.ps1***

![AWS IMDSv2 Script](https://github.com/SherifTalaat/AWS_EC2_IMDSv2/blob/main/screenshot1.png?raw=true)
