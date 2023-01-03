 yum install maven -y

 useradd roboshop


 curl -s -L -o /tmp/shipping.zip "https://github.com/roboshop-devops-project/shipping/archive/main.zip"
 cd /home/roboshop
  rm-rf shipping
 unzip -o /tmp/shipping.zip
 mv shipping-main shipping
 cd shipping
 mvn clean package
 mv target/shipping-1.0.jar shipping.jar

 mv /home/roboshop/shipping/systemd.service /etc/systemd/system/shipping.service
 systemctl daemon-reload
 systemctl start shipping 
 systemctl enable shipping