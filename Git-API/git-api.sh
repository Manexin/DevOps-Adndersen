#!/bin/bash

#FUNCTIONS
get_pull_request () {

            OPEN_PR=$(curl \
            -H "Accept: application/vnd.github.v3+json" \
            https://api.github.com/repos/$user/$repo/pulls?state=open)

}

# Entering user and repository name that are interested us.
echo -n "Enter the 'user' name of Git: "
read user
if [ -z $user ]
   then
#     echo -e "You do not entered user name!\n Look at repository sherlock by sherlock-project"
     user=sherlock-project
fi
echo "Enter 'repo' name of $user: "
read repo
if [ -z $repo ]
   then
#   echo "You do not entered repository name!"
   repo=sherlock
fi
if [ -z $user]&&[ -z $repo]
then
echo -e "You haven't entered anything!\nLook at repository sherlock by sherlock-project"
fi
get_pull_request
echo "$OPEN_PR" | jq '.[].user.login'
