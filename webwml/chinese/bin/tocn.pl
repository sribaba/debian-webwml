#!/usr/bin/perl -pi

# $Id$

s|^(<html lang="zh)">|$1-CN">|i;
s|^(<meta http-equiv=.*charset)=big5">|$1=gb2312">|i;
s/(\.zh)(?=\.(?:gif|jpg|png))/$1-cn/g;
s|^<A href=".*">(&#20013;&#25991;&nbsp;.+CN.+)</A>(?=&nbsp;)|<B>$1</B>|;

# 先把全部「著」字转为「着」……
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)著/$1着/);

# 然后再在适当的词语，把「着」字转回「著」……
#	著作、著者、著名、著述、著重、著书
#	所著、土著、显著、编著
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*(?:所|土|显|编))着/$1著/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)着(?=作|者|名|述|重|书)/$1著/);


# s/\<s\<(.+?)\>\>/$1/g;
# s/\<t\<文件\>\>/文档/g;
# s/\<t\<延伸\>\>/扩展/g;

s/软(?:体|件)套件/软件包/g;
s/命令稿/脚本/g;
s/(?:启|起)动磁(?:碟|片)/启动盘/g;
s/引导盘/启动盘/g;
s/(?:救援|急救)磁(?:碟|片)/急救盘/g;
s/全球资讯网/万维网/g;
s/网际网(络|路)/互联网/g;
s/使用者/用户/g;
s/原始(程式)?码/源代码/g;
s/原程式码/源代码/g;
s/修补档案/补丁文件/g;
s/修补档/补丁/g;
s/映射站(台)?/镜像/g;
s/映像档(案)?/映像/g;

s/数据机(?!器|械|件)/调制解调器/g;
s/新闻群组/新闻组/g;

1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)—/$1─/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)「/$1“/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)」/$1”/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)『/$1“/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)』/$1”/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)相容/$1兼容/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)(?<!发行)套件/$1软件包/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)电脑/$1计算机/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)模组/$1模块/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)支援/$1支持/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)字型/$1字体/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*(软|硬))体/$1件/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*(软|硬|光|磁|Zip ))碟/$1盘/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)以太(?=网)/$1乙太/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)闸道/$1网关/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)站台/$1站点/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)频宽/$1带宽/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)宽频/$1宽带/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)甚么/$1什么/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)移除/$1删除/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)位址/$1地址/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)回覆/$1回复/);

# Subject line
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)标题列/$1主题行/);

1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)资讯/$1信息/);
# 1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)资讯/$1信息/);

1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)字型/$1字体/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)萤幕/$1屏幕/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)游标/$1光标/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)滑鼠/$1鼠标/);

1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)介面/$1界面/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)连(?=络|系)/$1联/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)网路/$1网络/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)计画/$1计划/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)(?:经由|透过)/$1通过/);


1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)程式设计员/$1程序师/);
1 while (s/^((?:[\x00-\x7F]|[\x80-\xFF].)*)(?<!方)程式/$1程序/);

s/(通信|邮递)论坛/邮件列表/g;
s/发行情报/发行信息/g;
s/作业系统/操作系统/g;
s/视窗系统/窗口系统/g;
s/伺服器/服务器/g;
s/(纯)?文字档(案)?/文本文件/g;
s/文字(?=模式|编辑|处理)/文本/g;
s/档案管理员/文件管理器/g;
s/档案系统/文件系统/g;
s/预设值/默认值/g;
s/(?:列|印)表机/打印机/g;
s/列印/打印/g;
s/记忆体/内存/g;
s/字元提示器/提示符/g;
s/设定档(?:案)?/配置文件/g;
s/档案名称/文件名/g;
s/函式库/程序库/g;
s/资料库/数据库/g;
