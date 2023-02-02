source comoon.sh
COMPONENT=rabbitmq

echo install erlang
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash &>>${LOG}
yum install erlang -y
statuschek

echo yum repos
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>${LOG}
statuschek

echo install rabbitmq
yum install rabbitmq-server -y &>>${LOG}
statuschek

echo start rabbitmq
 systemctl enable rabbitmq-server && systemctl start rabbitmq-server &>>${LOG}
statuschek

echo add app user in rabbitmq
 rabbitmqctl add_user roboshop roboshop123 && rabbitmqctl set_user_tags roboshop administrator && rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>${LOG}
statuschek