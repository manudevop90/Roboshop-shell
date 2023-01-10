
echo setting nodejs repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>/tmp/cart.log
echo $?
if echo $? -eq 0
then
  echo \e
echo installing nodejs
yum install nodejs -y   &>>/tmp/cart.log
echo $?

echo adding application user
useradd roboshop  &>>/tmp/cart.log
echo $?

echo dowloading content
curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip"  &>>/tmp/cart.log
cd /home/roboshop  &>>/tmp/cart.log
echo $?

echo cleaning old application content
rm -rf cart &>>/tmp/cart.log
echo $?

echo extract application archive
unzip -o /tmp/cart.zip  &>>/tmp/cart.log
mv cart-main cart &>>/tmp/cart.log
cd cart &>>/tmp/cart.log
echo $?

echo installing nodejs Dependencies
npm install &>>/tmp/cart.log
echo $?

 #update ips
echo configuring cart systemd services
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service &>>/tmp/cart.log
systemctl daemon-reload &>>/tmp/cart.log
echo $?

echo starting cart services
systemctl start cart &>>/tmp/cart.log
systemctl enable cart &>>/tmp/cart.log
echo $?