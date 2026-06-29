#!bin/bash

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14}

if [ -z  "$SOURCE_DIR" ] || [ -z "$DEST_DIR" ]; then
   echo "Either source directory or destination directory empty"
   echo "USAGE:: $0 [source_dir] [dest_dir] [days: default +14]"
   exit 1
fi

if [ ! -d "$SOURCE_DIR" ]; then
   echo "source directory: $SOURCE_DIR doest not exist"
   exit 1
fi

if [ ! -d "$DEST_DIR" ]; then
   echo "destation directory: $DEST_DIR doest not exit"
   exit 1
fi

FILES=$( find "$SOURCE_DIR" -type f -name "*.log" -mtime  +$DAYS )

if [ -z "$FILES" ]; then
   echo "Logs files older then 14 days not found nothing to do"
   exit 0
fi

while IFS= read -r FILES
do  
  echo "$FILES"
done <<< "$FILES"
 
TIMESTAMP=$(date +%y-%m-%d-%H-%M-%S)
ARCHIEVE_FILE="$DEST_DIR/logs-archieve-$TIMESTAMP.tar.gz"

tar -czvf $AECHIEVE_FILE $FILES


