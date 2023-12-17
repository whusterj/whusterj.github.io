# whusterj.github.io

My website.

To set up a new dev environment, see: [See Installation.md](installation.md).

Then run:

```bash
jekyll serve
```

Github pages is integrated with Jekyll. It builds and deploys this site: [See documentation here](https://help.github.com/en/articles/about-github-pages-and-jekyll).

## Sync Images and Videos to R2

I use Cloudflare's R2 to host my images and videos at the subdomain images.williamhuster.com. I use [rclone](https://rclone.org/) to quickly sync

Sync from my R2 bucket to local, using `--interactive` or `-i` to confirm changes and avoid data loss:

```bash
rclone sync r2:blog-images local-blog-images-dir -i
```

When adding new files, sync from local up to R2:

```bash
rclone sync local-blog-images-dir r2:blog-images -i
```

## Extract Metadata from Photos

In early 2022 I added a 'photos' page and photos collection. To make this easier to manage and the information more interesting, I'm keeping the details in the image metadata and extracting it to the markdown frontmatter using exiftool.

To install the tool:

```bash
sudo apt install libimage-exiftool-perl
```

And use it to extract some basic image info that we can copy-paste into the markdown frontmatter:

```bash
exiftool *.jpg -S -Title -ImageWidth -ImageHeight -Make -Model -FNumber -ExposureTime -ISO -LensID -Keywords -DateTimeOriginal -d "%Y-%m-%d %H:%M:%S"
```

## Convert Photos to WebP

Install the CLI utility:

```bash
brew install webp
sudo apt-get install webp
```

Bulk compress some images to quality 75%. In my tests, this can reduce file size by as much as 50+% (from 190kb to 90kb).

```bash
find ./ -type f -name '*.jpg' -exec sh -c 'cwebp -q 75 "$1" -o "${1%.jpg}.webp"' _ {} \;
```

Lossless compression. The following command will give highest possible compression, and will take some time to run:

```bash
find ./ -type f -name '*.jpg' -exec sh -c 'cwebp -lossless -m 6 -z 9 -q 100 "$1" -o "${1%.jpg}.webp"' _ {} \;
```

In my tests, the above settings for lossless compression of JPGs actually INCREASED file size. This might work better for large lossless images, but since JPG itself is lossy, we're actually backtracking with this one.
