# Import the AWS.Tools.S3 module to enable AWS S3 commands within PowerShell.
Import-Module AWS.Tools.S3

# Specify the AWS region. This variable sets the region where the S3 bucket operations will occur.
# Default region is set to 'us-east-1'.
$region = "us-east-1"

# Prompt the user to enter the name of the S3 bucket they wish to create or manage.
$bucketName = Read-Host -Prompt "Enter the S3 bucket name"

# Output the AWS region and the S3 bucket name to the console for verification.
Write-Host "AWS Region: $region"
Write-Host "S3 Bucket: $bucketName"

# Function to check if the specified S3 bucket exists.
function BucketExists {
    # Try to retrieve the S3 bucket with the given name.
    $bucket = Get-S3Bucket -BucketName $bucketName -ErrorAction SilentlyContinue
    
    # Return true if the bucket exists, false otherwise.
    return $null -ne $bucket
}

# Check if the bucket already exists.
if (-not (BucketExists)) {
    # If the bucket does not exist, create a new S3 bucket with the specified name and region.
    Write-Host "Bucket does not exist..."
    New-S3Bucket -BucketName $bucketName -Region $region
} else {
    # If the bucket exists, notify the user.
    Write-Host "Bucket already exists..."
}

# Define the file name and content to be created.
$fileName = "myfile.txt"
$fileContent = "Hello World Update"

# Create a new file with the specified name and content.
Set-Content -Path $fileName -Value $fileContent

# Upload the newly created file to the specified S3 bucket.
# The file is uploaded with the key 'tmp/myfile.txt' within the bucket.
Write-S3Object -BucketName $bucketName -File $fileName -Key tmp/$fileName
