default:
    #!/bin/bash
    echo "--------------------------"
    echo "WilliamHuster.com Justfile"
    echo "--------------------------"
    just --list

gen_photo_frontmatter photo:
    #! /bin/bash
    echo "---"
    echo "layout: photo"
    echo "image: {{photo}}"
    echo "show: true"
    echo "date: "
    exiftool {{photo}} -S -Title -ImageWidth -ImageHeight -Make -Model -FNumber -ExposureTime -ISO -LensID -Keywords -DateTimeOriginal -Description -d "%Y-%m-%d %H:%M:%S"
    echo "---"

run:
    jekyll serve --port 4001

hash_css:
    #! /bin/bash
    md5 static/css/style.css
    echo "^ Paste into header of default.html"
