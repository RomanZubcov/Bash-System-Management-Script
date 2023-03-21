#!/bin/bash

#tema 1 Zubcov Roman 



function menu {
  echo "1. Ieșire"
  echo "2. Afișare informații despre sistemul de operare"
  echo "3. Afișarea primelor 3 shell-uri instalate în sistem"
  echo "4. Afișare informații despre rețea"
  echo "5. Creare director"
  echo "6. Copiere fișier"
  echo "7. Ștergere director"
  echo "8. Căutare comandă"
  echo "9. Afișează toate fișierele de log"
}

function option {
  local options=("1" "2" "3" "4" "5" "6" "7" "8" "9")
  local option=""
  while ! [[ " ${options[@]} " =~ " ${opt} " ]]; do
    read -p "Introduceți opțiunea: " opt
  done
  echo "$opt"
}

function show_info {
  echo "Numele serverului: $HOSTNAME"
  echo "Tipul sistemului de operare: $OSTYPE"
  echo "Versiunea bash-ului: $BASH_VERSION"
  echo "Calea curentă: $PWD"
}

function installed_shells {
  echo "Primele 3 shell-uri instalate în sistem:"
  head -n 3 /etc/shells
}

function network_info {
  local ip_addr=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | head -n 1)
  local gateway=$(route -n | grep '^0.0.0.0' | awk '{print $2}')
  echo "Adresa IP a interfeței de rețea: $ip_addr"
  echo "Gateway: $gateway"
}

function creare_folder {
  read -p "Introduceți numele directorului: " nume_folder
  mkdir "$nume_folder"
  echo "Directorul $nume_folder a fost creat."
}

function copiere_fisier {
  read -p "Introduceți numele fișierului: " nume_fisier
  local nume_folder=""
  while [ -z "$nume_folder" ]; do
    read -p "Introduceți numele directorului creat la punctul 5: " nume_folder
  done
  cp "$nume_fisier" "$nume_folder"
  echo "Fișierul $nume_fisier a fost copiat în directorul $nume_folder."
}

function delete_directory {
  read -p "Introduceți numele directorului creat la punctul 5: " nume_folder
  rm -r "$nume_folder"
  echo "Directorul $nume_folder și toate fișierele din interiorul lui au fost șterse."
}

function search_command {
  read -p "Introduceți cuvântul cheie: " keyword
  history | grep "$keyword"
}

function display_all_logs {
  find /var/log -type f | while read file; do echo "$file"; done
}

function search_log_file {
  read -p "Introduceți numele fișierului de log: " log_file
  read -p "Introduceți textul de căutat: " search
}
while true
do
    echo "Meniu:"
    echo "1. Iesire"
    echo "2. Afisare informatii despre sistemul de operare"
    echo "3. Afisare primele 3 shell-uri instalate in sistem"
    echo "4. Afisare informatii despre retea"
    echo "5. Creare director"
    echo "6. Copiere fisier"
    echo "7. Stergere director"
    echo "8. Cautare comanda"
    echo "9. Afisare toate fisierele de log"

    read -p "Introduceti o optiune: " option
    echo ""

    case $option in
        1)
            echo "Ati ales sa iesiti din program."
            exit 0
            ;;
        2)
            echo "Nume server: $(hostname)"
            echo "Tip sistem de operare: $(uname)"
            echo "Versiune bash: $BASH_VERSION"
            echo "Calea curenta: $PWD"
            ;;
        3)
            echo "Primele 3 shell-uri instalate in sistem:"
            head -n 3 /etc/shells
            ;;
        4)
            echo "Informatii despre retea:"
            ip addr show | awk '/inet /{print "Adresa IP: "$2;exit}'
            echo "Gateway: $(ip route | awk '/default/ {print $3}')"
            ;;
        5)
            read -p "Introduceti numele directorului: " nume_folder
            mkdir $nume_folder
            if [ $? -eq 0 ]; then
                echo "Directorul $nume_folder a fost creat cu succes."
            else
                echo "Eroare la crearea directorului $nume_folder."
            fi
            ;;
        6)
            read -p "Introduceti numele fisierului: " nume_fisier
            if [ -f "$nume_fisier" ]; then
                cp $nume_fisier $nume_folder
                echo "Fisierul $nume_fisier a fost copiat cu succes in directorul $nume_folder."
            else
                echo "Fisierul $nume_fisier nu exista."
            fi
            ;;
        7)
            read -p "Introduceti numele directorului: " nume_folder
            rm -rf $nume_folder
            if [ $? -eq 0 ]; then
                echo "Directorul $nume_folder a fost sters cu succes."
            else
                echo "Eroare la stergerea directorului $nume_folder."
            fi
            ;;
        8)
            read -p "Introduceti un cuvant cheie: " keyword
            history | grep $keyword
            ;;
        9)
            echo "Toate fisierele de log:"
            ls /var/log/*.log
            read -p "Introduceti numele fisierului de log: " log_file
            read -p "Introduceti textul de cautat: " search_text
            if [[ $log_file == *".gz" ]]; then
                gunzip -c $log_file | grep $search_text
            else
                grep $search_text $log_file
            fi
            ;;
        *)
            echo "Optiune invalida."
            ;;
    esac

    echo ""
done

