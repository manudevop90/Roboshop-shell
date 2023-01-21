#!/usr/bin/env bash

source common.sh

COMPONENT=frontend



echo installing inginx
yum install nginx -y &>>{LOG}
statuscheck

DOWNLOAD

echo clean old content
cd /usr/share/nginx/html && rm -rf * &>>{LOG}
statuscheck

echo extract download content
unzip -o /tmp/frontend.zip &>>${LOG} && mv frontend-main/static/* . && mv frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf
statuscheck

echo start nginx sevice
systemctl restart nginx &>>{LOG} && systemctl enable nginx &>>{LOG}
statuscheck