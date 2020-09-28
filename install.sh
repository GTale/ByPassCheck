#!/bin/bash
SH_PATH=$(cd "$(dirname "$0")";pwd)
cd ${SH_PATH}
DOWNLOAD_PATH="https://raw.githubusercontent.com/GTale/ByPassCheck/master/hyx"

create_mainfest_file(){
    mkdir hyx
    cd hyx
    echo "进行配置。。。"
    read -p "请输入账号: " IBM_ACCOUNT
    read -p "请输入密码: " IBM_PASSWD
    read -p "请输入你的应用名称：" IBM_APP_NAME
    echo "应用名称：${IBM_APP_NAME}"
    read -p "请输入你的应用内存大小(默认256)：" IBM_MEM_SIZE
    if [ -z "${IBM_MEM_SIZE}" ];then
	IBM_MEM_SIZE=256
    fi
    echo "内存大小：${IBM_MEM_SIZE}"
    
    echo "开始下载文件："
    wget $DOWNLOAD_PATH -O hyx
    
    cat << EOF > manifest.yml  
    applications:
    - path: .
      name: ${IBM_APP_NAME}
      random-route: true
      memory: ${IBM_MEM_SIZE}M
      command: chmod +x hyx && ./hyx
      buildpacks:
      - binary_buildpack
EOF

    echo "配置完成。"
}

install(){
    echo "进行安装。。。"
    ibmcloud api https://cloud.ibm.com
    ibmcloud target --cf << EOF
    1
EOF
    ibmcloud cf install -f -v 6.51.0
    ibmcloud cf l <<EOF
$IBM_ACCOUNT
$IBM_PASSWD
EOF

    ibmcloud cf push
    ibmcloud cf apps 
    echo "安装完成。"
}

create_mainfest_file
install
exit 0