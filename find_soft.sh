#!/bin/bash

function FindSoftFromSpecDir()
{
    SrcDir=$1
    WildCard=$2
    DstDir=$3
   
    if [ ! -d $DstDir ];then
        mkdir $DstDir -p
    fi

    if [ -z "$SrcDir" ] || [ -z "$WildCard" ] || [ -z "$DstDir" ]; then
        echo "[$FUNCNAME:$LINENO]"
        echo "    SrcDir:$SrcDir,WildCard:$WildCard,DstDir:$DstDir."
        return -1;
    fi
    
    SpecSoftName=`find "$SrcDir" -iname "$WildCard"  | awk -F'/' '{ print $NF }' | sort -rn | awk '{ print $NR }' `
    if [ 0 != $? ];then
        echo "[$FUNCNAME:$LINENO]"
        echo "    SrcDir:$SrcDir,WildCard:$WildCard,DstDir:$DstDir."
        return -1;
    fi

    SpecSrcFile=`find $SrcDir -iname $SpecSoftName `
    cp -a $SpecSrcFile $DstDir/
    
    if [ 0 != $? ] || [ -z $SpecSoftName ] || [ -z $SpecSrcFile ]; then
        echo "[$FUNCNAME:$LINENO]" 
        echo "    SpecSoftName:$SpecSoftName,SpecSrcFile:$SpecSrcFile,DstDir:$DstDir."
        return -1;
    fi

    return 0;
}


