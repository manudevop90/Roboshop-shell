source common.sh

COMPONENT=cart

echo setup yum repo
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>${LOG}
dnf module enable redis:remi-6.2 -y &>>${LOG}
statuscheck

echo install redis
yum install redis -y &>>${LOG}
statuscheck


#update listed ip
echo start redis service
systemctl enable redis &>>{LOG} && systemctl start redis &>>{LOG}
statuscheck
