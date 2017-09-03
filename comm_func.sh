#!/bin/bash

function CheckStrIsNull()
{
    if [ -z "$1" ]; then 
        return 1;
    else
        return 0;
    fi
}

function CheckFileIsExist()
{
    local TmpWorkDir=$2
    local TmpFile=$1*
    pushd $TmpWorkDir >>/dev/null
    if [ -e $TmpFile ]; then
        popd >>/dev/null
        return 1;
    else
        ls 
        echo "$TmpFile is not exist !"
        popd >>/dev/null
        return 0;
    fi
}

function CheckDirIsEmpty()
{
    pushd $2 >>/dev/null
    if [ -s $1 ]; then
        popd >>/dev/null
        return 1;
    else
        echo "$1 is not empty !"
        popd >>/dev/null
        return 0;
    fi
}

function CalcSubCount()
{
    export SoftSubCount=0

    if [[ -f ${WEB_SOFT_PACKET_NAME}.tar.gz ]];then
        SoftSubCount=$(expr $SoftSubCount + 1) 
        WebSoftPackNo=$SoftSubCount
    fi

    if [[ -f ${CIM_SOFT_PACKET_NAME}.tar.gz ]];then
        SoftSubCount=$(expr $SoftSubCount + 1) 
        CimSoftPackNo=$SoftSubCount
    fi

    if [[ -f ${RF_SOFT_PACKET_NAME}.bin ]];then
        SoftSubCount=$(expr $SoftSubCount + 1) 
        RfSoftPackNo=$SoftSubCount
    fi

    if [[ -f ${BIM_SOFT_PACKET_NAME}.bin ]];then
        SoftSubCount=$(expr $SoftSubCount + 1) 
        BimSoftPackNo=$SoftSubCount
    fi

    if [ 1 -gt $SoftSubCount ] || [ 3 -lt $SoftSubCount ];then
        return -1;
    else
        return 0;
    fi
}

function GetCurSoftSubPacket()
{
    local TmpCurSoft=$1
   
    CalcSubCount $TmpCurSoft 

    case $TmpCurSoft in
        ${CIM_SOFT_PACKET_NAME}*)
            CurSoftSubPacket=$CimSoftPackNo
            ;;
        ${RF_SOFT_PACKET_NAME}*)
            CurSoftSubPacket=$RfSoftPackNo
            ;;
        ${BIM_SOFT_PACKET_NAME}*)
            CurSoftSubPacket=$BimSoftPackNo
            ;;
        ${WEB_SOFT_PACKET_NAME}*)
            CurSoftSubPacket=$WebSoftPackNo
            ;;
        *)
            CurSoftSubPacket=
            ;;
    esac

    return 0;
}

function GetCurSoftEquipTypeID()
{
    local TmpCurSoft=$1 
    case $TmpCurSoft in
        ${CIM_SOFT_PACKET_NAME}*)
            CurSoftEquipTypeID=32769
            ;;
        ${RF_SOFT_PACKET_NAME}*)
            CurSoftEquipTypeID=32769
            ;;
        ${BIM_SOFT_PACKET_NAME}*)
            CurSoftEquipTypeID=32769
            ;;
        ${WEB_SOFT_PACKET_NAME}*)
            CurSoftEquipTypeID=40979
            ;;
        *)
            CurSoftEquipTypeID=
            return -1
            ;;
    esac
    return 0
}

function GetCurSoftFeatureCode()
{
    local TmpCurSoft=$1 
    case $TmpCurSoft in
        ${CIM_SOFT_PACKET_NAME}*)
            CurSoftFeatureCode=4294967295
            ;;
        ${RF_SOFT_PACKET_NAME}*)
            CurSoftFeatureCode=4294967295
            ;;
        ${BIM_SOFT_PACKET_NAME}*)
            if [ "12V" == $BIM_VOLT ];then
                CurSoftFeatureCode=12
            elif [ "2V" == $BIM_VOLT ];then
                CurSoftFeatureCode=2
            else
                CurSoftFeatureCode=
            fi
            ;;
        ${WEB_SOFT_PACKET_NAME}*)
            CurSoftFeatureCode=4294967295
            ;;
        *)
            CurSoftFeatureCode=
            return -1
            ;;
    esac
    return 0
}

function GetCurSoftFileType()
{
    local TmpCurSoft=$1 
    case $TmpCurSoft in
        ${CIM_SOFT_PACKET_NAME}*)
            CurSoftFileType=180
            ;;
        ${RF_SOFT_PACKET_NAME}*)
            CurSoftFileType=81
            ;;
        ${BIM_SOFT_PACKET_NAME}*)
            CurSoftFileType=82
            ;;
        ${WEB_SOFT_PACKET_NAME}*)
            CurSoftFileType=181
            ;;
        *)
            CurSoftFileType=
            return -1
            ;;
    esac
    return 0
}

function GetCurSoftSubVersion()
{
    local TmpCurSoft=$1 
    case $TmpCurSoft in
        ${CIM_SOFT_PACKET_NAME}*)
            CurSoftSubVersion=$CIM_SOFT_BATE_VER
            ;;
        ${RF_SOFT_PACKET_NAME}*)
            CurSoftSubVersion=$RF_SOFT_VER
            ;;
        ${BIM_SOFT_PACKET_NAME}*)
            CurSoftSubVersion=$BIM_SOFT_VER
            ;;
        ${WEB_SOFT_PACKET_NAME}*)
            CurSoftSubVersion=$CIM_SOFT_BATE_VER
            ;;
        *)
            CurSoftSubVersion=
            return -1
            ;;
    esac
    return 0
}

function GenFileCfgInfo()
{
    local TmpFileFilter=$1
    local TmpFile=$(ls ${TmpFileFilter%%.*}.*)
    local TmpFileCfg=$SoftCfg/${TmpFile%%.*}.cfg
    
    if [[ ! -d $SoftCfg ]];then
        mkdir $SoftCfg -p
    fi

    ###################################
    echo "" >$TmpFileCfg 
    GetCurSoftSubPacket $TmpFile
    echo "SubPacket=$CurSoftSubPacket" >>$TmpFileCfg
    GetCurSoftEquipTypeID $TmpFile
    echo "EquipTypeID=$CurSoftEquipTypeID" >>$TmpFileCfg
    GetCurSoftFeatureCode $TmpFile
    echo "FeatureCode=$CurSoftFeatureCode" >>$TmpFileCfg
    GetCurSoftFileType $TmpFile
    echo "FileType=$CurSoftFileType" >>$TmpFileCfg
    echo "FileName=$TmpFile" >>$TmpFileCfg
    echo "FileLen=$(ls -l $TmpFile | awk -F' ' '{ print $5 }')" >> $TmpFileCfg
    echo "FileCrc=$($CRC $TmpFile | awk -F' ' '{ print $1 }')" >>$TmpFileCfg
    GetCurSoftSubVersion $TmpFile
    echo "SubVersion=$CurSoftSubVersion" >>$TmpFileCfg
    ###################################
    return 0;
}
