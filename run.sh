#!/bin/sh
 
git filter-branch --env-filter '
 
an="Tingliang"
am="tingliangguo@tingliang.local"
cn="Tingliang"
cm="tingliangguo@tingliang.local"
 
if [ "tingliangguo@tingliang.local" = "your@email.to.match" ]
then
    cn="Tingliang"
    cm="tingliang.guo@gmail.com"
fi
if [ "tingliangguo@tingliang.local" = "your@email.to.match" ]
then
    an="Tingliang"
    am="tingliang.guo@gmail.com"
fi
                 
export GIT_AUTHOR_NAME="$an"
export GIT_AUTHOR_EMAIL="$am"
export GIT_COMMITTER_NAME="$cn"
export GIT_COMMITTER_EMAIL="$cm"
'
