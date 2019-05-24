#!/bin/bash
### Author:jonnyan404

name=`whoami`
dir=/Users/${name}/Documents/Tchfs
sharedir=/Users/${name}/Desktop/sharedoc

echo "创建桌面共享目录"
mkdir $sharedir &> /dev/null

echo "创建配置文件目录,文稿里的Tchfs目录请勿删除!"
mkdir ${dir} &> /dev/null

echo "下载软件中..."
curl -C - http://iscute.cn/tar/chfs/1.8/chfs-mac-amd64-1.8.zip -o ${dir}/chfs.zip --progress

echo "解压文件并赋权"
unzip -o ${dir}/*.zip -d ${dir} &>/dev/null
chmod 755 ${dir}/chfs

cat >"${dir}/chfs.ini"<<EOF
# 监听端口
port=8081
# 共享根目录
# 注意：带空格的目录须用引号包住，如 path="c:\a uply name\folder"
path=/Users/${name}/Desktop/sharedoc
# 网页标题
html.title=TMP share
html.notice=\`<div style="background:green;color:white;font-size:25px"><marquee behavior="alternate">内部资料,请勿传播.</marquee></div>\`
#----------------- 账户控制规则 -------------------
# 注意：该键值可以同时存在多个，你可以将每个用户的访问规则写成一个rule，这样比较清晰，如：
#     rule=::
#     rule=root:123456:RW
#     rule=readonlyuser:123456:R
rule=::rw
EOF

cat >"/Users/${name}/Desktop/启动共享"<<EOF
#!/bin/bash
/Users/${name}/Documents/Tchfs/chfs --file=/Users/${name}/Documents/Tchfs/chfs.ini
EOF

echo "安装完成,请双击桌面 启动共享 以使用文件共享,共享目录为桌面的 sharedoc 文件夹."
chmod 755 /Users/${name}/Desktop/启动共享
