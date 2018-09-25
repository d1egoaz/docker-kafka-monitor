FROM java:openjdk-8-jdk-alpine
MAINTAINER diego.alvarez.zuluaga@gmail.com

RUN apk add --update openssl unzip bash libstdc++

RUN wget https://services.gradle.org/distributions/gradle-4.10.2-bin.zip && \
    unzip gradle-4.10.2-bin.zip

ENV GRADLE_HOME=/gradle-4.10.2  \
    PATH=$PATH:$JAVA_HOME/bin:$GRADLE/bin

RUN wget https://github.com/linkedin/kafka-monitor/archive/1.1.0.zip
RUN unzip 1.1.0.zip && \
    cd kafka-monitor-1.1.0 && \
    ./gradlew jar

EXPOSE 8000 9999 

