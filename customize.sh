#!/system/bin/sh
SKIPMOUNT=false
PROPFILE=true
POSTFSDATA=false
LATESTARTSERVICE=false
MODNAME="(💮Sakura Premium)🚀Sakura Optimizer V13🚀"
DEVNAME="KayeXSakura And Zenin"
DEVLINK="@KayeXSakura With @zenin_911"
LINKPUB="t.me/MagiskModuleBySakura"


REPLACE_EXAMPLE="
/system/app/Youtube
/system/priv-app/SystemUI
/system/priv-app/Settings
/system/framework
"

REPLACE="
"
####################
#SAKURA FPS BOOSTER#
# UNIVERSAL MODULE #
##################
TMPDIR=$NVBASE/KayeXSakura6in1
[ -d $TMPDIR ] && rm -rf $TMPDIR
mkdir -p $TMPDIR

unzip -o "$ZIPFILE" module.prop -d $TMPDIR >&2
chmod -R 777 $TMPDIR

MODID=`grep_prop id $TMPDIR/module.prop`
MODAUTHOR=`grep_prop author $TMPDIR/module.prop`
MODNAME=`grep_prop name $TMPDIR/module.prop`
MODVERSION=`grep_prop version $TMPDIR/module.prop`
rm -rf $TMPDIR

mkdir -p $NVBASE/modules_update/$MODID/system/
mkdir -p $NVBASE/modules_update/$MODID/system/vendor/
mkdir -p $NVBASE/modules_update/$MODID/system/lib64
cp /vendor/build.prop $NVBASE/modules_update/$MODID/system/vendor/
cp /system/lib64/android.frameworks.displayservice@1.0.so $NVBASE/modules_update/$MODID/system/lib64/
sleep 1
sed -i "/offset/d" $NVBASE/modules_update/$MODID/system/vendor/build.prop
sleep 0.2
echo "" >> $NVBASE/modules_update/$MODID/system/vendor/build.prop
echo "debug.egl.swapinterval=-60" >> $NVBASE/modules_update/$MODID/system/vendor/build.prop
echo "viewroot.profile_rendering=true" >> $NVBASE/modules_update/$MODID/system/vendor/build.prop
rm -rf $TMPDIR
 #Do not delete the default permissions
  set_perm_recursive $MODPATH 0 0 0777 0777
