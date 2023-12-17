---
layout: post
title: How I extract Metadata from Photos for My Blog
date: 2022-03-07 12:00
description: "This is how I use exiftool to extract the metadata from my photos to markdown."
tags: photography
readtime: 4 min
---

In early 2022 I added [a new 'photos' page](/photos) to my blog to show off some of my amateur photography. My blog is a static site generated using [Jekyll](https://jekyllrb.com/) and Github Pages. The photos page is generated from a custom collection of "posts." These posts are all frontmatter without content.

For example, here's the frontmatter for my "kindly frog" image:

```text
---
layout: photo
image: https://images.williamhuster.com/photos/DSC_5408-1200px
show: true
Title: This frog let us sit on his rock
Description: A kindly frog sat by, doffed his cap and said, "hi!"
ImageWidth: 1200
ImageHeight: 795
Make: NIKON CORPORATION
Model: NIKON D5100
FNumber: 5.3
ExposureTime: 1/250
ISO: 200
LensID: AF-S DX VR Zoom-Nikkor 18-55mm f/3.5-5.6G
Keywords: personal, vacation
DateTimeOriginal: 2021-06-30 00:08:41
date: 2021-06-30 00:08:41
---
```

You'll notice a lot of metadata in there that would be tedious to type by hand - and that's why I'm not doing it by hand!

To make it easy to manage, I'm keeping all of the details in the image metadata, including the image title and description. I edit these using Lightroom, and I like that it's all contained within the image, rather than a "sidecar" XML file.

When I want to publish a particular image to my site, I extract the image metadata using exiftool, an old-but-great Perl tool for interacting with the EXIF-standard metadata stored in JPEGs and other image file formats.

Here's how I install exiftool on Ubuntu:

```bash
sudo apt install libimage-exiftool-perl
```

And here's how I use it to extract some image info that we can copy-paste into the markdown frontmatter:

```bash
exiftool *.jpg -S -Title -ImageWidth -ImageHeight -Make -Model -FNumber -ExposureTime -ISO -LensID -Keywords -DateTimeOriginal -d "%Y-%m-%d %H:%M:%S"
```

The `-S` option is key to making this work with Markdown frontmatter, because it gives me the metadata in a colon-delimited format that exactly matches what Markdown expects. The other options select particular fields of interest from the EXIF data. Finally, the `-d` option specifies an ISO 8601 date format, which is an ideal standard for this blog (and everywhere, IMO).
