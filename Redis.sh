 dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
 dnf module enable redis:remi-6.2 -y
 yum install redis -y

update listed ip

 systemctl enable redis
 systemctl start redis