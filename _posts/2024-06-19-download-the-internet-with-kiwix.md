---
layout: post
title: Download the Internet with Kiwix
date: 2024-06-19 18:00
description: Did you know that you can download all of Wikipedia and tens of thousands of books from Project Gutenberg? Here's how.
image: /static/images/posts/2024-06-19-kiwix/kiwix-internet-offline.png
tags:
  - prepping
  - life
readtime: 5 min
---

I've always been a bit of a data hoarder. Ever since I heard of [Kiwix](https://kiwix.org/) - a tool for "downloading the internet" - I've been meaning to try it out.

If you want to skip the explanation, here is my code on GitHub:

[github.com/whusterj/kiwix-torrent-watcher](https://github.com/whusterj/kiwix-torrent-watcher)

## How it Works

With Kiwix, you first download entire sites like Wikipedia as a [ZIM](<https://en.wikipedia.org/wiki/ZIM_(file_format)>) file. Kiwix is the software you use to browse these files offline.

What a great idea and right up my alley. But at first I was confused. I didn't know _where_ I could reliably find ZIM files. I searched around for a directory, and found this.

[download.kiwix.org/zim/](https://download.kiwix.org/zim/)

Browsing the directory, you can see that there are a lot of options for each archive. The wikipedia directory contains _hundreds_ of ZIMs. Looking closer, you see that they follow a naming convention of `source_languageCode_contentType_date`. Once you know how to intepret this, you can find what you're looking for - though I admit it's not entirely straightforward.

In my case, I wanted it all. Well OK, not all. I specifically wanted the most complete archive of Wikipedia in English. Turns out that this file is prefixed `wikipedia_en_all_maxi` and is about 102GB as of this writing.

## A Script to Get the Latest Archives

In the listing you can see that archives are not updated very frequently. New Wikipedia archives seem to appear every few months. It's unlikely that I will remember to check on this and go through all the motions to get the latest archive.

I decided to write a script that I could set up as a cron job on my server. It would check the listings, find newer archives, and automatically download them.

Turns out, someone else had the same idea! I found this script by [Adrien Andre on GitLab](https://gitlab.com/adrienandrem/kiwix-torrent-watcher). All due respect to Adrien, I had some issues when I tried to run it, but it was a great starting point for me. In my copy, I've made some changes to improve the reliability and accuracy of the script. Overall, it works the same way.

First, you define the listings you want in a file called `zim.lib`. Mine looks like this:

```plaintext
wikibooks_en_all_maxi
wikipedia_en_all_maxi
freecodecamp_en_javascript
gutenberg_en_all
```

I've listed the prefixes for the archives that I want _without the date_. The script takes care of finding the most recent archive by date.

The script has the following parts:

1. The entry point is Python `__main__.py`
2. This invokes a bash script that reads the file listings from https://download.kiwix.org/zim/. The listings are also cached for a time in a local .txt file.
3. The listings are compared to our local `zim.lib` file to identify new archives we don't have.
4. New archives are queued up for torrenting using [Transmission](https://transmissionbt.com/), which runs headlessly on the server

Very simple.

## Usage

First, you want to make sure Transmission is installed and running on your server. I've tested this only on Ubuntu 22.04, and there are instructions here: [help.ubuntu.com/community/TransmissionHowTo](https://help.ubuntu.com/community/TransmissionHowTo)

Next, clone the repo and `cd` into it:

```bash
git clone git@github.com:whusterj/kiwix-torrent-watcher.git
cd kiwix-torrent-watcher
```

Install the Python depedencies:

```python
# Create a virtual environment
python -m venv .venv

# Activate
source .venv/bin/activate

# Install Python dependencies
python -m pip install -r requirements.txt
```

Run it - replace `/data/documents/kiwix/` with the directory where you want your

```python
LOGLEVEL=DEBUG python __main__.py zim.lib /data/documents/kiwix/
```

`LOGLEVEL=DEBUG` is optional, but I recommend using it the first few times to follow what is happening in the script.

## Set Up a Cron Job

From here you could set up a cron job like so:

1. Edit your cron table.

```bash
crontab -e
```

2. Install this cron job to run every day at 3AM:

```bash
0 3 * * * /bin/bash -c 'source /path/to/kiwix-torrent-watcher/.venv/bin/activate && python /path/to/kiwix-torrent-watcher/__main__.py zim.lib /data/documents/kiwix/' >> /path/to/log/kiwix-torrent-watcher.log 2>&1
```

Double check that all the paths work for your system. Cron jobs can sometimes be tricky to get right and to test. I recommend trying to run the command without the `0 3 * * *` prefix to debug it.
