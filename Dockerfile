FROM openjdk:8u181-jdk-alpine
MAINTAINER diego.alvarez.zuluaga@gmail.com

RUN apk update \
  && apk upgrade \
  && apk add --no-cache \
  bash \
  libc6-compat \
  libstdc++ \
  openssl \
  unzip

# GRADLE
ENV GRADLE_VERSION "gradle-4.10.2"
WORKDIR /opt/gradle
RUN wget https://services.gradle.org/distributions/${GRADLE_VERSION}-bin.zip && \
  unzip ${GRADLE_VERSION}-bin.zip && \
  rm ${GRADLE_VERSION}-bin.zip
ENV GRADLE_HOME=/opt/gradle/$GRADLE_VERSION
ENV PATH=$PATH:$JAVA_HOME/bin:$GRADLE_HOME/bin

# KAFKA-MONITOR
ENV KAFKA_MONITOR_VERSION "2.0.0"
WORKDIR /opt
ENV KAFKA_MONITOR_HOME=/opt/kafka-monitor
RUN wget https://github.com/linkedin/kafka-monitor/archive/${KAFKA_MONITOR_VERSION}.zip && \
  unzip ${KAFKA_MONITOR_VERSION}.zip && \
  rm ${KAFKA_MONITOR_VERSION}.zip && \
  ln -s ${KAFKA_MONITOR_HOME}-${KAFKA_MONITOR_VERSION} $KAFKA_MONITOR_HOME && \
  cd $KAFKA_MONITOR_HOME && \
  ./gradlew jar

WORKDIR $KAFKA_MONITOR_HOME
COPY kafka-monitor-start.sh kafka-monitor-start.sh
RUN chmod +x kafka-monitor-start.sh

CMD ["./kafka-monitor-start.sh"]
