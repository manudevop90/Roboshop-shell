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
  curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip"  &>>/tmp/${COMPONENT}.log
  statuscheck
}

NODEJS()
{
echo setting nodejs repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>/tmp/${COMPONENT}.log
statuscheck

echo installing nodejs
yum install nodejs -y  &>>/tmp/${COMPONENT}.log
statuscheck

id roboshop &>>/tmp/${COMPONENT}.log
if [ $? -ne 0 ]; then
   echo adding application user
   useradd roboshop  &>>/tmp/${COMPONENT}.log
   statuscheck
fi

DOWNLOAD

echo cleaning old application content
cd /home/roboshop  &>>/tmp/${COMPONENT}.log && rm -rf ${COMPONENT} &>>/tmp/${COMPONENT}.log
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mfaile\e[0m"
  exit 1
fi

echo extract application archive
unzip -o /tmp/${COMPONENT}.zip &>>/tmp/${COMPONENT}.log && mv ${COMPONENT}-main ${COMPONENT} &>>/tmp/${COMPONENT}.log && cd ${COMPONENT} &>>/tmp/${COMPONENT}.log
statuscheck

echo installing nodejs Dependencies
npm install &>>/tmp/${COMPONENT}.log
statuscheck

 #update ips
echo configuring ${COMPONENT} systemd services
mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service &>>/tmp/${COMPONENT}.log && systemctl daemon-reload &>>/tmp/${COMPONENT}.log
statuscheck

echo starting ${COMPONENT} services
systemctl start ${COMPONENT} &>>/tmp/${COMPONENT}.log && systemctl enable ${COMPONENT} &>>/tmp/${COMPONENT}.log
statuscheck
 }

user_id=$(id -u)
 if [ $user_id -ne 0 ]; then
   echo -e "\e[32m you should run this script as root user or sudo\e[0m"
   exit 1
  fi

LOG=/tmp/${COMPONENT}.log
rm -f ${LOG}

