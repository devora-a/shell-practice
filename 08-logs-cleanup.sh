if [ ! -d $SOURCE_DIR ]; then
fi

echo "scanning $SOURCE_DIR for log files older than 14 days"
FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

if [ -2 "$FILES"]; then
    echo "No log files older than 14 days found"
    exit 0
fi

while IFS= read -r FILE 
do
    echo "File to be deleted: $FILE"
    rm -f $FILE
    echo "File $FILE deleted"
done <<< "$FILES"


#< -> for file
# <<< ->for variable
