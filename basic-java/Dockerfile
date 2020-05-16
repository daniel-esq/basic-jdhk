FROM openjdk:8-jdk-alpine

COPY target/basic-java-0.1.0.jar /basic-java.jar
COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY config/ /config/

RUN chmod 744 /basic-java.jar
RUN chmod 744 /docker-entrypoint.sh

ENTRYPOINT /docker-entrypoint.sh
EXPOSE 8181
