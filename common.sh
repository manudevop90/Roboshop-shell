# this script is only for dry
statuscheck() {
if [ $? -eq 0 ]; then
  echo -e "\e[32msuccess\e[0m"
else
  echo -e "\e[31mFail\e[0m"
  exit 1
fi
}

NODEJS()
{
echo setting nodejs repos
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>/tmp/cart.log
statuscheck

echo installing nodejs
yum install nodejs -y  &>>/tmp/cart.log
statuscheck

id roboshop &>>/tmp/cart.log
 if [ $? -ne 0 ]; then
   echo adding application user
   useradd roboshop  &>>/tmp/cart.log
statuscheck
fi
}