

source common.sh
COMPONENT=mongodb

echo setup yum repo
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>${LOG}
statuscheck

echo install mongodb
yum install -y mongodb-org &>>${LOG}
statuscheck

echo update MongoDB listen Address
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>${LOG}
statuscheck

echo start mongodb service
systemctl enable mongod &>>${LOG} && systemctl restart mongod &>>${LOG}
statuscheck

DOWNLOAD

echo extack schema files
cd /tmp && unzip -o mongodb.zip &>>${LOG}
statuscheck

echo load schema
cd mongodb-main &>>${LOG} && mongo < catalogue.js &>>${LOG} && mongo < users.js &>>${LOG}
statuscheck
