 curl -sL https://rpm.nodesource.com/setup_lts.x | bash
 yum install nodejs -y
 useradd roboshop
 rm-rf cart
 curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip"
 cd /home/roboshop

 unzip -o /tmp/cart.zip
 mv cart-main cart
 cd cart
 npm install

 #update ips

 mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service
 systemctl daemon-reload
 systemctl start cart
 systemctl enable cart