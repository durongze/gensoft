#!/bin/bash

function DispCimInfo()
{
    echo "CIM_CODE_DIR             =  $CIM_CODE_DIR"
    echo "CIM_SOFT_PACKET_NAME     =  $CIM_SOFT_PACKET_NAME"
    echo "CIM_NAME                 =  $CIM_NAME"
    echo "CIM_SOFT_BATE_VER        =  $CIM_SOFT_BATE_VER"
    echo "CIM_SOFT_VER             =  $CIM_SOFT_VER"
    echo "CIM_BATE_VER             =  $CIM_BATE_VER"
    echo "CIM_HARD_VER             =  $CIM_HARD_VER"
    return 0;
}

function DispBimInfo()
{
    echo "BIM_VOLT                 =  $BIM_VOLT"
    echo "RF_CODE_DIR              =  $RF_CODE_DIR"
    echo "RF_SOFT_PACKET_NAME      =  $RF_SOFT_PACKET_NAME"
    echo "RF_NAME                  =  $RF_NAME"
    echo "RF_SOFT_BATE_VER         =  $RF_SOFT_BATE_VER"
    echo "RF_SOFT_VER              =  $RF_SOFT_VER"
    echo "RF_BATE_VER              =  $RF_BATE_VER"
    echo "RF_HARD_VER              =  $RF_HARD_VER"
    return 0;
}

function DispRfInfo()
{
    echo "BIM_CODE_DIR             =  $BIM_CODE_DIR"
    echo "BIM_SOFT_PACKET_NAME     =  $BIM_SOFT_PACKET_NAME"
    echo "BIM_NAME                 =  $BIM_NAME"
    echo "BIM_SOFT_BATE_VER        =  $BIM_SOFT_BATE_VER"
    echo "BIM_SOFT_VER             =  $BIM_SOFT_VER"
    echo "BIM_BATE_VER             =  $BIM_BATE_VER"
    echo "BIM_HARD_VER             =  $BIM_HARD_VER"
    return 0;
}                                

function DispGenSoftInfo
{
    echo "WEB_SOFT_PACKET_NAME     =  $WEB_SOFT_PACKET_NAME"
    echo "NETECO_SOFT_PACKET_NAME  =  $NETECO_SOFT_PACKET_NAME"
    return 0;
}

function DispSrcSoftCfg()
{
    echo "####[CIM:$CIM_SOFT_PACKET_NAME][RF:$RF_SOFT_PACKET_NAME][BIM:$BIM_SOFT_PACKET_NAME]####"
    cat $SoftCfg/${CIM_SOFT_PACKET_NAME}.cfg 
    cat $SoftCfg/${RF_SOFT_PACKET_NAME}.cfg
    cat $SoftCfg/${BIM_SOFT_PACKET_NAME}.cfg
    echo "####[SUB:$WEB_SOFT_PACKET_NAME]"
    cat $SoftCfg/${WEB_SOFT_PACKET_NAME}.cfg
}

function DispGenSoftCfg()
{
    echo "#########################Pre Web config.txt############################"
    cat $WorkDir/config.txt
    echo "#########################Pre Web configa8.txt############################"
    cat $WorkDir/configa8.txt
    
    echo "#########################Pre Net config.txt############################"
    cat $WEB_SOFT_PACKET_DIR/config.txt
    echo "#########################Pre Net config.xml############################"
    cat $WEB_SOFT_PACKET_DIR/config.xml
}
function ShowBoxEnv()
{
    echo -e "*********************[\033[033mSuccess\033[0m]****************"
    #echo "CUR_DIR                  =  $CUR_DIR"
    #echo "CODE_DIR                 =  $CODE_DIR"
    #echo "WEB_SOFT_PACKET_DIR      =  $WEB_SOFT_PACKET_DIR"
    #echo "NETECO_SOFT_PACKET_DIR   =  $NETECO_SOFT_PACKET_DIR"
    #DispCimInfo
    #DispBimInfo
    #DispRfInfo
    #DispGenSoftInfo
    DispSrcSoftCfg
    #DispGenSoftCfg
    return 0;
}
