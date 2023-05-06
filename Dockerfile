FROM public.ecr.aws/docker/library/amazoncorretto:17.0.7-al2
COPY --from=public.ecr.aws/awsguru/aws-lambda-adapter:0.7.0 /lambda-adapter /opt/extensions/lambda-adapter
EXPOSE 8080
WORKDIR /opt

COPY target/quarkus-app/lib/ /opt/lib/
COPY target/quarkus-app/*.jar /opt/
COPY target/quarkus-app/app/ /opt/app/
COPY target/quarkus-app/quarkus/ /opt/quarkus/

ENV JAVA_OPTS="-Dquarkus.http.host=0.0.0.0 -Djava.util.logging.manager=org.jboss.logmanager.LogManager"
CMD ["java", "-jar", "quarkus-run.jar"]
