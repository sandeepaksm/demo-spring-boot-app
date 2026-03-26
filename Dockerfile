# Use JDK 17 as the base image
FROM eclipse-temurin:17-jdk-focal

# Set the working directory
WORKDIR /app

# Copy the war file from the target directory to the container
COPY target/*.war app.war

# Expose the port your app runs on (usually 8080)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.war"]
