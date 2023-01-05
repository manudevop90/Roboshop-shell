echo hello
# somtimes we need to print multi line

echo -e "hello\nworld"

#syntax : -e is needed to print multi line/ infact to enable \n we need -e
# quotes are mandatory for using any \ esc seq , we used line sec seq
# \n to print a new line

# Tabbed line
echo -e "one\t\ttwo"

#color printing
echo -e "\e[31mhello\e[0m"
