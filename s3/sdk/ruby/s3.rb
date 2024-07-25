# Import the required libraries
require 'aws-sdk-s3'   # AWS SDK for S3, used to interact with Amazon S3
require 'pry'          # Pry is a runtime developer console and IRB alternative, used for debugging
require 'securerandom' # SecureRandom library for generating random strings, used to create unique identifiers

# AWS S3 Bucket Configuration
bucket_name = ENV['BUCKET_NAME'] # Fetch the S3 bucket name from environment variables
region = ENV['AWS_DEFAULT_REGION'] || 'us-east-1' # Fetch the AWS region from environment variables or default to 'us-east-1'

# Pause execution and start interactive debugging session
binding.pry

# Initialize AWS S3 Client
client = Aws::S3::Client.new(region: region) # Create a new S3 client object with the specified region

# Create a new S3 bucket with the specified name and region
resp = client.create_bucket({
  bucket: bucket_name,  # The name of the bucket to create
  create_bucket_configuration: {
    location_constraint: region, # The region where the bucket will be created
  },
})

# Generate a random number of files to be created, between 1 and 6
number_of_files = 1 + rand(6)
puts "number_of_files: #{number_of_files}" # Output the number of files to be created

# Loop through the number of files to be created
number_of_files.times do |i|
  puts "i: #{i}" # Output the current index in the loop

  # Generate a filename and output path for the file
  filename = "file_#{i}.txt" # The name of the file to be created
  output_path = "/tmp/#{filename}" # The path where the file will be saved locally

  # Create a file at the specified path and write a random UUID to it
  File.open(output_path, "w") do |file|
    file.write(SecureRandom.uuid) # Write a unique identifier to the file
  end

  # Upload the file to S3
  File.open(output_path, "rb") do |file|
    client.put_object(
      bucket: bucket_name, # Specify the S3 bucket where the file will be uploaded
      key: filename,       # Specify the key (name) for the file in S3
      body: file           # Specify the content of the file to be uploaded
    )
  end
end
