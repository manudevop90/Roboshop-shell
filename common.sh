# this script is only for dry
statuscheck() {
if [ $? -eq 0 ]; then
  echo -e "\e[32msuccess\e[0m"
else
  echo -e "\e[31mFail\e[0m"
  exit 1
fi
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

echo dowloading content
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/roboshop-devops-project/${COMPONENT}/archive/main.zip"  &>>/tmp/${COMPONENT}.log && cd /home/roboshop  &>>/tmp/${COMPONENT}.log
statuscheck

echo cleaning old application content
rm -rf ${COMPONENT} &>>/tmp/${COMPONENT}.log
statuscheck

echo extract application archive
unzip /tmp/${COMPONENT}.zip &>>/tmp/${COMPONENT}.log && mv ${COMPONENT}-main ${COMPONENT} &>>/tmp/${COMPONENT}.log && cd /home/roboshop/${COMPONENT} &>>/tmp/${COMPONENT}.log
statuscheck

echo installing nodejs Dependencies
npm install &>>/tmp/${COMPONENT}.log
statuscheck
}