default:
    #! /bin/bash
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

push:
    #! /bin/bash
    git add .
    git commit -m "Update"
    remotes=$(git remote)
    for remote in $remotes; do
        git push $remote
    done

cloudflare_purge_cache url="http://williamhuster.com/":
    #! /bin/bash
    if [ -f ./.env ]; then
        source ./.env
    else
        echo "Warning: .env file not found. Ensure environment variables are set elsewhere."
    fi
    [ -n "${CLOUDFLARE_API_KEY}" ] || { echo "Error: CLOUDFLARE_API_KEY environment variable must be defined"; exit 1; }
    [ -n "${CLOUDFLARE_ZONE_ID}" ] || { echo "Error: CLOUDFLARE_ZONE_ID environment variable must be defined"; exit 1; }
    [ -n "${CLOUDFLARE_EMAIL}" ] || { echo "Error: CLOUDFLARE_EMAIL environment variable must be defined"; exit 1; }
    
    response=$(curl -s -X POST "https://api.cloudflare.com/client/v4/zones/${CLOUDFLARE_ZONE_ID}/purge_cache" \
        -H "X-Auth-Key: ${CLOUDFLARE_API_KEY}" \
        -H "X-Auth-Email: ${CLOUDFLARE_EMAIL}" \
        -H "Content-Type: application/json" \
        --data '{"files":["{{url}}"]}')
    
    if echo "$response" | grep -q '"success":false'; then
        echo "Error purging cache:"
        echo "$response" | grep -o '"errors":\[.*\]'
        exit 1
    fi
    
    echo "Purged {{url}} from Cloudflare cache"
    echo "--------------------------"
    echo "Cloudflare Cache Purge Complete"
    echo "--------------------------"