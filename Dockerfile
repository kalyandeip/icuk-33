# Stage 1: Build the application
FROM eclipse-temurin:17-jdk-slim AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Create a minimal runtime image
FROM eclipse-temurin:17-jre-slim
WORKDIR /app
COPY --from=build /app/target/my-app-1.0-SNAPSHOT.jar app.jar
USER 1000
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
