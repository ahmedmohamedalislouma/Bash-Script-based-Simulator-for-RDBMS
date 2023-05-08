# Bash-Script-based-Simulator-for-RDBMS

This Bash project simulates a MySQL database and allows the user to perform basic database management tasks. The project is contained within a directory called MySQL, with a main script called `main.sh`.

## Usage

To use this project, simply run `main.sh`. This will clear the screen and prompt the user to select from the following options:

1. Create Database User
2. Delete Database User
3. Create New Database
4. Delete Existing Database
5. Create New Table inside Database
6. Insert New Row in Table
7. Select Data from Table
8. Delete Row from Table

## Functionality

### Create Database User

By default, there will be a system user called "oracle". To create a new admin user, the user running the script must be either "oracle" or an existing admin user. The script will ask for a new admin username, and if it already exists, a message will be displayed. Otherwise, the new user will be added to a file called `DB_admins.db`, which contains a list of admin users, including "oracle" and any others that have been created.

### Delete Database User

Only users listed in `DB_admins.db` can run this script. The script will show a list of all users in `DB_admins.db`, and allow the user to select one for deletion. The `sed` command is used to remove the selected user from the file.

### Create New Database

Only users listed in `DB_admins.db` can run this script. The script will prompt the user for a new database name, and create a directory with that name in `MySQL/DataBases`. A file called `owner.txt` will also be created in that directory, containing the username of the user that created the database.

### Delete Existing Database

Only users listed in `DB_admins.db` can run this script. The script will show a list of all databases that have been created, and allow the user to select one for deletion. If the user running the script is the owner of the database, the script will delete the directory and all its contents.

### Create New Table inside Database

Only users listed in `DB_admins.db` can run this script. The script will prompt the user to select a database from those that have been created, and then prompt for a table name and number of columns. If the table name does not already exist in the selected database, the user will be prompted to enter column names according to the number of columns specified. The final output of the script will create a file named with the entered table name within the selected database directory.

### Insert New Row in Table

Only users listed in `DB_admins.db` can run this script. The script will prompt the user to select a database from those that have been created, and then prompt for a table to insert a new row into. The script will read the table header and prompt the user to enter data for each column. The first column must be unique. Optionally, the script can read a CSV file and auto-insert data into the matching header of the table.

### Select Data from Table

The script will prompt the user to select a database from those that have been created, and then prompt for a table to display data from. The user will have the option to either show the entire table by using the `cat` command or to search for a specific string within the table.

### Delete Row from Table

The user will be prompted to select a database from those that have been created, and then select a table to delete a row from. The script will search for rows containing a specific string and delete those rows, then show the updated table.
