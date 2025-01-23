log_dir="/path/to/logs"
max_size=1000000 # 1 MB
for file in $log_dir/*.log; do
log_size=$(stat -c %s "$file")
if [ $log_size -gt $max_size ]; then
mv "$file" "$file.old"
echo "Log file $file rotated."
fi
done