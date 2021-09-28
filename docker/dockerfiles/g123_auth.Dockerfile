FROM amazoncorretto:11

ARG VERSION
ARG JAR_FILE=target/*.jar

ENV TZ=Asia/Tokyo
ENV RUN_ENV=production
ENV DD_SERVICE_NAME=g123-auth
ENV DD_SERVICE_MAPPING=mysql:g123-auth-mysql,redis:g123-auth-redis
ENV DD_TRACE_ANALYTICS_ENABLED=true
ENV DD_PROFILING_ENABLED=true
ENV DD_VERSION=${VERSION}

EXPOSE 8080
WORKDIR /app

ADD https://repository.sonatype.org/service/local/artifact/maven/redirect?r=central-proxy&g=com.datadoghq&a=dd-java-agent&v=LATEST ./dd-java-agent.jar
COPY ${JAR_FILE} app.jar

CMD ["sh", "-c", "java -XX:MaxRAMPercentage=75 -javaagent:./dd-java-agent.jar -Ddd.trace.global.tags=env:${RUN_ENV} -server -Dfile.encoding=UTF-8 -Dspring.profiles.active=${RUN_ENV} -jar app.jar"]
