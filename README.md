# Demo — Spring Boot Application

A simple Spring Boot web application. (TESTING)

## Prerequisites

- JDK 17 or higher
- No need to install Maven separately (Maven Wrapper `mvnw` is included)

### Install JDK (Ubuntu/Debian)

```bash
sudo apt install openjdk-21-jdk
```

Verify:

```bash
java -version
javac -version
```

## Running Locally

```bash
./mvnw spring-boot:run
```

The app starts on **http://localhost:9090**

## Configuration

Edit `src/main/resources/application.properties` to change settings:

```properties
server.port=9090
```

## Building a WAR File

```bash
./mvnw package
```

The WAR file is generated at:

```
target/demo-0.0.1-SNAPSHOT.war
```

## Deployment

Copy the WAR file to your Tomcat `webapps/` directory:

```bash
cp target/demo-0.0.1-SNAPSHOT.war /path/to/tomcat/webapps/
```

The app will be available at:

```
http://localhost:8080/demo-0.0.1-SNAPSHOT/
```

> The context path is based on the WAR filename. Rename the WAR to `ROOT.war` to serve from `/`.
