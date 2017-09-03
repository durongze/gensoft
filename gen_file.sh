#!/bin/bash
Number=1
pushd SoftDir >>/dev/null
    Files=`ls`
    for file in $Files
    do
        echo "$file" > $file
        echo "$Number" >> $file
        Number=`expr $Number + 1` 
        echo `md5sum $file` >>$file
    done
popd >>/dev/null
