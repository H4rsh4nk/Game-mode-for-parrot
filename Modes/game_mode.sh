#!/bin/bash
echo "toor" | sudo -S chmod ugo+rwx /sys/devices/system/cpu/intel_pstate/min_perf_pct /sys/devices/system/cpu/intel_pstate/max_perf_pct /sys/class/drm/card0/gt_min_freq_mhz /sys/class/drm/card0/gt_max_freq_mhz

cpu_off=0
gpu_off=0
cpu=$(cat /sys/devices/system/cpu/intel_pstate/min_perf_pct)
gpu=$(cat /sys/class/drm/card0/gt_min_freq_mhz)

echo 80 > /sys/devices/system/cpu/intel_pstate/min_perf_pct
if [ $? -eq 0 ]; then
    cpu_off=2 
fi

echo 100 > /sys/devices/system/cpu/intel_pstate/max_perf_pct
if [ $? -eq 0 ]; then
    cpu_off=2
fi


echo 700 > /sys/class/drm/card0/gt_min_freq_mhz
if [ $? -eq 0 ]; then
    gpu_off=2
fi


echo 1050 > /sys/class/drm/card0/gt_max_freq_mhz
if [ $? -eq 0 ]; then
    gpu_off=2
fi


    if [ $cpu_off -eq 2 ] || [ $gpu_off -eq 2 ]; then
    notify-send 'Game mode' 'VAMOS ｡◕‿◕｡'
elif [ $cpu_off -eq 0 ] || [ $gpu_off -eq 0 ]; then
    notify-send 'Failed' 'CPU and GPU failed to set to high freq'
elif [ $cpu_off -eq 0 ]; then
    notify-send 'CPU failed' 'CPU failed to set 80%'
elif [ $gpu_off -eq 0 ]; then
    notify-send 'GPU failed' 'CPU failed to set 700Hz'
fi

