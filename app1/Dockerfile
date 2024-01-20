FROM amazoncorretto:17-alpine3.17
VOLUME /tmp
COPY applications/app-service/build/libs/*.jar app1.jar
ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=70 -Djava.security.egd=file:/dev/./urandom"
# Replace with a non-root user to avoid running the container with excessive privileges
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS  -jar app1.jar" ]
