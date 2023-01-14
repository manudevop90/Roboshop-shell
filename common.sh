statuscheck() {
if [ $? -eq 0 ]; then
  echo -e "\e[32msuccess\e[0m"
else
  echo -e "\e[31mFail\e[0m"
  exit 1
fi