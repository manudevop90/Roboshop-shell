source common.sh

NODEJS

COMPONENT=cart

 #update ips
echo configuring cart systemd services
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service &>>/tmp/cart.log && systemctl daemon-reload &>>/tmp/cart.log
statuscheck

echo starting cart services
systemctl start cart &>>/tmp/cart.log && systemctl enable cart &>>/tmp/cart.log
statuscheck