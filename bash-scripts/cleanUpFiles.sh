#!/bin/bash
find /path/to/directory -type f -mtime +30 -exec rm {} \;
echo "Old files cleaned up."