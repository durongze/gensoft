#!/bin/bash

. comm_env.sh
. comm_func.sh
. find_soft.sh
. gen_soft_cfg.sh
. get_soft_info.sh
. gen_soft_packet.sh
. print_env.sh


#FindSoftFromSpecDir "$CIM_CODE_DIR" "*cim*" "$WorkDir" 
#
#if [ 0 != $? ];then
#    echo "no find cim soft packet !"
#    exit -1;
#fi
#
#FindSoftFromSpecDir "$BIM_CODE_DIR" "*bim*_12v*" "$WorkDir"
#
#if [ 0 != $? ];then
#    echo "no find bim soft packet !"
#    exit -1;
#fi
#
#FindSoftFromSpecDir "$RF_CODE_DIR" "*cc*8*" "$WorkDir"
#
#if [ 0 != $? ];then
#    echo "no find rf soft packet !"
#    exit -1;
#fi

pushd $WorkDir >>/dev/null
for cim in $(ls [Cc][Ii][Mm]*.*)
do
    cim=${cim%%.*}
    GetCimInfo  $cim

    for bim in $(ls [Bb][Ii][Mm]*.*)
    do
        bim=${bim%%.*}
        GetBimInfo  $bim

        for rf in $(ls [Cc][Cc]*.*)
        do
            rf=${rf%%.*}
            GetRfInfo $rf 
            
            #1.1 生成软件包名称
            GetWebSoftPacketName $cim $bim $rf "WEB" 
            #GetSoftPacketNameWithSuffix $cim $bim $rf "WEB" 

            #1.2 生成子包配置信息
            GenCimCfgInfo $cim
            GenBimCfgInfo $bim
            GenRfCfgInfo $rf
            
            #1.3 根据子包信息生成配置文件
            GenWebSoftCfgFile $cim $rf $bim $WorkDir/config.txt
            GenWebSoftA8CfgFile $cim $WorkDir/configa8.txt
            
            #1.4 生成软件包
            GenWebSoftPacket "$cim" "$bim" "$rf" "$WEB_SOFT_PACKET_DIR/${WEB_SOFT_PACKET_NAME}.tar.gz"

            pushd $WEB_SOFT_PACKET_DIR >>/dev/null

            #2.1 生成软件包名称
            GetNetEcoSoftPacketName $cim $bim $rf "NETECO"
            #GetSoftPacketNameWithSuffix $cim $bim $rf "NETECO"
            
            #2.2 生成子包配置信息
            GenWebSoftCfgInfo "${WEB_SOFT_PACKET_NAME}.tar.gz"

            #2.3 根据子包生成配置文件
            GenNetEcoSoftCfgFile "${WEB_SOFT_PACKET_NAME}.tar.gz"  "$WEB_SOFT_PACKET_DIR/config.txt"
            GenNetEcoSoftXmlFile "${WEB_SOFT_PACKET_NAME}.tar.gz"  "$WEB_SOFT_PACKET_DIR/config.xml"

            #2.4 生成软件包
            GenNetEcoPacket ${WEB_SOFT_PACKET_NAME}.tar.gz $NETECO_SOFT_PACKET_DIR/${NETECO_SOFT_PACKET_NAME}.tar.gz
            popd >>/dev/null
            
            #3. 所有信息打印
            ShowBoxEnv
        done;
    done;
done;
popd >>/dev/null
####################################
