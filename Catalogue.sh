source common.sh
NODEJS
COMPONENT=catalogue


echo configure catalogue systemd services
 mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service &>>/tmp/catalogue.log &&  systemctl daemon-reload &>>/tmp/catalogue.log
statuscheck

echo starting catalogue services
 systemctl start catalogue &>>/tmp/catalogue.log &&  systemctl enable catalogue &>>/tmp/catalogue.log
statuscheck