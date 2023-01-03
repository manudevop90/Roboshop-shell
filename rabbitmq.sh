 curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash

 yum install rabbitmq-server -y

 systemctl enable rabbitmq-server
 systemctl start rabbitmq-server

 rabbitmqctl add_user roboshop roboshop123
 rabbitmqctl set_user_tags roboshop administrator
 rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"