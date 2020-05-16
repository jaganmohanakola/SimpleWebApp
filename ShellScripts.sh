#!/bin/bash
stopTomcat()
{
 if netstat -lntp | grep 8085
 then
 echo "tomcat is available in this server andd running"
 cd /opt/tomcat/bin
 echo "going to the folder path"
# testfilename=/opt/tomcat/bin/shutdown.sh
 if [ -f /opt/tomcat/bin/shutdown.sh ]
 then
 echo " file exists please start"
 sh /opt/tomcat/bin/shutdown.sh
 echo "shutdown script running"
 sleep 20
 else
 echo "something went wrong unableto stop"
 fi
 else 
 echo "tomcat is not runnign please check once"
 fi
}

startTomcat()
{
 echo "checck if tomcat is running"
 if netstat -lntp | grep 8085
 then
 echo "tomcat is already running"
 else
 echo "tomcat is not running going to start"
 sh /opt/tomcat/bin/startup.sh
 echo "tomcat start up"
 sleep 20
 fi
}

appBackUp()
{
 echo "inside app Back up func"
 if [ -f /opt/tomcat/webapps/*.war ]
 then
 echo "file exists so please take backup"
 cp /opt/tomcat/webapps/*.war ./myBackUp/
 echo "file moved to back up diecctory"
 else
 echo "fnf so can not take back up"
 fi
}

appDeploy()
{
 startTomcat
 appBackUp
 echo "strat deploying the war file"
 # if [ -f /root/myRepository/SimpleWebApp/pom.xml ]
  if [ -f /root/myRepository/MyEcomm/pom.xml ]
 then
 echo "pom file exists and ready to deploy"
 cd /root/myRepository/SimpleWebApp
 # cd /root/myRepository/MyEcomm
 
 if [ -f /opt/tomcat/webapps/SimpleWebApp.war ]
 then
 echo "going to redeploy"
 mvn tomcat7:redeploy
 else
 echo "going to deploy"
 mvn tomcat7:deploy
 fi
 else
 echo "pom file does not exists please check"
 fi
}

appUnDeploy()
{
 if netstat -lntp | grep 8085
 then
 echo "tomcat is running, can do undeploy"
 if [ -f /root/myRepository/SimpleWebApp/pom.xml ]
 # if [ -f /root/myRepository/MyEcomm/pom.xml ]
 then
 
 echo "pom file exists doing undeploy by going to the path"
 # if [ -f /opt/tomcat/webapps/myEcommercePath.war ]
 
 if [ -f /opt/tomcat/webapps/SimpleWebApp.war ]
 then 
  echo "war file exists so you can start undeploy"
  cd  /root/myRepository/SimpleWebApp/
 # cd /root/myRepository/MyEcomm
 echo "going to undeploy"
 mvn tomcat7:undeploy
 else
 echo "there is no war file in the tomcat web apps"
 fi
 else
 echo "pom file does not exists"
 fi
 else
 echo "tomcat is not running please check"
 fi
}

appReDeploy()
{
 if netstat -lntp | grep 8085
 then
 echo "tomcat is running"
 # if [ -f /root/myRepository/SimpleWebApp/pom.xml ]
 if [ -f /root/myRepository/MyEcomm/pom.xml ]
 
 #  if [ -f /root/myRepository/PetClinic/pom.xml ]
 then
 echo "pom file exists going to the path directory and doing redeploy"
 # cd /root/myRepository/SimpleWebApp
 cd /root/myRepository/MyEcomm
 
 # cd /root/myRepository/PetClinic
 echo "going torun command  redeploy"
 mvn tomcat7:redeploy
 echo "redeploy command executed"
 else
 echo "pom file does not exist on the path defined"
 fi
 else
 echo "tomcat is not running please check"
 fi
}

stopStartTomcat()
{
 stopTomcat
 startTomcat
}

pullRepoGit()
{
 read -p "Enter directory nName: "  myRepository
 mkdir $myRepository
 cd $myRepository
 git clone https://github.com/jaganmohanakola/SimpleWebApp.git

}

echo " given value $1"
 case $1 in
         appBackUp|appDeploy|appUnDeploy|appReDeploy|startTomcat|stopTomcat)
                echo -e  " input value: appBackUp $1"
                 $1
         ;;
      *) echo "given wrong selection $1 "
      ;;
   esac
