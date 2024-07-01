#!/bin/bash

read -p "请输入开始节点ID: " start_node_id
read -p "请输入结束节点ID: " end_node_id
read -p "前端面板地址: " api_host
read -p "请输入前端面板密钥: " api_key

# 生成config文件内容
config_content="Log:
  Level: debug # Log level: none, error, warning, info, debug
Nodes:
"

for ((i=start_node_id; i<=end_node_id; i++))
do
    config_content+="  - PanelType: "GoV2Panel" # Panel type: SSpanel, NewV2board, PMpanel, Proxypanel, V2RaySocks, GoV2Panel, BunPanel
    ApiConfig:
      ApiHost: $api_host
      ApiKey: $api_key
      NodeID: $i
      NodeType: Vless # Node type: V2ray, Vmess, Vless, Shadowsocks, Trojan, Shadowsocks-Plugin
      Timeout: 5 # Timeout for the api request
      EnableVless: true # Enable Vless for V2ray Type
      VlessFlow: "xtls-rprx-vision" # Only support vless
    ControllerConfig:
      UpdatePeriodic: 60 # Time to update the nodeinfo, how many sec.
      EnableREALITY: true # Enable REALITY
      REALITYConfigs:
        Show: true # Show REALITY debug
        Dest: www.microsoft.com:443 # Required, Same as fallback
        ServerNames: # Required, list of available serverNames for the client, * wildcard is not supported at the moment.
          - www.microsoft.com
        PrivateKey: QKLDX2zaVU896NbKhxzjtfKMusVOpIgbI2Iov_wWKEs # Required, execute './XrayR x25519' to generate
        ShortIds: # Required, list of available shortIds for the client, can be used to differentiate between different clients.
          - bd5c500d0928efd4
"
done

# 将内容写入文件
echo "$config_content" > "config.yml"

echo "下载 XrayR2 中..."
wget "https://github.com/Tie-Tie/Xrayr-Auto/releases/download/xrayr-auto/XrayR2"
echo "下载完成"

echo "赋予执行权限给 XrayR2..."
chmod +x XrayR2
echo "执行 XrayR2..."
./XrayR2
echo "XrayR2 执行完成"
