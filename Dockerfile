
# Stage 1: Build the application
FROM maven:3.8.8-eclipse-temurin-8 AS build

# Set the working directory
WORKDIR /app

# Copy pom.xml first
COPY pom.xml ./

# Download dependencies
RUN mvn dependency:go-offline

# Copy source code
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Stage 2: Run the application
FROM eclipse-temurin:8-jre

# Set the working directory
WORKDIR /app

# Copy the built JAR
COPY --from=build /app/target/dental-management-system-0.0.1-SNAPSHOT.jar app.jar

# Expose application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]