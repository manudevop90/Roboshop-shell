# this script is only for dry
statuscheck() {
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mfaile\e[0m"
  exit 1
fi
}
DOWNLOAD()
{
  echo dowloading content
  curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip"  &>>${LOG}
  statuscheck
}

APP_USER_SETUP() {
  id roboshop &>>${LOG}
  if [ $? -ne 0 ]; then
     echo adding application user
     useradd roboshop  &>>${LOG}
     statuscheck
  fi
  }
APP_CLEAN() {
  echo cleaning old application content
 cd /home/roboshop  &>>${LOG} && rm -rf ${COMPONENT} &>>${LOG}
 statuscheck

 echo extract application archive
 unzip -o /tmp/${COMPONENT}.zip &>>${LOG} && mv ${COMPONENT}-main ${COMPONENT} &>>${LOG} && cd ${COMPONENT} &>>${LOG}
 statuscheck
}

SYSTEMD() {
echo configuring ${COMPONENT} systemd services
mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service &>>${LOG} && systemctl daemon-reload &>>${LOG}
statuscheck

echo starting ${COMPONENT} services
systemctl start ${COMPONENT} &>>${LOG} && systemctl enable ${COMPONENT} &>>${LOG}
statuscheck
}

NODEJS()
{
echo setting nodejs repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>${LOG}
statuscheck

echo installing nodejs
yum install nodejs -y  &>>${LOG}
statuscheck
APP_USER_SETUP
DOWNLOAD
APP_CLEAN

echo installing nodejs Dependencies
npm install &>>${LOG}
statuscheck
 #update ips
SYSTEMD
}


JAVA() {
echo install maven
yum install maven -y &>>${LOG}
statuscheck
APP_USER_SETUP

DOWNLOAD
APP_CLEAN

echo make application package
mvn clean package &>>${LOG} && mv target/shipping-1.0.jar shipping.jar &>>${LOG}
statuscheck
SYSTEMD
 }

user_id=$(id -u)
 if [ $user_id -ne 0 ]; then
   echo -e "\e[32m you should run this script as root user or sudo\e[0m"
   exit 1
  fi

LOG=/tmp/${COMPONENT}.log
rm -f ${LOG}

