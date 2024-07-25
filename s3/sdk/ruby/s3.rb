# Import the required libraries
require 'aws-sdk-s3'   # AWS SDK for S3
require 'pry'          # Pry is a runtime developer console and IRB alternative
require 'securerandom' # SecureRandom library for generating random strings

# Fetch the bucket name from the environment variables
bucket_name = ENV['BUCKET_NAME']
region = 'eu-central-1' # Specify the AWS region
puts bucket_name        # Output the bucket name to the console

# Create an S3 client
client = Aws::S3::Client.new

# Create a new S3 bucket with the specified name and region
resp = client.create_bucket({
  bucket: bucket_name, 
  create_bucket_configuration: {
    location_constraint: region, 
  }, 
})

binding.pry

# Generate a random number of files between 1 and 6
number_of_files = 1 + rand(6)
puts "number_of_files: #{number_of_files}"

# Loop through the number of files to be created
number_of_files.times.each do |i|
    puts "i: #{i}" # Output the current index

    # Generate a filename and output path
    filename = "file_#{i}.txt"
    output_path = "/tmp/#{filename}"

    # Create a file at the specified path and write a random UUID to it
    File.open(output_path, "w") do |f|
        f.write(SecureRandom.uuid)
    end

    # Upload the file to S3
    File.open(output_path, "rb") do |file|
        client.put_object(
            bucket: bucket_name, # Specify the bucket name
            key: filename,       # Specify the file key (name in S3)
            body: file           # Specify the file body (content)
        )
    end
end