###########################
# UNLIMITED GOOGLE PHOTOS  #
# By: @KayeXSakura             #
########################
    if [ "$BOOTMODE" ] && [ "$KSU" ]; then
        ui_print "KernelSU app"
        sed -i "s/^des.*/description= [😄 KernelSU loaded] Enable ${MODNAME} /g" $MODPATH/module.prop
        ui_print "- KernelSU: $KSU_KERNEL_VER_CODE (kernel) + $KSU_VER_CODE (ksud)"
        if [ "$(which magisk)" ]; then
            ui_print "*********************************************************"
            ui_print "! Multiple root implementation is NOT compatible!"
            ui_print "! Please uninstall Magisk before installing Zygisksu"
            abort "*********************************************************"
        fi
    elif [ "$BOOTMODE" ] && [ "$MAGISK_VER_CODE" ]; then
        sed -i "s/^des.*/description= [ Magisk loaded] ${MODNAME} /g" $MODPATH/module.prop
    else
        ui_print "*********************************************************"
        ui_print "Recovery not supported"
        abort "*********************************************************"
    fi
    echo "- Installing $MODNAME!"
    unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2

    # Remove comments and add a blank line at the end if it doesn't exist for script files
    for i in $(find $MODPATH -type f -name "*.sh" -o -name "*.prop" -o -name "*.rule"); do
        [ -f $i ] && {
            sed -i -e "/^#/d" -e "/^ *$/d" $i
            [ "$(tail -1 $i)" ] && echo "" >> $i
        } || continue
    done

    # Loop through files in /system/product/etc/sysconfig/
    for i in /system/product/etc/sysconfig/*; do
        file=$i
        file=${file/\/system\/product\/etc\/sysconfig\//}
        if [ ! -z "$(grep PIXEL_2020_ $i)" ] || [ ! -z "$(grep PIXEL_2021_ $i)" ] || [ ! -z "$(grep PIXEL_2019_PRELOAD $i)" ] || [ ! -z "$(grep PIXEL_2018_PRELOAD $i)" ] || [ ! -z "$(grep PIXEL_2017_PRELOAD $i)" ] || [ ! -z "$(grep PIXEL_2022_ $i)" ]; then
            [ ! -f $MODPATH/system/product/etc/sysconfig/$file ] &&
                cat /product/etc/sysconfig/$file |
                grep -v PIXEL_2020_ |
                grep -v PIXEL_2021_ |
                grep -v PIXEL_2022_ |
                grep -v PIXEL_2018_PRELOAD |
                grep -v PIXEL_2019_PRELOAD |
                grep -v PIXEL_2017_PRELOAD > $MODPATH/system/product/etc/sysconfig/$file
        fi
    done

    # Loop through files in /system/etc/sysconfig/
    for i in /system/etc/sysconfig/*; do
        file=$i
        file=${file/\/system\/etc\/sysconfig\//}
        if [ ! -z "$(grep PIXEL_2020_ $i)" ] || [ ! -z "$(grep PIXEL_2021_ $i)" ] || [ ! -z "$(grep PIXEL_2019_PRELOAD $i)" ] || [ ! -z "$(grep PIXEL_2018_PRELOAD $i)" ] || [ ! -z "$(grep PIXEL_2017_PRELOAD $i)" ] || [ ! -z "$(grep PIXEL_2022_ $i)" ]; then
            [ ! -f $MODPATH/system/product/etc/sysconfig/$file ] &&
                cat /system/etc/sysconfig/$file |
                grep -v PIXEL_2020_ |
                grep -v PIXEL_2021_ |
                grep -v PIXEL_2022_ |
                grep -v PIXEL_2018_PRELOAD |
                grep -v PIXEL_2019_PRELOAD |
                grep -v PIXEL_2017_PRELOAD > $MODPATH/system/etc/sysconfig/$file
        fi
    done

    # Check if $MODPATH/system/product/etc/sysconfig directory exists
    if [ -d $MODPATH/system/product/etc/sysconfig ]; then
        # Loop to copy files from $MODPATH/system/product/etc/sysconfig to $PRODUCT
        for i in $MODPATH/system/product/etc/sysconfig/*; do
            file=$i
            file=${file/\/data\/adb\/modules\/gphotos_apmods\/product\/etc\/sysconfig\//}
            if [ ! -f /product/etc/sysconfig/$file ]; then
                cp -f $MODPATH/system/product/etc/sysconfig/$file /product/etc/sysconfig/$file
                chmod 0644 /product/etc/sysconfig/$file
                chcon -h u:object_r:system_file:s0 /product/etc/sysconfig/$file
            fi
        done
    fi

    # Check if $MODPATH/system/etc/sysconfig directory exists
    if [ -d $MODPATH/system/etc/sysconfig ]; then
        # Loop to copy files from $REMOVER_SYS/etc/sysconfig to $MODPATH
        for i in $MODPATH/system/etc/sysconfig/*; do
            file=$i
            file=${file/\/data\/adb\/modules\/gphotos_apmods\/system\/etc\/sysconfig\//}
            if [ ! -f /system/etc/sysconfig/$file ]; then
                cp -f $MODPATH/system/etc/sysconfig/$file /system/etc/sysconfig/$file
                chmod 0644 /system/etc/sysconfig/$file
                chcon -h u:object_r:system_file:s0 /system/etc/sysconfig/$file
            fi
        done
    fi
# Clearing previous log file if it exists
rm -rf /data/local/tmp/sakuraxzenlog.txt
LOG_FILE="/data/local/tmp/sakuraxzenlog.txt"

# Converting version to numerical value for comparison
current_version=$(getprop ro.build.version.release)
MODAND_NUM=$(echo "$MODAND" | awk -F'.' '{ printf("%d%02d", $1, $2); }')
current_version_NUM=$(echo "$current_version" | awk -F'.' '{ printf("%d%02d", $1, $2); }')


am start -a android.intent.action.VIEW -d https://t.me/MagiskModulesAndApp/u0xs36mu8?key=813a284c6297605783693cce073b8e99 >/dev/null 2>&1 & >/dev/null 2>&1 &
sleep 10
echo " • Initiating checks" | tee -a $LOG_FILE
# Checking Android version
echo " • Checking Android version" | tee -a $LOG_FILE
if [ "$current_version_NUM" -lt "$MODAND_NUM" ]; then
  echo " • Error: Android version is not compatible" | tee -a $LOG_FILE
  exit 1
fi

sleep 2
# Determining RAM size in gigabytes
total_ram_kb=$(cat /proc/meminfo | grep "MemTotal" | tr -s ' ' | cut -d ' ' -f 2)
total_ram_gb=$(echo "scale=2; ${total_ram_kb} / (1024 * 1024)" | bc)
echo " • Determining RAM size: ${total_ram_gb} Gb" | tee -a $LOG_FILE

sleep 2
# Checking for Google Tensor devices
TENSORCHECK="Tensor\|Tensor G2\|Tensor G3\|Tensor G4\|GS201"
echo " • Checking for Google Tensor devices"
if grep -Eq "ro.soc.model=($TENSORCHECK)" /vendor/build.prop && grep -Eq "ro.soc.model=($TENSORCHECK)" /system/build.prop; then
  echo " • Error: Tensor device detected, aborting module installation"
  exit 1
fi

  echo "
█▀ ▄▀█ █▄▀ █░█ █▀█ ▄▀█
▄█ █▀█ █░█ █▄█ █▀▄ █▀█
"
  echo "
█▀▄▀█ █▀█ █▀▄ █░█ █░░ █▀▀ █▀
█░▀░█ █▄█ █▄▀ █▄█ █▄▄ ██▄ ▄█
"
  echo "--------------------------------------------------------------------"
  echo " | Module Name: $MODNAME"
  sleep 2
  echo " | • Your Device          : $(getprop ro.product.name) | $(getprop ro.product.system.model) | $(getprop ro.product.system.brand) "
  echo " | • Your SoC Version     : $(getprop ro.product.board) "
  echo " | • Your Android Version : $(getprop ro.build.version.release) | SDK: $(getprop ro.build.version.sdk)"
  echo " | • Your ABI Version     : $(getprop ro.product.cpu.abi) "
  echo " | • Your Processor       : $(getprop ro.soc.model) "
  echo " | • Your Firmware        : $(getprop ro.build.display.id) "
  echo " | • Your Kernel Version  : $(uname -r) "
  sleep2
  echo "--------------------------------------------------------------------"
  sleep 2
  echo " |"
  sleep 2
  echo " | Information Block"
  sleep 2
  echo " |"
  sleep 4
  echo " | This Module  helps the multithread line to tell the cpu to easily do more faster proccessing without "
  sleep 2
  echo " | overheat Best For Gamers it also Remove lock 60hz When PowerBoost is anabled it will Also Optimizes Your Hardware This Does Also Boost Your "
  sleep 2
  echo " | Wifi Speed Made By:Kaye And Zenin Join My Telegram https://t.me/MagiskModuleBySakura"
  sleep 2
  echo "--------------------------------------------------------------------"
  sleep 2
  echo " | • All checks passed, starting installation" | tee -a $LOG_FILE
  sleep 2
  echo " | • TCP/IP Optimization"
  sleep 2
  echo " | • Wi-Fi Optimization"
  sleep 2
  echo " | • RSRP, RSRQ, SINR, and RSSI Optimization"
  sleep 2
  echo " | • Network Stack Optimization"
  sleep 2
  echo " | • Traffic Calibration"
  sleep 2
  echo " | • IPTables Calibration"
  sleep 2
  echo " | • Adjusting TCP receive and transmit buffer sizes"
  sleep 2
  echo " | • Adjusting HeapSize based on RAM size"
  sleep 2
  echo " | • Enabling TTL Random Value (TTLRV)"
  sleep 2
  echo " | • Enabling DTL, EONS, and AMR"
  sleep 2
  echo " | • Enabling Default MSAA"
  sleep 2
  echo " | • Enabling Automatic Kernel Fix (AKF)"
  sleep 2
  echo " | • Enabling Licensed Assisted Access (LAA)"
  sleep 2
  echo " | • Enabling Multiple-Input Multiple-Output (MIMO)"
  sleep 2
  echo " | • Enabling Receiver Diversity (RxDiv)"
  sleep 2
  echo " | • Activating Carrier Aggregation (CA)"
  echo " | • Activating TCP Fast Open"
  sleep 2
  echo " | • Activating and overriding default settings for RMEM and WMEM"
  sleep 2
  echo " | • Activating LTE Advanced commands for modem"
sleep 2
  echo " | • Activating Random TTL Generation"
  sleep 2
  echo " | • Added MACAR (MAC Address Randomization)"
  sleep 2
  echo " | • Added LTEAA (Aggregation Added)"
  sleep 2
  echo " | • Increasing maximum open file descriptors"
  sleep 2
  echo " | • Forcing activation of LTE-A, AGPS"
  sleep 2
  echo " | • Disabling EAP-SIM patch"
  sleep 2
  echo " | • Script executed successfully"
  sleep 2
  echo " | • Installation completed"
  sleep 2
  echo " |"
  sleep 2
  echo " | • Developer:          $DEVNAME"
  sleep 2
  echo " | • Telegram:          $DEVLINK"
  sleep 2
  echo " |"
  sleep 2
  echo " | Special thanks for testing:"
  sleep 2
  echo " | @Bricker, @Scammer, @Itachi"
  sleep 2
  echo " |"
  sleep 2
  echo " | Telegram Channel: $LINKPUB"
  sleep 2
  echo "--------------------------------------------------------------------"
  echo " Installing Module, Please Wait"
  sleep 5
  echo "≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠"
  sleep 5
  echo " Cry And Go To The Repair Shop"
  sleep 6
  echo "≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠"
  sleep 6
  echo " Congrats Your Now Bricked Good Bye"
  sleep 6
  echo "≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠"
  sleep 6
  echo "≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠"
  sleep 6
  am start -a android.intent.action.VIEW -d https://t.me/MagiskModulesAndApp >/dev/null 2>&1 & >/dev/null 2>&1 &
  echo " THANKS FOR BUYING AND SUPPORTING @KayeXSakura❤️"
  sleep 6
  echo "≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠"
  sleep 6
  echo " 
▒█▀▀█ █░░█ █▀▀ 
▒█▀▀▄ █▄▄█ █▀▀ 
▒█▄▄█ ▄▄▄█ ▀▀▀
 "
  sleep 7
  echo "
█████████████████████████████████████████
█▄─▄─▀█▄─▄▄▀█▄─▄█─▄▄▄─█▄─█─▄█▄─▄▄─█▄─▄▄▀█
██─▄─▀██─▄─▄██─██─███▀██─▄▀███─▄█▀██─██─█
▀▄▄▄▄▀▀▄▄▀▄▄▀▄▄▄▀▄▄▄▄▄▀▄▄▀▄▄▀▄▄▄▄▄▀▄▄▄▄▀▀
 "

# Function to install module files
on_install() {
  ui_print "- Extracting module files"
  unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
}

# Function to set permissions
set_permissions() {
  set_perm_recursive $MODPATH 0 0 0755 0644
}
