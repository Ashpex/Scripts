#!/usr/bin/env bash
passDir=/home/ashpex/Downloads/pass/

PS3='Please enter your choice: '
options=("GitHub" "CodeBerg" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "GitHub")
			cd $passDir
            echo "GitHub token: "
            cat github.txt
            ;;
        "CodeBerg")
			cd $passDir
            echo "CodeBerg token: "
            cat codeberg.txt
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done