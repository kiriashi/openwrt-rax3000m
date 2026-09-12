show_banner() {
    line="---------------------------------------"
    load=$(awk '{print $3}' /proc/loadavg)
    avail_kb=$(awk '/MemAvailable:/ {print $2}' /proc/meminfo)
    mem_free_mb=$((avail_kb / 1024))
    temp=$(awk '{printf("%.0f°C",$1/1000)}' /sys/class/thermal/thermal_zone0/temp 2>/dev/null)
    s=$(cut -d. -f1 /proc/uptime)
    d=$((s/86400))
    h=$((s%86400/3600))
    m=$((s%3600/60))
    if [ "$d" -gt 0 ]; then
      uptime_str="${d}天${h}小时${m}分钟"
    elif [ "$h" -gt 0 ]; then
      uptime_str="${h}小时${m}分钟"
    else
      uptime_str="${m} 分钟"
    fi

    echo "$line"
    printf "系统负载: %-7s 空闲内存: %4d MB\n" "$load" "$mem_free_mb"
    printf "设备温度: %-8s 运行时间:  %s\n" "$temp" "$uptime_str"
    echo "$line"
}
show_banner