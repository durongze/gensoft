#!/bin/bash

function GenCimCfgInfo()
{
    GenFileCfgInfo $1
    return $?;
}

function GenBimCfgInfo()
{
    GenFileCfgInfo $1
    return $?;
}

function GenRfCfgInfo()
{
    GenFileCfgInfo $1
    return $?;
}

function GenWebSoftCfgInfo()
{
    GenFileCfgInfo $WEB_SOFT_PACKET_NAME
    return $?
}

function GenWebSoftCfgFile()
{
    TmpCfgFile=$4
    GenCimCfgInfo $1 
    GenBimCfgInfo $3
    GenRfCfgInfo $2
    echo "BEGIN" >$TmpCfgFile
    echo "<BigPacket>" >>$TmpCfgFile
    echo "Type=224" >>$TmpCfgFile
    echo "BigName=${WEB_SOFT_PACKET_NAME}.tar.gz" >>$TmpCfgFile
    echo "BigVersion=V100R001C00SP33" >>$TmpCfgFile
    echo "Patch=" >>$TmpCfgFile
    GetCurSoftSubPacket $1
    echo "SubCount=$SoftSubCount" >>$TmpCfgFile
    cat $SoftCfg/${1}.cfg >>$TmpCfgFile
    cat $SoftCfg/${2}.cfg >>$TmpCfgFile
    cat $SoftCfg/${3}.cfg >>$TmpCfgFile
    echo "" >>$TmpCfgFile
    echo "END" >>$TmpCfgFile
}

function GenWebSoftA8CfgFile()
{
    TmpCfgFile=$2
    GenCimCfgInfo $1 
    echo "BEGIN" >$TmpCfgFile
    echo "<BigPacket>" >>$TmpCfgFile
    echo "Type=224" >>$TmpCfgFile
    echo "BigName=cimpackage.tar.gz" >>$TmpCfgFile
    echo "BigVersion=V100R001C00SP33" >>$TmpCfgFile
    echo "Patch=" >>$TmpCfgFile
    GetCurSoftSubPacket $1 
    echo "SubCount=$CurSoftSubPacket" >>$TmpCfgFile
    cat $SoftCfg/${1}.cfg >>$TmpCfgFile
    echo "" >>$TmpCfgFile
    echo "END" >>$TmpCfgFile
}

function GenNetEcoSoftCfgFile()
{
    local TmpSoftName=$1
    local TmpCfgFile=$2

    GenWebSoftCfgInfo $TmpSoftName
    echo "BEGIN" >$TmpCfgFile
    echo "<BigPacket>" >>$TmpCfgFile
    echo "Type=224" >>$TmpCfgFile
    echo "BigName=${NETECO_SOFT_PACKET_NAME}.tar.gz" >>$TmpCfgFile
    echo "BigVersion=V100R001C00SP33" >>$TmpCfgFile
    echo "Patch=" >>$TmpCfgFile
    GetCurSoftSubPacket $WEB_SOFT_PACKET_NAME 
    echo "SubCount=$SoftSubCount" >>$TmpCfgFile
    cat $SoftCfg/${WEB_SOFT_PACKET_NAME}.cfg >>$TmpCfgFile
    echo "" >>$TmpCfgFile
    echo "END" >>$TmpCfgFile
}

function GenNetEcoSoftXmlFile()
{
    local TmpSoftName=$1
    local TmpCfgFile=$2
    GenWebSoftCfgInfo $TmpSoftName
    . $SoftCfg/${WEB_SOFT_PACKET_NAME}.cfg 
    echo "<?xml version="1.0" encoding="iso-8859-1"?>" >$TmpCfgFile
}
