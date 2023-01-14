source common.sh

COMPONENT=cart

NODEJS

 #update ips
echo configuring ${COMPONENT} systemd services
mv /home/roboshop/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service &>>/tmp/${COMPONENT}.log
systemctl daemon-reload &>>/tmp/${COMPONENT}.log
statuscheck

echo starting ${COMPONENT} services
systemctl start ${COMPONENT} &>>/tmp/${COMPONENT}.log
systemctl enable ${COMPONENT} &>>/tmp/${COMPONENT}.log
statuscheck