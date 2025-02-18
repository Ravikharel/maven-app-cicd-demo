FROM tomcat:11.0.3
WORKDIR /usr/local/tomcat
ADD **/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh","run"]