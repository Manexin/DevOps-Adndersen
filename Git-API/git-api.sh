#!/bin/bash

#FUNCTIONS
get_pull_request () {

            OPEN_PR=$(curl -s\
            -H "Accept: application/vnd.github.v3+json" \
            https://api.github.com/repos/$user/$repo/pulls?state=open)

		}
#autorization_token (){
#		TOKEN=$(curl -v -H\
#		"Authorization: token TOKEN" https://api.github.com/repos/$user/$repo\
#		X-GitHub-SSO: required; url=https://github.com/orgs/octodocs-test/sso?authorization_request="$your_token)
#}
# Entering user and repository name that are interested us.
echo -n "Enter the 'user' name of Git: "
read user
if [ -z $user ]
   then
#     echo -e "You do not entered user name!\n Look at repository sherlock by sherlock-project"
     user=sherlock-project
fi
echo -n "Enter 'repo' name of $user: "
read repo
if [ -z $repo ]
   then
#   echo "You do not entered repository name!"
   repo=sherlock
fi
if [ -z $user ]&&[ -z $repo ]
then
echo -e "You haven't entered anything!\nLook at repository sherlock by sherlock-project"
fi
get_pull_request
active_user=$(echo "$OPEN_PR" | jq '.[].user.login' | sort | uniq -c | sort)
echo -e "------------------------------------------------\n"
echo -e "User list and count open PR\n\n$active_user\n"
title_PR=$(echo "$OPEN_PR" | jq '.[].title')
echo -e "------------------------------------------------\n"
echo -e "List title PR\n$title_PR\n"
