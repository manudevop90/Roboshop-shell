source common.sh

COMPONENT=mysql

#if [ -z "$MYSQL_PASSWORD" ]; then
 #echo -e "\e[33m env variable MYSQL_PASSWORD is missing \e[0m"
  #exit 1
#fi

echo setup yum repo
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo &>>{LOG}
statuscheck

echo module disable mysql
dnf module disable mysql &>>{LOG}
echo $?

echo install mysql service
yum install mysql-community-server -y &>>{LOG}
statuscheck

echo systemctl enable mysqld && echo systemctl start mysqld
statuscheck

DEFUAILT_PASSWORD=$(grep 'A temporary password' /var/log/mysqld.log | awk '{print $NF}')

echo "alter user 'root'@'localhost' identified with mysql_native_password by '$MYSQL_PASSWORD';" | mysql --connect-expired-password -uroot -p${DEFUAILT_PASSWORD}

exit
echo "uninstall plugin validate_password;" | mysql -uroot -p$MYSQL_PASSWORD

#echo "show databases;" | mysql -uroot -p$MYSQL_PASSWORD &>>${log}

curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip"

cd /tmp &>>{LOG} && unzip -o mysql.zip &>>{LOG}
cd mysql-main
mysql -uroot -pRoboShop@1 <shipping.sql