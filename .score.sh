#!/bin/sh
SCORE=0

cd application

# Checking files
(sudo find /projects/challenge/application/index.jsp) > /dev/null 2>&1;
if [ $? -eq 0 ]; then
SCORE=$(( SCORE + 5 )) && echo "p1"
fi;

(sudo grep -i -e '<h2><i>A sample application has been deployed</i></h2>' /projects/challenge/application/index.jsp) > /dev/null 2>&1;
if [ $? -eq 0 ]; then
    SCORE=$(( SCORE + 5 )) && echo "p2"
fi;


(sudo find /projects/challenge/application/.git/hooks/post-commit) > /dev/null 2>&1;
if [ $? -eq 0 ]; then
SCORE=$(( SCORE + 7 )) && echo "p3"
fi;

(sudo find /projects/challenge/application/.git/hooks/commit-msg) > /dev/null 2>&1;
if [ $? -eq 0 ]; then
SCORE=$(( SCORE + 8 )) && echo "p4"
fi;

(sudo grep -i -e 'Your changes have been committed.' /projects/challenge/application/.git/hooks/post-commit) > /dev/null 2>&1;
if [ $? -eq 0 ]; then
    SCORE=$(( SCORE + 10 )) && echo "p5"
fi;

(sudo grep -i -e 'Dev:' -e 'Invalid commit message' /projects/challenge/application/.git/hooks/commit-msg) > /dev/null 2>&1;
if [ $? -eq 0 ]; then
    SCORE=$(( SCORE + 10 )) && echo "p6"
fi;

# Checking 'master' branch
git checkout master

if [ `eval git branch | grep -i -e 'feature/style1' -e 'feature/style2' | wc -l` -eq 2 ]
then
    SCORE=$(( SCORE + 10 )) && echo "p7"
fi;

if [ `eval git log --oneline | wc -l` -eq 3 ]
then
    SCORE=$(( SCORE + 10 )) && echo "p8"
fi;

if [ `eval git log --oneline | grep -io -e 'Added an italic tag' | wc -l` -eq 1 ]
then
    SCORE=$(( SCORE + 5 )) && echo "p9"
fi;


# Checking 'feature/style1' branch
git checkout feature/style1

if [ `eval git log --oneline | wc -l` -eq 5 ]
then
    SCORE=$(( SCORE + 10 )) && echo "p10"
fi;

if [ `eval git log --oneline | grep -i  -e 'Resolved the merge conflict' -e 'Added an italic tag' -e 'Added a bold tag'  | wc -l` -eq 3 ]
then
    SCORE=$(( SCORE + 5 )) && echo "p11"
fi;

# Checking 'feature/style2' branch
git checkout feature/style2

if [ `eval git log --oneline | wc -l` -eq 3 ]
then
    SCORE=$(( SCORE + 10 )) && echo "p12"
fi;

if [ `eval git log --oneline | grep -io 'Added an italic tag'  | wc -l` -eq 1 ]
then
    SCORE=$(( SCORE + 5 )) && echo "p13"
fi;

echo "FS_SCORE:$SCORE%"

