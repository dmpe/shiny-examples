#!/bin/bash

OLD="library(shinyV4)"
NEW="library(shinyV4)"
DPATH="//home/jm/Documents/shiny-examples/"
BPATH="//home/jm/Documents/shiny-examples/backup/"
TFILE="/tmp/out.tmp.$$"
[ ! -d $BPATH ] && mkdir -p $BPATH || :
for f in $DPATH
do
  if [ -f $f -a -r $f ]; then
    /bin/cp -f $f $BPATH
   sed "s/$OLD/$NEW/g" "$f" > $TFILE && mv $TFILE "$f"
  else
   echo "Error: Cannot read $f"
  fi
done
/bin/rm $TFILE

# https://unix.stackexchange.com/questions/112023/how-can-i-replace-a-string-in-a-files
sudo find . -type f -exec sed -i 's/library(shiny)/library(shinyV4)/g' {} +
