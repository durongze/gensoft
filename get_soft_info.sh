#!/bin/bash 
. comm_env.sh

function GetCurSoftHardVer()
{
    local TmpSoftName=$1
    case $TmpSoftName in
        *[Cc][Ii][Mm]*[Vv][1]*)
            CIM_HARD_VER=10
            ;;
        *[Bb][Ii][Mm]*[Vv][1]*)
            BIM_HARD_VER=10
            ;;
        *[CC][Ii][Mm]*[Vv][2-4]*)
            CIM_HARD_VER=20
            ;;
        *[Bb][Ii][Mm]*[Vv][2-4]*)
            BIM_HARD_VER=20
            ;;
        *[Cc][Ii][Mm]*[Vv][5-8]*)
            CIM_HARD_VER=21
            ;;
        *[Bb][Ii][Mm]*[Vv][5-8]*)
            BIM_HARD_VER=21
            ;;
        *[CC][CC]*)
            RF_HARD_VER=
            ;;
        *)
            #echo -e "[\033[33mINFO\033[0m] $FUNCNAME:$LINENO"
            #echo "     Soft Ver :$TmpSoftName, Cur Hard Version is default value !"
            CIM_HARD_VER=77
            BIM_HARD_VER=77
            ;;
    esac
    
    return 0;
}

function GetCimInfo()
{
    CIM_SOFT_PACKET_NAME=$1

    if [[ -z $CIM_SOFT_PACKET_NAME ]];then
        return 1;
    fi

    CIM_SOFT_PACKET_NAME=${CIM_SOFT_PACKET_NAME%%.*}
    GetCurSoftHardVer $CIM_SOFT_PACKET_NAME
    CIM_NAME=${CIM_SOFT_PACKET_NAME%%_*}
    CIM_SOFT_BATE_VER=${CIM_SOFT_PACKET_NAME##*_}
    CIM_BATE_VER=${CIM_SOFT_BATE_VER##*B}
    CIM_SOFT_VER=${CIM_SOFT_BATE_VER%%B*}

    return 0;
}

function GetBimInfo()
{
    BIM_SOFT_PACKET_NAME=$1
    
    if [[ -z $BIM_SOFT_PACKET_NAME ]];then
        return 1;
    fi

    BIM_SOFT_PACKET_NAME=${BIM_SOFT_PACKET_NAME%%.*}
    BIM_NAME=${BIM_SOFT_PACKET_NAME%%_*}
    GetCurSoftHardVer $BIM_SOFT_PACKET_NAME
    BIM_SOFT_BATE_VER=${BIM_SOFT_PACKET_NAME#*_}
    BIM_SOFT_BATE_VER=${BIM_SOFT_BATE_VER%%_*}
    BIM_BATE_VER=${BIM_SOFT_BATE_VER##*B}
    BIM_SOFT_VER=${BIM_SOFT_BATE_VER%%B*}
    BIM_VOLT=${BIM_SOFT_PACKET_NAME##*_}
    BIM_VOLT=${BIM_VOLT%%.*}

    return 0;
}

function GetRfInfo()
{
    RF_SOFT_PACKET_NAME=$1

    if [[ -z $RF_SOFT_PACKET_NAME ]];then
        return 1;
    fi

    RF_SOFT_PACKET_NAME=${RF_SOFT_PACKET_NAME%%.*}
    GetCurSoftHardVer $RF_SOFT_PACKET_NAME
    RF_NAME=${RF_SOFT_PACKET_NAME%%_*}
    RF_SOFT_BATE_VER=${RF_SOFT_PACKET_NAME##*_}
    RF_BATE_VER=${RF_SOFT_BATE_VER##*B}
    RF_SOFT_VER=${RF_SOFT_BATE_VER%%B*}

    return 0;
}

function GetSoftPacketName()
{
    local tmpCim=$1
    local tmpBim=$2
    local tmpRf=$3
    local TmpSoftPacketName=""

    GetCimInfo $tmpCim
    if [ 0 == $? ];then
        TmpSoftPacketName=$(echo $CIM_NAME$CIM_HARD_VER $CIM_SOFT_BATE_VER)
        TmpSoftPacketName=$(echo "$TmpSoftPacketName" | tr -s " " "_" )
    fi
    GetBimInfo $tmpBim 
    if [ 0 == $? ];then
        TmpSoftPacketName=$(echo $TmpSoftPacketName $BIM_NAME$BIM_HARD_VER $BIM_SOFT_VER $BIM_VOLT)
        TmpSoftPacketName=$(echo "$TmpSoftPacketName" | tr -s " " "_" )
    fi
    GetRfInfo $tmpRf
    if [ 0 == $? ];then
        TmpSoftPacketName=$(echo $TmpSoftPacketName $RF_NAME $RF_SOFT_VER)
        TmpSoftPacketName=$(echo "$TmpSoftPacketName" | tr -s " " "_" )
    fi
    
    COM_SOFT_PACKET_NAME=$TmpSoftPacketName

    echo "$TmpSoftPacketName"
}

function GetSoftPacketNameWithSuffix()
{
    local tmpCim=$1
    local tmpBim=$2
    local tmpRf=$3
    local TmpSuffix=$4
    local TmpSoftPacketNameWithSuffix=""

    TmpSoftPacketNameWithSuffix=$(GetSoftPacketName $tmpCim $tmpBim $tmpRf)
    if [[ -z $TmpSoftPacketNameWithSuffix ]];then
        return 1;
    fi

    TmpSoftPacketNameWithSuffix=$(echo $TmpSoftPacketNameWithSuffix $TmpSuffix)
    TmpSoftPacketNameWithSuffix=$(echo "$TmpSoftPacketNameWithSuffix" | tr -s " " "_" )

    echo "$TmpSoftPacketNameWithSuffix"
}

function GetWebSoftPacketName()
{
    local tmpCim=$1
    local tmpBim=$2
    local tmpRf=$3
    local TmpSuffix=$4
    local TmpWebSoftPacketName=""

    TmpWebSoftPacketName=$(GetSoftPacketNameWithSuffix $tmpCim $tmpBim $tmpRf $TmpSuffix)
    WEB_SOFT_PACKET_NAME=$TmpWebSoftPacketName

    echo "$TmpWebSoftPacketName"
}

function GetNetEcoSoftPacketName()
{
    local tmpCim=$1
    local tmpBim=$2
    local tmpRf=$3
    local TmpSuffix=$4
    local TmpNetEcoSoftPacketName=""

    TmpNetEcoSoftPacketName=$(GetSoftPacketNameWithSuffix $tmpCim $tmpBim $tmpRf $TmpSuffix)
    NETECO_SOFT_PACKET_NAME=$TmpNetEcoSoftPacketName

    echo "$TmpNetEcoSoftPacketName"
}

function CutSoftPacketNameSuffix()
{
    local tmpCim=$1
    local tmpBim=$2
    local tmpRf=$3
    local TmpSuffix=$4

    GetSoftPacketName $tmpCim $tmpBim $tmpRf
    ${WEB_SOFT_PACKET_NAME##*_}
    if [ 0 == $? ];then
        TmpNetEcoSoftPacketName=$(echo ${WEB_SOFT_PACKET_NAME%_*} $TmpNetEcoSuffix)
        TmpNetEcoSoftPacketName=$(echo $TmpNetEcoSoftPacketName | tr -s " " "_")
    fi

    NETECO_SOFT_PACKET_NAME=$TmpNetEcoSoftPacketName

    return 0;
}
