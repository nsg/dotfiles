#!/bin/bash

set -eu -o pipefail

send_data() {
    local sensor="$1"
    local value="$2"
    local to_send="nsg.$HOSTNAME.$sensor $value $(date +%s)"

    #echo $to_send
    echo $to_send | nc -q0 grafana.stacken.kth.se 2003
}

using_nvidia() {
  prime-select query | grep -q nvidia
}

read_sensors() {
    local coretemp=$(($(cat $SENSOR_CORETEMP) / 1000 ))
    local acpitz=$(($(cat $SENSOR_ACPITZ) / 1000 ))
    local iwlwifi=$(($(cat $SENSOR_IWLWIFI) / 1000 ))
    local pch=$(($(cat $SENSOR_PCH) / 1000 ))
    local nvme=$(nvme smart-log $NVME_DISK | awk '/^temperature/{ print $3 }')

    local fan=($(awk '{ print $2 }' /proc/acpi/ibm/fan))
    local cpu_mhz=($(awk '/^cpu MHz/{ print $NF }' /proc/cpuinfo))

    send_data fan ${fan[1]}
    send_data coretemp $coretemp
    send_data acpitz $acpitz
    send_data iwlwifi $iwlwifi
    send_data pch $pch
    send_data nvme $nvme
    for n in 0 1 2 3 4 5 6 7; do
        send_data cpu-$n ${cpu_mhz[$n]}
    done

    if using_nvidia; then
      local nvidia_coretemp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)
      send_data nvidia $nvidia_coretemp
    fi
}

for sensor in $(find /sys/devices -type f -name "temp*_input"); do
    path="${sensor%/*}"
    name="$(cat "$path/name")"

    case $name in
        coretemp)
          SENSOR_CORETEMP="$sensor"
          ;;
        acpitz)
          SENSOR_ACPITZ="$sensor"
          ;;
        iwlwifi)
          SENSOR_IWLWIFI="$sensor"
          ;;
        pch_*)
          SENSOR_PCH="$sensor"
          ;;
    esac
done

NVME_DISK="/dev/nvme0n1"

while [ 1 ]; do
    read_sensors 1
    sleep 10
done
