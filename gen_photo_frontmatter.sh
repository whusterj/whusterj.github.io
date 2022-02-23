#! /bin/bash
echo "---"
echo "layout: photo"
echo "image: $1"
echo "show: true"
echo "date: "
exiftool $1 -S -Title -ImageWidth -ImageHeight -Make -Model -FNumber -ExposureTime -ISO -LensID -Keywords -DateTimeOriginal -Description -d "%Y-%m-%d %H:%M:%S"
echo "---"