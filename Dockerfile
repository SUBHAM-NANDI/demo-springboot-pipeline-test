# # Use OpenJDK as the base image
# FROM openjdk:17-jdk

# #Identify the maintainer of an image
# LABEL vesrion="0.0.1"
# LABEL maintainer="Subham Nandi"

# # Set the working directory in the container
# WORKDIR /app

# # Copy the JAR file into the container
# COPY target/sonar-demo-0.0.1-SNAPSHOT.jar /app/sonar-demo-0.0.1-SNAPSHOT.jar

# # Expose the port your app listens on
# EXPOSE 8081

# # Command to run the WAR file
# ENTRYPOINT ["java", "-jar", "/app/sonar-demo-0.0.1-SNAPSHOT.jar"]

# #checking...


FROM openjdk:17-oracle
EXPOSE 8082
COPY target/sonar-demo-0.0.1-SNAPSHOT.jar /app/sonar-demo-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java", "-jar", "/app/sonar-demo-0.0.1-SNAPSHOT.jar"]
