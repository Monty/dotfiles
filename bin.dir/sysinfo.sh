#!/usr/bin/env bash

# Detect operating system
PLATFORM="$(uname -sm | tr ' ' '-')"

# Figure out OS independent details
machine_name="$(uname -n)"
kernel_version="$(uname -r)"

# Figure out OS dependent details - CPU and memory
#
case "$PLATFORM" in
Linux-*)
    CPU_BRAND="$(grep 'model name' /proc/cpuinfo | cut -f2 -d':' |
        sed 's/^[ \t]*//')"
    OS_INFO="Distro: $(grep DISTRIB_DESCRIPTION /etc/lsb-release | cut -f2 -d'=' | tr -d '"')"
    OS_NAME=''
    # Get the total amount of memory
    # use TotalMem: kB because Ubuntu doesn't have Mem: in Bytes
    totalMemKB=$(awk '/MemTotal:/{print($2);}' /proc/meminfo)
    totalMem=$((totalMemKB * 1024))
    # Figure out the max shared memory segment size
    shmmax=$(cat /proc/sys/kernel/shmmax)
    # Figure out the max shared memory
    shmall=$(cat /proc/sys/kernel/shmall)
    ;;
Darwin-*)
    CPU_BRAND="$(sysctl -n machdep.cpu.brand_string)"
    OS_INFO="$(system_profiler SPSoftwareDataType | grep 'System Version:' |
        sed 's/^[ \t]*//')"
    OS_NUMBER="$(system_profiler SPSoftwareDataType | grep 'System Version:' |
        sed 's/^.*OS //' | sed 's/X //' | sed 's/ .*//' | cut -f1,2 -d '.')"
    # Figure out the OS X name from the OS_NUMBER
    case $OS_NUMBER in
    10.0*) OS_NAME="Cheetah" ;;
    10.1) OS_NAME="Puma" ;;
    10.2*) OS_NAME="Jaguar" ;;
    10.3*) OS_NAME="Panther" ;;
    10.4*) OS_NAME="Tiger" ;;
    10.5*) OS_NAME="Leopard" ;;
    10.6*) OS_NAME="Snow Leopard" ;;
    10.7*) OS_NAME="Lion" ;;
    10.8*) OS_NAME="Mountain Lion" ;;
    10.9*) OS_NAME="Mavericks" ;;
    10.10*) OS_NAME="Yosemite" ;;
    10.11*) OS_NAME="El Capitan" ;;
    10.12*) OS_NAME="macOS Sierra" ;;
    10.13*) OS_NAME="macOS High Sierra" ;;
    10.14*) OS_NAME="macOS Mojave" ;;
    10.15*) OS_NAME="macOS Catalina" ;;
    10.16*) OS_NAME="macOS Big Sur" ;;
    11.*) OS_NAME="macOS Big Sur" ;;
    12.*) OS_NAME="macOS Monterey" ;;
    13.*) OS_NAME="macOS Ventura" ;;
    14.*) OS_NAME="macOS Sonoma" ;;
    15.*) OS_NAME="macOS Sequoia" ;;
    *) OS_NAME="macOS" ;;
    esac

    # Get the total amount of memory
    totalMem="$(sysctl hw.memsize | cut -f2 -d' ')"

    # Figure out the max shared memory segment size`
    shmmax="$(sysctl kern.sysv.shmmax | cut -f2 -d' ')"

    # Figure out the max shared memory
    shmall="$(sysctl kern.sysv.shmall | cut -f2 -d' ')"
    ;;
*)
    echo "[Error] This script only works on a Linux or Mac OS X machine"
    echo "The result from \"uname -sm\" is \"$(uname -sm)\""
    exit 1
    ;;
esac
totalMemMB=$((totalMem / 1048576))
shmmaxMB=$((shmmax / 1048576))
shmallMB=$((shmall / 256))

# Print current values
echo "System details for $machine_name"
echo "  $PLATFORM on an $CPU_BRAND"
echo "  Kernel version: $kernel_version"
echo "  $OS_INFO $OS_NAME"
echo "  Total memory available: $totalMemMB MB"
echo "  Max shared memory segment size: $shmmaxMB MB"
echo "  Max shared memory allowed: $shmallMB MB"
# Print disk info
df -Hl

# End of script
exit 0
