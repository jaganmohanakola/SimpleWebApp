#!/bin/bash
export MAVEN_HOME=/opt/maven
export PATH=$PATH:$MAVEN_HOME/bin

echo "strat deploying the war file"
cd /var/lib/jenkins/workspace/MySimpleWebApp
if [ -f /var/lib/jenkins/workspace/MySimpleWebApp/pom.xml ]
then
echo "pom file exists and ready to deploy"
sleep 10
mvn -version
mvn tomcat7:deploy
else
echo "pom file does not exists please check"
fi
