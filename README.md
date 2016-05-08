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

  <h2>中文说明</h2><br />

  使用方法<br />
 	点击‘download zip’按钮，并且解压到一个临时目录<br />
 	用终端打开这个目录eg.:cd ....<br />
 	输入以下两条命令:<br />
 		chmod +x Nvidia-900mSeries-Hackintosh.sh<br />
		sh ./Nvidia-900mSeries-Hackintosh.sh<br />
   如何找到 Vbios revision<br />
  	在你电脑的BIOS信息里<br />

  关于亮度调节<br />
  	你需要给你电脑的dsdt打补丁:<br />
  	1)打‘Brightness slider’补丁或者在clover的上打PNLF补丁(没测试)<br />
  	2)打‘Brightness key’补丁使其能用‘小太阳’<br />
