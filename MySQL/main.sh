PS3="please select your option :  "
select x in " Create Database user. " " Delete Database User. " " Create new Database. " " Delete an existing Database." " Create A new Table inside Database. " " Insert A New Row in a Table. " " Select Data from Table. " " Delete Data from Table. "
do
if [[ $x == " Create Database user. " ]]
then

	if grep -q $(whoami) /home/MySQL/DB_admins.db
	then 
	echo hello $(whoami)
	echo enter a new admin user ?
		
	read user_name

		if grep -q $user_name /home/MySQL/DB_admins.db 
		
		then 

		echo the user already exist
		break
		else
		echo $user_name >> /home/MySQL/DB_admins.db
		echo the user is created successfully
		break
        fi
	else
	echo you are not allowed to add users
		
	break	
	
	fi
	fi
	
	
if [[ $x == " Delete Database User. " ]]
then
	if grep -q $(whoami) /home/MySQL/DB_admins.db
	then 
	echo hello $(whoami)
	echo choose the user you want to be deleted
	select name in `cat /home/MySQL/DB_admins.db `
	do
	if [[ $name == "oracle" ]]
	then
	echo username oracle can not be deleted
	break
	else
	sed -i "/$name/d" /home/MySQL/DB_admins.db 
	echo username has been deleted
	break
	fi
	done
	break
	else
	echo you are not allowed to delete users
		
	break	
	fi
	fi
	
if [[ $x == " Create new Database. " ]]
then
if grep -q $(whoami) /home/MySQL/DB_admins.db
	then 
	echo hello $(whoami)
	echo enter a database name !
	read db_name
	mkdir -p /home/MySQL/DataBases/$db_name"DB"
	touch /home/MySQL/DataBases/$db_name"DB"/owner.txt
	echo $(whoami) > /home/MySQL/DataBases/$db_name"DB"/owner.txt
	echo database created successfully 
	else
	echo you are not allowed to create database
		
	break	
fi	
break	
fi	

if [[ $x == " Delete an existing Database." ]]
then
if grep -q $(whoami) /home/MySQL/DB_admins.db
	then 
	echo hello $(whoami)
	echo choose the database you want to be deleted
	select db in `ls  /home/MySQL/DataBases`
	do

	if [[ $(whoami) == $(cat /home/MySQL/DataBases/$db/owner.txt) ]]
	then 
	rm -rf /home/MySQL/DataBases/$db
	break
	fi
	done
	
else
	echo you are not allowed to delete database
		
	break		
	
	
fi	
break
fi
	
if [[ $x == " Create A new Table inside Database. " ]]
then	
if grep -q $(whoami) /home/MySQL/DB_admins.db
	then 
	echo hello $(whoami)
	echo choose the database where you want to create table in !

	select db in `ls  /home/MySQL/DataBases`
	do

	if [[ $(whoami) == $(cat /home/MySQL/DataBases/$db/owner.txt) ]]
	then
	echo enter a table name !
	read table_name
	if  ls  /home/MySQL/DataBases/$db | grep -q $table_name
	then
	echo table is already exist
	break
	else 
	echo enter a number of columns !
	read columns_count
	echo enter the $columns_count columns names separated by commas
	read columns_names
	if [[ $(echo $columns_names| tr ',' ' ' | wc -w) -ne $columns_count ]]
	then 
	echo the number of columns you entered are not correct
	echo choose the same option and try agian
	else
	touch /home/MySQL/DataBases/$db/$table_name".table"
	echo $columns_names > /home/MySQL/DataBases/$db/$table_name".table"
	echo the table is successfully created
	break
	fi
	
	fi
	

	
	
	fi
	
	done

else
	echo you are not allowed to create new table inside a database
		
	break		
fi
break
fi	

if [[ $x == " Insert A New Row in a Table. " ]]
then	
if grep -q $(whoami) /home/MySQL/DB_admins.db
	then 
	echo hello $(whoami)
	echo choose the database where you want to make an action !

	select db in `ls  /home/MySQL/DataBases`
	do

	if [[ $(whoami) == $(cat /home/MySQL/DataBases/$db/owner.txt) ]]
	then
	echo choose the table where you want to insert a row in !
	select table in `ls  /home/MySQL/DataBases/$db`
	do
	head -1 /home/MySQL/DataBases/$db/$table
	echo these are the coulmn names of this table
	echo please enter the data you want to insert separated by commas
	read data
	if  cat /home/MySQL/DataBases/$db/$table | awk -F, '{print $1}' | grep -qx $(echo $data | awk -F, '{print $1}')
	then
	echo the first column must be unique
	echo choose the same option and try to insert your data again
	else
	echo $data >> /home/MySQL/DataBases/$db/$table
	echo the row has been inserted
	echo here are your inserted data
	tail /home/MySQL/DataBases/$db/$table
	break
	fi
	done
	break
	fi
	done

else
	echo you are not allowed to create insert new row inside this table
		
	break		
fi
break
fi

if [[ $x == " Select Data from Table. " ]]
then
	echo hello $(whoami)
	echo choose the database you want to select from!
	select db in `ls  /home/MySQL/DataBases`
	do
	echo choose the table where you want to select rows from !
	select table in `ls  /home/MySQL/DataBases/$db`
	do
	echo choose one of these options !
	select option in " show the table content " " search for row containing specific word "
	do
	
	if [[ $option == " show the table content " ]]			
	then
	cat /home/MySQL/DataBases/$db/$table
	break
	fi
	break
	if [[ $option == " search for row containing specific word " ]]
	then
	echo enter the word
	read word
	echo here are the expected rows
	cat DataBases/employeeDB/employee.txt | grep -w $word
	break
	fi
	done
	break
	done
	break
	done	
	break
fi


 if [[ $x == " Delete Data from Table. " ]]
 then
 echo hello $(whoami)
	echo choose the database you want to delete from!
	select db in `ls  /home/MySQL/DataBases`
	do
	echo choose the table where you want to delete rows from !
	select table in `ls  /home/MySQL/DataBases/$db`
	do
	echo enter the specific word to delete the row containing this word
	read word
	sed -i "/$word/d" /home/MySQL/DataBases/$db/$table
	cat /home/MySQL/DataBases/$db/$table
	break
done
break
done
break
fi
done
