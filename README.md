# whusterj.github.io

My website.

To set up a new dev environment, see: [See Installation.md](installation.md).

Then run:

```bash
jekyll serve
```

Github pages is integrated with Jekyll. It builds and deploys this site: [See documentation here](https://help.github.com/en/articles/about-github-pages-and-jekyll).

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
