source common.sh

COMPONENT=mysql

if [ -z "$MYSQL_PASSWORD" ]; then
 echo -e "\e[33m env variable MYSQL_PASSWORD is missing \e[0m"
 exit 1
fi

echo setup yum repo
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo &>>{LOG}
statuscheck

echo module disable mysql
dnf module disable mysql -y &>>{LOG}
statuscheck

echo install mysql service
yum install mysql-community-server -y &>>{LOG}
statuscheck

echo start mysqld
echo systemctl enable mysqld &>>{LOG} && echo systemctl start mysqld &>>{LOG}
statuscheck

echo "show databases;" | mysql -uroot -p$MYSQL_PASSWORD &>>{log}
if [ $? -ne 0 ]; then
  echo changing the default password
    DEFUAILT_PASSWORD=$(grep 'A temporary password' /var/log/mysqld.log | awk '{print $NF}')
    echo "alter user 'root'@'localhost' identified with mysql_native_password by '$MYSQL_PASSWORD';" | mysql --connect-expired-password -uroot
    -p${DEFUAILT_PASSWORD}
    statuscheck
fi

echo show plugins | mysql -uroot -pRoboShop@1 2>&1 | grep validate_password
if [ $? -eq 0 ]; then
  echo remove password validate plugin
  echo "uninstall plugin validate_password;" | mysql -uroot -p$MYSQL_PASSWORD &>>{log}
  statuscheck
fi
DOWNLOAD

echo "extract & load schema"
cd /tmp &>>{LOG} && unzip -o mysql.zip &>>{LOG} && cd mysql-main &>>{log} && mysql -uroot -pRoboShop@1 <shipping.sql &>>{log}
statuscheck