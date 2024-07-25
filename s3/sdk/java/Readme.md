# Create a new Maven Project, copy / paste in terminal

mvn -B archetype:generate \
 -DarchetypeGroupId=software.amazon.awssdk \
 -DarchetypeArtifactId=archetype-lambda -Dservice=s3 -Dregion=EU-CENTRAL-1 \
 -DarchetypeVersion=2.26.24 \
 -DgroupId=com.example.myapp \
 -DartifactId=myapp