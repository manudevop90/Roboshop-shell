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
echo -e "\e[32mhello\e[0m"
echo -e "\e[33mhello\e[0m"
echo -e "\e[34mhello\e[0m"
echo -e "\e[35mhello\e[0m"
echo -e "\e[36mhello\e[0m"

#syntax:  -e to enable \e
#         \e[31m, 31 is the color code
#         \e[0m, 0 is to reset the color
## note: in shell when we enable any color andd it is our responsibility to disable it.

## colors    #code
# RED         31
# GREEN       32
# YELLOW      33
# BLUE        34
# MAGENTA     35
# CYAN        36


# WE PREFER ALWAYS TO GO WITH DOUBLE QUOTES

#VARIABLES
