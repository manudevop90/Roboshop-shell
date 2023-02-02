source common.sh
COMPONENT=rabbitmq

if [ -z "APP_RABBITMQ_PASSWORD" ]; then
  echo -e "\e[33m env variable APP_RABBITMQ is needed\e[0m"
 exit 1
fi

echo install erlang
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash &>>${LOG}
yum install erlang -y &>>${LOG}
statuscheck

echo yum repos
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>${LOG}
statuscheck

echo install rabbitmq
yum install rabbitmq-server -y &>>${LOG}
statuscheck

echo start rabbitmq
 systemctl enable rabbitmq-server && systemctl start rabbitmq-server &>>${LOG}
statuscheck

echo add app user in rabbitmq
rabbitmqctl add_user roboshop ${APP_RABBITMQ_PASSWORD} && rabbitmqctl set_user_tags roboshop administrator && rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>${LOG}
statuscheck