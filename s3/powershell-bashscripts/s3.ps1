# Import the AWS.Tools.S3 module
Import-Module AWS.Tools.S3

# Get the AWS region from the environment variable
$region = $env:AWS_REGION

# Prompt for the S3 bucket name
$bucketName = Read-Host -Prompt "Enter the S3 bucket name"

# Output the region and bucket name
Write-Host "AWS Region: $env:AWS_REGION"
Write-Host "S3 Bucket: $bucketName"

# Define the number of retries and the delay between retries
$maxRetries = 3
$retryDelay = 5 # in seconds

$success = $false

for ($i = 0; $i -lt $maxRetries; $i++) {
    try {
        # Create the S3 bucket
        New-S3Bucket -BucketName $bucketName -Region $region -ErrorAction Stop
        Write-Host "Bucket '$bucketName' created successfully in region '$region'."
        $success = $true
        break
    } catch {
        Write-Error "Attempt $($i + 1): Failed to create the bucket. Error: $_"
        if ($i -lt ($maxRetries - 1)) {
            Write-Host "Retrying in $retryDelay seconds..."
            Start-Sleep -Seconds $retryDelay
        } else {
            Write-Error "Max retries reached. Failed to create the bucket."
        }
    }
}

if (-not $success) {
    Write-Error "Failed to create the bucket after $maxRetries attempts."
}
