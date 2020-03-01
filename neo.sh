#!/usr/bin/env bash
neoDir=/home/ashpex/.gem/ruby/2.7.0/bin/
blogDir=/home/ashpex/Downloads/codeberg/blog/
hugoDir=/home/ashpex/Downloads/codeberg/hugo/
echo "Building neocities..."
echo "=============================="
cd $hugoDir
hugo

echo "
==============================

  |\---/|
  | O_O |   Neocities 
   \_o_/
"
PS3='Please enter your choice: '
options=("Push" "Upload" "Delete" "List" "Info" "Logout" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Push")
            echo "===================================================="
			echo "Recursively upload a local directory to your site..."
            echo "===================================================="
            cd $neoDir
			./neocities push $blogDir
            ;;
        "Upload")
            echo "===================================================="
            echo "Upload individual files to your Neocities site..."
            echo "===================================================="
            ;;
        "Delete")
            echo "===================================================="
            echo "Delete files from your Neocities site..."
            echo "===================================================="
            ;;
        "List")
            echo "===================================================="
            echo "List files from your Neocities site"
            echo "===================================================="
            cd $neoDir
			./neocities list -a $blogDir
			;;
        "Info")
            echo "===================================================="
            echo "Information and stats for your site"
            echo "===================================================="
            cd $neoDir
			./neocities info ashpex
			;;
        "Logout")
            echo "===================================================="
            echo "Remove the site api key from the config"
            echo "===================================================="
            cd $neoDir
			./neocities logout
			;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

