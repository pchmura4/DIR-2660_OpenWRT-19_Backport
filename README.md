# D-Link DIR-2660 OpenWRT 19.07
OpenWRT 19.07 backport for D-Link DIR-2660 A1 router. It's a ready-made stable branch backport for DIR-2660. Tested on my machine with typical issues for older MT76 wireless driver. Apart from having a parallel NAND memory, in this device model SGE introduced different image padding.  
# Flashing
Set your computer IP to 192.168.0.2 and gateway to 192.168.0.1  
While pressing the RESET button power on the device. Hold the button until the power will start to flash.  
Access 192.168.0.1 from your web browser to access recovery environment and upload the factory bin file.  
Don't mind the progress, it's just a hardcoded counter with no relevance. Watch the LEDs until the router reboots.  
# Building
Ubuntu 18.04 is the recommended build environment. Before attempting to build the image, install the required packages by issuing the commands below:
```console
sudo apt update
sudo apt install build-essential ccache ecj fastjar file g++ gawk \
gettext git java-propose-classpath libelf-dev libncurses5-dev \
libncursesw5-dev libssl-dev python python2.7-dev python3 unzip wget \
python3-distutils python3-setuptools rsync subversion swig time \
xsltproc zlib1g-dev 
```
Next clone the repository and enter the directory:
```console
git clone https://github.com/pchmura4/DIR-2660_OpenWRT-19_Backport
cd DIR-2660_OpenWRT-19_Backport
```
Make the script executable and run it:
```console
chmod +x build.sh
./build.sh
```
Upon completing the build process two binaries should appear in the directory. By changing the third line inside the script you can switch the release to a different version.