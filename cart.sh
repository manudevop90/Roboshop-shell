source common.sh

NODEJS

echo dowloading content
curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip"  &>>/tmp/cart.log
cd /home/roboshop  &>>/tmp/cart.log
statuscheck

echo cleaning old application content
rm -rf cart &>>/tmp/cart.log
statuscheck

echo extract application archive
unzip -o /tmp/cart.zip  &>>/tmp/cart.log
mv cart-main cart &>>/tmp/cart.log
cd cart &>>/tmp/cart.log
statuscheck

echo installing nodejs Dependencies
npm install &>>/tmp/cart.log
statuscheck

 #update ips
echo configuring cart systemd services
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service &>>/tmp/cart.log
systemctl daemon-reload &>>/tmp/cart.log
statuscheck

echo starting cart services
systemctl start cart &>>/tmp/cart.log
systemctl enable cart &>>/tmp/cart.log
statuscheck