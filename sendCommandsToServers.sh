#/bin/bash
# For this script to work you must setup your authorized ssh keys on all your remote servers.
# Simple instructions: You many have to generate your keys with a command like: ssh-keygen -t dsa
# If NO authorized_keys file exists in the account home dir/.ssh folder of your remote server:
# 	copy your public key to your remote servers with scp:
# 	scp ~/.ssh/id_dsa.pub your_admin_username@yourserver:.ssh/authorized_keys
# If an authorized keys file already exists on your remote server:
# 	you can copy your public key to the ~/.ssh folder as i.e. mykey.pub
#	scp ~/.ssh/id_dsa.pub your_admin_username@yourserver:.ssh/mykey.pub
#	append mykey.pub to authorized keys with: cat ~/.ssh/mykey.pub >> authorized_keys
# Be sure to change your_admin_username@yourserver to the your credentials and server name.
# You _may_ need to:
# 	Connect via ssh into your server and go to ~/.ssh
# 	Chown the authorized_keys file with your_admin_username: e.g. sudo chown admin authorized_keys
# 	Update the permission: sudo chmod 755 authorized_keys
#
# If you run this on a Macintosh you can hardwire the username and password, the rename the script with the file extension .command in order to make it double-clickable.

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
