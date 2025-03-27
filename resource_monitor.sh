
while true; do
    cpu_usage=$(grep 'cpu' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}')
    mem_usage=$(free | awk '/Mem:/ {printf "%.2f", $3/$2 * 100}')

    echo "Cpu usage : $cpu_usage%"
    echo "memory usage: $mem_usage%"

    if awk "BEGIN {exit !($cpu_usage > 75.0 || $mem_usage > 75.0)}"; then
        echo "Resource usage high. Scaling to GCP..."
        ./scale_to_gcp.sh
    fi

    sleep 10
done
