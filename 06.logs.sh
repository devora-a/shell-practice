#!bin/bash

USERID=$(id -u)
LOGS_DIR=var/log/shell-script
LOGS_FILE="$LOGS_DIR/$0.log" # /home/ec2-user/shell-logs/06.logs.sh.log

# check root access or not
if [ $USERID -ne 0 ]; then
    echo "please run this scrpit with root access"
    exit 1
fi

# first arg -> what are you trying to install
# second arg -> exit code
VALIDATE() {
    if [ $2 -ne 0 ]; then
        echo "Installing $1 is ...FAILED" 
        exit 1
    else
        echo "Installing $1 is ...success" 
    fi      
}

# echo "I am continuing..."
dnf list installed mysql &>> $LOGS_FILE

if [ $? -ne 0 ]; then
    echo "mysql already installed ... SKIPPING"
else
    echo "Installing MSQL"
    dnf install mysql -y &>> $LOGS_FILE
    VALIDATE "MYSQL" $?
fi