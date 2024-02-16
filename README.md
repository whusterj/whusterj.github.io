# whusterj.github.io

My website.

To set up a new dev environment, see: [See Installation.md](installation.md).

Then run:

```bash
jekyll serve
```

Github pages is integrated with Jekyll. It builds and deploys this site: [See documentation here](https://help.github.com/en/articles/about-github-pages-and-jekyll).

## Extract Metadata from Photos

Short version: use `gen_photo_frontmatter.sh`

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

## Sync Images and Videos to R2

NO LONGER USED, FOR REFERENCE ONLY: I experimented with using Cloudflare's R2 to host my images. Unfortunately my analytics showed a big spike in latency to serve these images from the R2 bucket.

### Use a CDN?

It would be better to serve images from a CDN. I researched different solutions and the frontrunner for me was Cloudflare Images. This costs $5/month for up to 100K images. Features include auto-generated variants, which is attractive.

The big drawback is that I would somehow need to automate the image upload process. CF Images generates a UUID for each image by default. You can also specify a "custom key." I would just use the filename to make it easier to identify.

For now (2024-02-16) I've decided to move back to GitHub for image hosting. I only have ~50MB of media so far, and GitHub seems to put media on its user content CDN. Most of all, it is free to use!

### Back Up Images to R2

R2 is free with my Cloudflare account and a good backup solution I think, in case I ever need to migrate from GH Pages.

Here are instructions to sync this repo's images to and from R2:

Media can be served from the subdomain images.williamhuster.com. I used [rclone](https://rclone.org/) to quickly sync

If it's the first time on this computer, then follow the [rclone configuration steps for R2](https://rclone.org/s3/#cloudflare-r2).

Sync from my R2 bucket to local, using `--interactive` or `-i` to confirm changes and avoid data loss:

```bash
rclone sync r2:blog-images static/images -i
```

When adding new files, sync from local up to R2:

```bash
rclone sync static/images r2:blog-images -i
```
