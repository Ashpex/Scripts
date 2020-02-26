#!/usr/bin/env bash
neoDir=/home/ashpex/.gem/ruby/2.7.0/bin/
blogDir=/home/ashpex/Downloads/codeberg/blog/
hugoDir=/home/ashpex/Downloads/codeberg/hugo/
echo "Building neocities..."
echo "=============================="
cd $hugoDir
hugo
PS3='Please enter your choice: '
options=("Push" "Upload" "Delete" "List" "Info" "Logout" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Push")
            echo "Recursively upload a local directory to your site..."
            cd $neoDir
			./neocities push $blogDir
            ;;
        "Upload")
            echo "Upload individual files to your Neocities site..."
            ;;
        "Delete")
            echo "Delete files from your Neocities site..."
            ;;
        "List")
            echo "List files from your Neocities site"
            cd $neoDir
			./neocities list -a $blogDir
			;;
        "Info")
            echo "Information and stats for your site"
            cd $neoDir
			./neocities info ashpex
			;;
        "Logout")
            echo "Remove the site api key from the config"
            cd $neoDir
			./neocities logout
			;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

