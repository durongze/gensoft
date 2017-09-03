#!/bin/bash

function GenWebSoftPacket()
{
    local TmpCimSoft=$1
    local TmpBimSoft=$2
    local TmpRfSoft=$3
    local TmpGenSoftPacket=$4
    
    if [[ -z $TmpGenSoftPacket ]];then
        echo $TmpGenSoftPacket
        return 1;
    fi

    TmpGenSoftDir=$(dirname $TmpGenSoftPacket)
    if [ ! -d $TmpGenSoftDir ];then
        mkdir $TmpGenSoftDir -p 
    fi

    tar czf $TmpGenSoftPacket ${TmpCimSoft%%.*}.tar.gz ${TmpBimSoft%%.*}.bin ${TmpRfSoft%%.*}.bin config.txt configa8.txt
}

function GenNetEcoPacket()
{
    TmpSoftPack=$1
    TmpGenSoftPacket=$2
    
    TmpGenSoftDir=$(dirname $TmpGenSoftPacket)
    if [ ! -d $TmpGenSoftDir ];then
        mkdir $TmpGenSoftDir -p 
    fi
    
    tar czf ${TmpGenSoftPacket%%.*}.tar.gz ${TmpSoftPack%%.*}.tar.gz config.txt config.xml
}
