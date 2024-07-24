# Import the AWS.Tools.S3 module
Import-Module AWS.Tools.S3

# Get the AWS region from the environment variable
$region = "us-east-1"

# Prompt for the S3 bucket name
$bucketName = Read-Host -Prompt "Enter the S3 bucket name"

# Output the region and bucket name
Write-Host "AWS Region: $region"
Write-Host "S3 Bucket: $bucketName"

New-S3Bucket -BucketName $bucketName -Region $region
