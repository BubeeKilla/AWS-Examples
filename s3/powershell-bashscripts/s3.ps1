# Import the AWS.Tools.S3 module
Import-Module AWS.Tools.S3

# Get the AWS region from the environment variable
$region = "us-east-1"

# Prompt for the S3 bucket name
$bucketName = Read-Host -Prompt "Enter the S3 bucket name"

# Output the region and bucket name
Write-Host "AWS Region: $region"
Write-Host "S3 Bucket: $bucketName"

function BucketExists {
    $bucket = Get-S3Bucket -BucketName $bucketName -ErrorAction SilentlyContinue
    return $null -ne $bucket
}

if (-not (BucketExists)) {
    Write-Host "Bucket does not exist..."
    New-S3Bucket -BucketName $bucketName -Region $region
} else {
    Write-Host "Bucket already exists..."
}

# Create new file
$fileName = "myfile.txt"
$fileContent = "Hello World Update"
Set-Content -Path $fileName -Value $fileContent

Write-S3Object -BucketName $bucketName -File $fileName -Key tmp/$fileName