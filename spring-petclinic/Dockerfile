FROM openjdk:8-jdk-alpine
RUN mkdir /EE
ADD ./target/*.jar /EE
WORKDIR /EE
RUN chmod +x *.jar
CMD java -jar *.jar

