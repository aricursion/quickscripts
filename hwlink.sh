#!/bin/bash
HW_FOLDER="/home/zaxioms/CMU/current_assignments"

get_class_num () {
    out=$(awk -v RS='[^[:digit:]]+' 'length($0) >= max{
   max=length($0)
   num[max]=(num[max]?num[max] "," $0:$0)
}
END {
      printf "max length=%s, numbers: %s\n", max, num[max]
}' <<< "$1")
}

get_class_num $PWD
CLASS_NUM=$?


if [[ $1 == "link" ]]; then
    if [[ $PWD == $HW_FOLDER ]]; then
        echo "can you not";
        exit
    fi

    CLASS_NAME=$(dirname $PWD)
    ln -sf $PWD "$HW_FOLDER/${PWD##*/}-$CLASS_NUM"
    echo "sucesfully linked"
    exit;

elif [[ $1 == "unlink" ]]; then
    if [[ $PWD == $HW_FOLDER ]]; then
        rm $2
        exit

    else
        if [ -L "$HW_FOLDER/${PWD##*/}" ]; then
            rm $HW_FOLDER/${PWD##*/}
            echo "succesfully unlinked"
            exit
        else
            echo "current directory not in hw folder"
            exit
        fi
    fi
        
else
    echo "unknown command"
    exit
fi


