#!/bin/bash
# 
echo "toor" | sudo -S chmod ugo+rwx /sys/devices/system/cpu/intel_pstate/min_perf_pct /sys/class/drm/card0/gt_min_freq_mhz

cpu_off=0
gpu_off=0
cpu=$(cat /sys/devices/system/cpu/intel_pstate/min_perf_pct)
gpu=$(cat /sys/class/drm/card0/gt_min_freq_mhz)


if [ $cpu -ge 30 ]; then
   echo 12 > /sys/devices/system/cpu/intel_pstate/min_perf_pct
   if [ $? -eq 0 ]; then
      cpu_off=1
   fi

   echo 300 > /sys/class/drm/card0/gt_min_freq_mhz
   if [ $? -eq 0 ]; then
      gpu_off=1
   fi
   


   if [ $cpu_off -eq 1 ] || [ $gpu_off -eq 1 ]; then
      notify-send '(˘︶˘).｡*♡' 'See ya later'
   elif [ $cpu_off -eq 0 ] || [ $gpu_off -eq 0 ]; then
      notify-send 'Failed' 'CPU and GPU failed to set default'
   elif [ $cpu_off -eq 0 ]; then
      notify-send 'CPU failed' 'CPU failed to set 12%'
   elif [ $gpu_off -eq 0 ]; then
      notify-send 'GPU failed' 'CPU failed to set 300Hz'
   fi

else 
   echo 80 > /sys/devices/system/cpu/intel_pstate/min_perf_pct
   if [ $? -eq 0 ]; then
      cpu_off=2 
   fi


   echo 700 > /sys/class/drm/card0/gt_min_freq_mhz
   if [ $? -eq 0 ]; then
      gpu_off=2
   fi

     if [ $cpu_off -eq 2 ] || [ $gpu_off -eq 2 ]; then
      notify-send '｡◕‿◕｡' 'VAMOS'
   elif [ $cpu_off -eq 0 ] || [ $gpu_off -eq 0 ]; then
      notify-send 'Failed' 'CPU and GPU failed to set to high freq'
   elif [ $cpu_off -eq 0 ]; then
      notify-send 'CPU failed' 'CPU failed to set 80%'
   elif [ $gpu_off -eq 0 ]; then
      notify-send 'GPU failed' 'CPU failed to set 700Hz'
   fi

fi