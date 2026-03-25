FROM eclipse-temurin:17-jdk AS build
WORKDIR /app
COPY .mvn .mvn
COPY mvnw .
COPY pom.xml .
RUN ./mvnw dependency:go-offline -q
COPY src ./src
RUN ./mvnw package -DskipTests

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.war app.war
EXPOSE 9090
ENTRYPOINT ["java", "-jar", "app.war"]
