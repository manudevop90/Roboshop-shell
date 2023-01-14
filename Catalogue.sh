 set -e
 echo settings nodejs repo
 curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/catalogue.log
if [ $? -eq 0 ]; then
  echo -e "\e[32msuccess\e[0m"
else
  echo -e "\e[31mFail\e[0m"
  exit 1
fi   

echo installing nodejs repo
yum install nodejs -y &>>/tmp/catalogue.log
if [ $? -eq 0 ]; then
  echo -e "\e[32msuccess\e[0m"
  else
    echo -e "\e[31mFail\e[0m"
    exit 1
 fi

id roboshop &>>/tmp/catalogue.log
if [ $? -ne 0]; then
echo adding application user
 useradd roboshop &>>/tmp/catalogue.log
 if [ $? -eq 0]; then
   echo -e "\e[32msuccess\e[0m"
else
  echo -e "\e[31mFail\e[0m"
  exit 1
  fi

echo download content
 curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip" &>>/tmp/catalogue.log
 cd /home/roboshop &>>/tmp/catalogue.log
if [ $? -eq 0 ]; then
    echo -e "\e[32msuccuess\e[0m"
    else
    echo -e "\e[31Fail\e[0m"
    exit 1
fi
 echo cleaning old application content
 rm -rf catalogue &>>/tmp/catalogue.log
if [ $? -eq 0 ]; then
    echo -e "\e[32msuccuess\e[0m"
    else
    echo -e "\e[31Fail\e[0m"
    exit 1
fi
 echo extract application archive
 unzip -o /tmp/catalogue.zip &>>/tmp/catalogue.log
 mv catalogue-main catalogue &>>/tmp/catalogue.log
 cd /home/roboshop/catalogue &>>/tmp/catalogue.log
if [ $? -eq 0 ]; then
    echo -e "\e[32msuccuess\e[0m"
    else
    echo -e "\e[31Fail\e[0m"
    exit 1
fi
 echo installing nodejs dependencies
 npm install &>>/tmp/catalogue.log
if [ $? -eq 0 ]; then
    echo -e "\e[32msuccuess\e[0m"
    else
    echo -e "\e[31Fail\e[0m"
    exit 1
fi
echo configure catalogue systemd services
 mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service &>>/tmp/catalogue.log
 systemctl daemon-reload &>>/tmp/catalogue.log
if [ $? -eq 0 ]; then
    echo -e "\e[32msuccuess\e[0m"
    else
    echo -e "\e[31Fail\e[0m"
    exit 1
fi
 echo starting catalogue services
 systemctl start catalogue &>>/tmp/catalogue.log
 systemctl enable catalogue &>>/tmp/catalogue.log
if [ $? -eq 0 ]; then
    echo -e "\e[32msuccuess\e[0m"
    else
    echo -e "\e[31Fail\e[0m"
    exit 1
fi