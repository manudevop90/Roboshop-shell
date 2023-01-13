
echo setting nodejs repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/cart.log
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mfaile\e[0m"
  exit 1
fi
echo installing nodejs
sudo yum rm nodejs
yum install nodejs -y &>>/tmp/cart.log
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mfaile\e[0m"
  exit 1
fi

id roboshop &>>/tmp/cart.log
if [ $? -ne 0]; then
   echo adding application user
   useradd roboshop  &>>/tmp/cart.log
   if [ $? -eq 0 ]; then
      echo -e "\e[32mSUCCESS\e[0m"
   else
      echo -e "\e[31mfaile\e[0m"
  exit 1
  fi
fi

echo dowloading content
curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip"  &>>/tmp/cart.log
cd /home/roboshop  &>>/tmp/cart.log
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mfaile\e[0m"
  exit 1
fi

echo cleaning old application content
rm -rf cart &>>/tmp/cart.log
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mfaile\e[0m"
  exit 1
fi

echo extract application archive
unzip -o /tmp/cart.zip  &>>/tmp/cart.log
mv cart-main cart &>>/tmp/cart.log
cd cart &>>/tmp/cart.log
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mfaile\e[0m"
  exit 1
fi

echo installing nodejs Dependencies
npm install &>>/tmp/cart.log
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mfaile\e[0m"
  exit 1
fi

 #update ips
echo configuring cart systemd services
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service &>>/tmp/cart.log
systemctl daemon-reload &>>/tmp/cart.log
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mfaile\e[0m"
  exit 1
fi

echo starting cart services
systemctl start cart &>>/tmp/cart.log
systemctl enable cart &>>/tmp/cart.log
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mfaile\e[0m"
  exit 1
fi