# -------------------------
# Stage 1: Dependencies
# -------------------------
FROM maven:3.9.2-eclipse-temurin-20 AS deps
WORKDIR /app

# Copy pom.xml only and download dependencies
COPY pom.xml ./
RUN mvn dependency:go-offline -B

# -------------------------
# Stage 2: Build
# -------------------------
FROM maven:3.9.2-eclipse-temurin-20 AS build
WORKDIR /app

# Copy downloaded dependencies from deps stage
COPY --from=deps /root/.m2 /root/.m2

# Copy source code
COPY pom.xml ./
COPY src ./src
# Build the JAR file
RUN mvn clean package -DskipTests

# -------------------------
# Stage 3: Runtime
# -------------------------
FROM eclipse-temurin:18-jdk-alpine AS runtime
WORKDIR /app

# Copy the built JAR from build stage
COPY --from=build /app/target/*.jar app.jar

# Expose backend port
EXPOSE 8080

# Run the Spring Boot app
ENTRYPOINT ["java", "-jar", "app.jar"]
