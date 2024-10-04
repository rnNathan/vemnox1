#
# Build stage
#
FROM maven:3.8.4-openjdk-17 AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

# Build do Maven SEM testes unitarios
RUN mvn clean package -DskipTests

#
# Package stage
#
FROM openjdk:17-jdk-alpine

WORKDIR /app

COPY --from=build /app/target/vemnox1-0.0.1-SNAPSHOT.jar vemnox1.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","/app/vemnox1.jar"]