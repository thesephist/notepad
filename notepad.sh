#!/bin/bash
# NOTEPAD - universal local notepad script

NOTEPADHELP="BASIC USAGE: 
notepad
notepad write

=> both opens a $EDITOR instance to edit the global notepad

OPTIONS:
notepad [recover|date|help|echo|wipe|config|version]

recover   recover the last version of the notepad
date      open notepad with current date and time appended
help      show this help message
echo      show current contents of the notepad; do not open file for write
wipe      wipe the slate clean; overwrite current notepad with blank file
config    setup the application on first run
version   output the version number and exit

=> these options may only be called one at a time
"

if [[ $BASH_ARGV = 'help' ]]
then 
    printf "$NOTEPADHELP"

elif [[ $BASH_ARGV = 'config' ]]
then 
    mkdir ~/.notepad/
    touch ~/.notepad/notepad.md ~/.notepad/notepad.backup ~/.notepad/help.md
    printf "$NOTEPADHELP" > ~/.notepad/help.md

elif [[ ! -d ~/.notepad/ ]]
then 
    echo 'Please use with the .notepad directory configured correctly'
    echo 'If you would like to set up notepad, run "notepad config"'

elif [[ $BASH_ARGV = 'recover' ]]
then 
    cat ~/.notepad/notepad.backup > ~/.notepad/notepad.md
    echo "Last note recovered"

elif [[ $BASH_ARGV = 'date' ]]
then cp -u ~/.notepad/notepad.md ~/.notepad/notepad.backup
    echo "#  $(date -Iseconds)  #" >> ~/.notepad/notepad.md
    echo "## $(date -R) ##" >> ~/.notepad/notepad.md
    echo "" >> ~/.notepad/notepad.md
    $EDITOR ~/.notepad/notepad.md

elif [[ $BASH_ARGV = 'echo' ]]
then 
    cat ~/.notepad/notepad.md

elif [[ $BASH_ARGV = 'wipe' ]]
then 
    cp -u ~/.notepad/notepad.md ~/.notepad/notepad.backup
    echo "" > ~/.notepad/notepad.md

elif [[ ( $BASH_ARGV = "" ) || ($BASH_ARGV = 'write' ) ]]
then 
    cp -u ~/.notepad/notepad.md ~/.notepad/notepad.backup
    $EDITOR ~/.notepad/notepad.md

elif [[ $BASH_ARGV = 'version' ]]
then 
    echo Notepad Version 1.0

else
    echo "Invalid Options!"

fi

