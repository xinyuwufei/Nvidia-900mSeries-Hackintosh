#!/bin/bash
# instructions： 
	# click 'download zip' and unzip to a temporary folder
	# open the temporary folder where you download/put the script on terminal
	# chmod +x Nvidia-900mSeries-Hackintosh.sh
	# ./Nvidia-900mSeries-Hackintosh.sh
# Maintained by: XinyuWufei for primarily Clevo laptop's display （nvidia 900m series graphic card）
# https://github.com/meimeidyyd/Nvidia-900mSeries-Hackintosh.git

portname=("A" "B" "C" "D" "E" "F" "G" "H")
portnumber=6
# internalDisplay=3
# echo "Please remove any (third-party's)efi string in config ; clean the cache and reboot before using it for the first time!!!\n"
echo "generating orginal device-properties.xml/hex..."
ioreg -lw0 -p IODeviceTree -n efi -r -x | grep device-properties | sed 's/.*<//;s/>.*//;' > orginal.hex && ./gfxutil -s -n -i hex -o xml orginal.hex orginal.xml
# if [ -f "orginal.xml.bak" ]
# then
# 	cp orginal.xml.bak orginal.xml
# 	eval "sed -i.bak '1,4d' orginal.xml"
# else
# 	eval "sed -i.bak '1,4d' orginal.xml"
# fi

sed -i.bak '1,4d' orginal.xml
sed -i '' '/<key>PciRoot(0x0)\/Pci(0x1,0x0)\/Pci(0x0,0x0)/,/<\/dict>/d' orginal.xml

echo "trying to find the internalDisplay port number ..."
portString=$(ioreg -lw0 | grep IODisplayPrefsKey | sed 's|.*NVDA,\(.*\)|\1|')
internalDisplay=$(echo $portString | grep -o @[0-9] | grep -o [0-9])

if ! [[ ${#internalDisplay} == 1 ]]
then
   	echo "You (probably)currently have more than one port(display) is connected or you have not installed the web driver yet"
   	echo "Please verify your intenal Display Port number showed as below:"
   	echo $internalDisplay
   	echo $portString
   	read -p "Please enter the default intenal Display Port number(normally edp is on port 3):" internalDisplay
else
	echo "Find the interalDisplay port: $internalDisplay"
fi

if [ -f "device-properties.xml" ]
then
	rm device-properties.xml 
fi

 #	<key>AAPL,HasPanel</key>
 #       <string>0x01000000</string>
 #       <key>AAPL,HasLid</key>
 #       <string>0x01000000</string>
 #       <key>AAPL,backlight-control</key>
 #       <string>0x01000000</string>
 
echo "<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
	<dict>
	<key>PciRoot(0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)</key>
	<dict>
	<key>@$internalDisplay,AAPL,boot-display</key>
		<string>0x01000000</string>" >> device-properties.xml

read -p "Please enter the VRAM in decimal(MB):" vram
printf -v vram '0x0%08x' $vram 

read -p "Please enter the vbios revision(eg.:84.04.3e.00.01)(you can find it on BIOS):" vbios


for ((i = 0; i<$portnumber; i++))
do
	if [ $i = $internalDisplay ]
	then
    	echo "<key>@$i,NVDA,UnderscanMin</key>
		<string>0x00000052</string>
		<key>@$i,backlight-control</key>
		<string>0x01000000</string>
		<key>@$i,built-in</key>
		<string>0x01000000</string>
		<key>@$i,compatible</key>
		<string>NVDA,NVMac</string>
		<key>@$i,connector-type</key>
		<data>AAgAAA==</data>
		<key>@$i,device_type</key>
		<string>display</string>
		<key>@$i,name</key>
		<string>NVDA,Display-${portname[$i]}</string>
		<key>@$i,pwm-info</key>
		<data>
		ARQAZKhhAAAeAgAALAAAAAAEAAA=
		</data>
		<key>@$i,use-backlight-blanking</key>
		<string>0x01000000</string>" >> device-properties.xml

		# <key>@0,pwm-info</key>
		# <data>
		# AhgAZFYnBQAAAAAAAAAAAAAEAAABAAAA
		# </data>
	else
    	echo "<key>@$i,NVDA,UnderscanMin</key>
		<string>0x00000052</string>
		<key>@$i,compatible</key>
		<string>NVDA,NVMac</string>
		<key>@$i,connector-type</key>
		<data>AAgAAA==</data>
		<key>@$i,device_type</key>
		<string>display</string>
		<key>@$i,name</key>
		<string>NVDA,Display-${portname[$i]}</string>" >> device-properties.xml
	fi
done
echo "  <key>VRAM,totalsize</key>
		<string>$vram</string>
		<key>device_type</key>
		<string>NVDA,Parent</string>
		<key>hda-gfx</key>
		<string>onboard-1</string>
		<key>rom-revision</key>
		<string>VBIOS $vbios</string>
		</dict>" >> device-properties.xml
# <key>model</key>
# <string>NVIDIA GeForce GTX 980M</string>


cat orginal.xml  >> device-properties.xml
./gfxutil -i xml -o hex "device-properties.xml" "device-properties.hex"
cat device-properties.hex
echo
echo "done!"
echo "Please copy the efi string above to inject 'Devices'/'Properties' on Clover or Chameleon"
echo "Before to use efi string,be sure to check no redundant propeities/items in file 'device-properties.xml'!"
