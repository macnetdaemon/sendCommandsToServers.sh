#/bin/bash

username=''
password=''

#enter the commands you want to execute on your remote server(s) delimted by semicolons and ending with a semicolon on the last line.

commandlist="command1;command2;echo $password | sudo -S command3;exit;"

# CHECK TO SEE IF A VALUE WAS PASSED IN PARAMETER 1 AND, IF SO, ASSIGN TO "USERNAME"

if [ "$1" != "" ] && [ "$username" == "" ];then
    username=$1
fi

# CHECK TO SEE IF A VALUE WAS PASSED IN PARAMETER 2 AND, IF SO, ASSIGN TO "PASSWORD"
if [ "$2" != "" ] && [ "$password" == "" ];then
    password=$2
fi

# Assign the array of server names

names=(server1 server2 server3)

# For testing purposes we can specify only one server if we want
#names=(server1)

# create domain url variable to append to server name

domainURL="yourdomain.tld"

# Send remote commands to the servers

for((i=0; i<${#names[*]}; i++))
do
	echo "--------------------------"
	servername=${names[$i]}
	URL=$servername$domainURL
	printf "\nLogging into : "$URL"\n"
	ssh $username@$URL bash -c "'$commandlist'"
	printf "\nServer: "$servername" commands complete\n"
	printf "\nLogging out of "$URL"\n"

done

echo "--------------------------"
printf "\nAll commands sent to servers : COMPLETED...\n"

exit 0;
