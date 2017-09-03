#!/bin/bash
export CRC=md5sum
export CUR_DIR=$(pwd)
#export CODE_DIR=$(dirname $CUR_DIR)
export CODE_DIR=$CUR_DIR

if [ -z $ALL_SOFT_PACKET_DIR ];then
    #export ALL_SOFT_PACKET_DIR=$CODE_DIR/`date "+%Y%m%d_%H%M%S"`
    export ALL_SOFT_PACKET_DIR=/tmp/`date "+%Y%m%d_%H%M%S"`
fi
export COM_SOFT_PACKET_NAME=""
export WEB_SOFT_PACKET_NAME="WEB"
export NETECO_SOFT_PACKET_NAME="NETECO"

export WEB_SOFT_PACKET_DIR="$ALL_SOFT_PACKET_DIR/WEB_SOFT_PACKET_DIR"
export NETECO_SOFT_PACKET_DIR="$ALL_SOFT_PACKET_DIR/NETECO_SOFT_PACKET_DIR"
 
export CIM_CODE_DIR=$CODE_DIR/SoftDir
export CIM_SOFT_PACKET_NAME=
export CIM_NAME=
export CIM_SOFT_BATE_VER=
export CIM_SOFT_VER=
export CIM_BATE_VER=
export CIM_HARD_VER=
 
export BIM_CODE_DIR=$CODE_DIR/SoftDir
export BIM_SOFT_PACKET_NAME=
export BIM_NAME=
export BIM_SOFT_BATE_VER=
export BIM_SOFT_VER=
export BIM_BATE_VER=
export BIM_HARD_VER=
export BIM_VOLT=

export RF_CODE_DIR=$CODE_DIR/SoftDir
export RF_SOFT_PACKET_NAME=
export RF_NAME=
export RF_SOFT_BATE_VER=
export RF_SOFT_VER=
export RF_BATE_VER=
export RF_HARD_VER=

export WorkDir="$CODE_DIR/WorkDir"
export SoftCfg="$ALL_SOFT_PACKET_DIR/SoftCfg"
