#!/bin/bash

#Topic 1: Zubcov Roman

function menu {
  echo "1. Exit"
  echo "2. Display information about the operating system"
  echo "3. Display the first 3 installed shells on the system"
  echo "4. Display information about the network"
  echo "5. Create directory"
  echo "6. Copy file"
  echo "7. Delete directory"
  echo "8. Search command"
  echo "9. Display all log files"
}

function option {
  local options=("1" "2" "3" "4" "5" "6" "7" "8" "9")
  local opt=""
  while ! [[ " ${options[@]} " =~ " ${opt} " ]]; do
    read -p "Enter your choice: " opt
  done
  echo "$opt"
}

function show_info {
  echo "Server name: $HOSTNAME"
  echo "Operating system type: $OSTYPE"
  echo "Bash version: $BASH_VERSION"
  echo "Current path: $PWD"
}

function installed_shells {
  echo "First 3 shells installed on the system:"
  head -n 3 /etc/shells
}

function network_info {
  local ip_addr=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | head -n 1)
  local gateway=$(route -n | grep '^0.0.0.0' | awk '{print $2}')
  echo "IP address of the network interface: $ip_addr"
  echo "Gateway: $gateway"
}

function create_folder {
  read -p "Enter the directory name: " folder_name
  mkdir "$folder_name"
  echo "Directory $folder_name has been created."
}

function copy_file {
  read -p "Enter the file name: " file_name
  local folder_name=""
  while [ -z "$folder_name" ]; do
    read -p "Enter the name of the directory created in step 5: " folder_name
  done
  cp "$file_name" "$folder_name"
  echo "File $file_name has been copied to the directory $folder_name."
}

function delete_directory {
  read -p "Enter the name of the directory created in step 5: " folder_name
  rm -r "$folder_name"
  echo "Directory $folder_name and all files inside it have been deleted."
}

function search_command {
  read -p "Enter the keyword: " keyword
  history | grep "$keyword"
}

function display_all_logs {
  find /var/log -type f | while read file; do echo "$file"; done
}

function search_log_file {
  read -p "Enter the log file name: " log_file
  read -p "Enter the text to search: " search
}

while true
do
    echo "Menu:"
    echo "1. Exit"
    echo "2. Display information about the operating system"
    echo "3. Display the first 3 installed shells on the system"
    echo "4. Display information about the network"
    echo "5. Create directory"
    echo "6. Copy file"
    echo "7. Delete directory"
    echo "8. Search command"
    echo "9. Display all log files"

    read -p "Enter your choice: " option
    echo ""

    case $option in
        1)
            echo "You chose to exit the program."
            exit 0
            ;;
        2)
            echo "Server name: $(hostname)"
            echo "Operating system type: $(uname)"
            echo "Bash version: $BASH_VERSION"
            echo "Current path: $PWD"
            ;;
        3)
            echo "First 3 shells installed on the system:"
            head -n 3 /etc/shells
            ;;
        4)
            echo "Network information:"
            ip addr show | awk '/inet /{print "IP Address: "$2;exit}'
            echo "Gateway: $(ip route | awk '/default/ {print $3}')"
            ;;
        5)
            read -p "Enter the directory name: " folder_name
            mkdir $folder_name
            if [ $? -eq 0 ]; then
                echo "Directory $folder_name created successfully."
            else
                echo "Error creating directory $folder_name."
            fi
            ;;
        6)
            read -p "Enter the file name: " file_name
            if [ -f "$file_name" ]; then
                cp $file_name $folder_name
                echo "File $file_name copied successfully to the directory $folder_name."
            else
                echo "File $file_name does not exist."
            fi
            ;;
        7)
            read -p "Enter the directory name: " folder_name
            rm -rf $folder_name
            if [ $? -eq 0 ]; then
                echo "Directory $folder_name deleted successfully."
            else
                echo "Error deleting directory $folder_name."
            fi
            ;;
        8)
            read -p "Enter a keyword: " keyword
            history | grep $keyword
            ;;
        9)
            echo "All log files:"
            ls /var/log/*.log
            read -p "Enter the log file name: " log_file
            read -p "Enter the search text: " search_text
            if [[ $log_file == *".gz" ]]; then
                gunzip -c $log_file | grep $search_text
            else
                grep $search_text $log_file
            fi
            ;;
        *)
            echo "Invalid option."
            ;;
    esac

    echo ""
done
