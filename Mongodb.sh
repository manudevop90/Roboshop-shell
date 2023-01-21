
source common.sh

COMPONENT=mongodb

echo setup yum repo
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo
statucheck

echo install mongodb
yum install -y mongodb-org &>>${LOG}
statuscheck

echo start mongodb service
 systemctl enable mongod &>>${LOG} && systemctl start mongod &>>${LOG}
 stautscheck

DOWNLOAD

echo extack schema files
cd /tmp && unzip -o mongodb.zip &>>${LOG}
statuscheck

echo load schema
cd mongodb-main && mongo < catalogue.js && mongo < users.js &>>${LOG}

