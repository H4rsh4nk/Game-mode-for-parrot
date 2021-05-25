#!/bin/bash
echo "toor" | sudo -S chmod ugo+rwx /sys/devices/system/cpu/intel_pstate/min_perf_pct /sys/devices/system/cpu/intel_pstate/max_perf_pct /sys/class/drm/card0/gt_min_freq_mhz /sys/class/drm/card0/gt_max_freq_mhz

cpu_off=0
gpu_off=0
cpu=$(cat /sys/devices/system/cpu/intel_pstate/min_perf_pct)
gpu=$(cat /sys/class/drm/card0/gt_min_freq_mhz)

echo 12 > /sys/devices/system/cpu/intel_pstate/min_perf_pct
if [ $? -eq 0 ]; then
    cpu_off=1
fi

echo 20 > /sys/devices/system/cpu/intel_pstate/max_perf_pct
if [ $? -eq 0 ]; then
    cpu_off=1
fi

echo 300 > /sys/class/drm/card0/gt_min_freq_mhz
if [ $? -eq 0 ]; then
    gpu_off=1
fi

echo 300 > /sys/class/drm/card0/gt_max_freq_mhz
if [ $? -eq 0 ]; then
    gpu_off=1
fi



if [ $cpu_off -eq 1 ] || [ $gpu_off -eq 1 ]; then
    notify-send 'Battery Mode' 'Save electricity, save earth (˘︶˘).｡*♡ '
elif [ $cpu_off -eq 0 ] || [ $gpu_off -eq 0 ]; then
    notify-send 'Failed' 'CPU and GPU failed to set default'
elif [ $cpu_off -eq 0 ]; then
    notify-send 'CPU failed' 'CPU failed to set 12%'
elif [ $gpu_off -eq 0 ]; then
    notify-send 'GPU failed' 'CPU failed to set 300Hz'
fi