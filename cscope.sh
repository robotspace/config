#!/bin/sh
#$1 is source file directory.
if [ $# -eq 0 ]
then
    echo "We'll create TAGS from files in current directory."
else
    echo "cd $1"
    cd $1
fi

find . -regex ".*\.[cChH]\(pp\)?" -exec etags -a {} \;
find . -name "*.h" -o -name "*.c" -o -name "*.cc" -name "*.cpp" > cscope.files
cscope -bkq -i cscope.files
ctags -R
if [ $# -eq 0 ]
then
    echo "done."
else
    echo "done."
    cd -
fi
