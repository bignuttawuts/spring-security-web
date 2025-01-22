# Stage 1: Build
FROM gradle:8.4-jdk17 AS build
COPY build.gradle.kts .
COPY settings.gradle.kts .
COPY src ./src
RUN gradle build -x test

# Stage 2: Run
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
