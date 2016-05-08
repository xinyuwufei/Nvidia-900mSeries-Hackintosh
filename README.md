# Nvidia-900mSeries-Hackintosh
Fix no signal for Nvidia 900m series Internal display and add brightness Control

# Instructions： 
	click 'download zip' and unzip to a temporary folder
	open the temporary folder where you download/put the script on terminal
	chmod +x Nvidia-900mSeries-Hackintosh.sh
	sh ./Nvidia-900mSeries-Hackintosh.sh

# How to find the Vbios/rom revision
  See your BIOS

# About Brightness Control
  you need to patch your DSDT:
  	1）Brightness slider patch or PNLF acpi patch (not tested yet) on Clover
  	2）Brightness key patch to make the “sun” icon work

 # 中文

 # 使用方法
 	点击‘download zip’按钮，并且解压到一个临时目录
 	用终端打开这个目录eg.:cd ....
 	输入以下两条命令:
 		chmod +x Nvidia-900mSeries-Hackintosh.sh
		sh ./Nvidia-900mSeries-Hackintosh.sh
 # 如何找到 Vbios revision
  	在你电脑的BIOS信息里

 # 关于亮度调节
  你需要给你电脑的dsdt打补丁:
  	1)打‘Brightness slider’补丁或者在clover的上打PNLF补丁(没测试)
  	2)打‘Brightness key’补丁使其能用‘小太阳’
