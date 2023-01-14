source common.sh

NODEJS

echo download content
 curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>/tmp/catalogue.log
 cd /home/roboshop &>>/tmp/catalogue.log
statuscheck
 echo cleaning old application content
 rm -rf catalogue &>>/tmp/catalogue.log
statuscheck
 echo extract application archive
 unzip -o /tmp/catalogue.zip &>>/tmp/catalogue.log
 mv catalogue-main catalogue &>>/tmp/catalogue.log
 cd /home/roboshop/catalogue &>>/tmp/catalogue.log
statuscheck
 echo installing nodejs dependencies
 npm install &>>/tmp/catalogue.log
statuscheck
echo configure catalogue systemd services
 mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service &>>/tmp/catalogue.log
 systemctl daemon-reload &>>/tmp/catalogue.log
statuscheck

echo starting catalogue services
 systemctl start catalogue &>>/tmp/catalogue.log
 systemctl enable catalogue &>>/tmp/catalogue.log
statuscheck