#!/bin/bash
DATE=$(date +%Y-%m-%d)
BUCKET="asir-backups-pietro"
DATA_DIR="/home/ubuntu/docker/data"
BACKUP_FILE="/tmp/backup-$DATE.tar.gz"

tar -czf $BACKUP_FILE $DATA_DIR
aws s3 cp $BACKUP_FILE s3://$BUCKET/backups/$DATE/
rm $BACKUP_FILE

echo "Backup completado: $DATE"
