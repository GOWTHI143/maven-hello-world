FROM maven:3.8.6-openjdk-8 as build
ARG BRANCH_NAME=qa
RUN git clone https://github.com/GOWTHI143/maven-hello-world.git &&\
    cd maven-hello-world/my-app && mvn package

FROM openjdk:8 
LABEL project="simplemavenm-project"
LABEL maintainer="name"
COPY --from=build ./maven-hello-world/my-app/target/my-app-1.0-SNAPSHOT.jar .
CMD [ "java", "-jar", "my-app-1.0-SNAPSHOT.jar" ]