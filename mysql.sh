source common.sh

COMPONENT=mysql


echo setup yum repo
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo &>>{LOG}
statuscheck

echo module disable mysql
dnf module disable mysql &>>{LOG}
statuscheck

echo install mysql service
yum install mysql-community-server -y
echo $?


echo start mysql
systemctl enable mysqld &>>{LOG} && systemctl start mysqld &>>{LOG}
statuscheck

DEFUAILT_PASSWORD=$(grep 'A temporary password' /var/log/mysqld.log | awk '{print $NF}')

echo MYSQL PASSWORD = $MYSQL_PASSWORD
echo "alter user 'root'@'localhost' identified with mysql_native_password by '$MYSQL_PASSWORD';" | mysql --connect-expired-password -uroot -p${DEFUAILT_PASSWORD}

echo "uninstall plugin validate_password;" | mysql -uroot -p$MYSQL_PASSWORD

curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip"

cd /tmp &>>{LOG} && unzip -o mysql.zip &>>{LOG}
cd mysql-main
mysql -u root -pRoboShop@1 <shipping.sql