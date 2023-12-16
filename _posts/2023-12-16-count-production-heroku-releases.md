---
layout: post
title: How to Use a Bash Script to Count Your Heroku Releases
date: 2023-12-16 11:30
description: "I asked ChatGPT to help me write a bash script to count the total number of production releases our company has made to Heroku."
tags: programming artificial-intelligence heroku
readtime: 6 min
---

Our Creative Director asked me if I could estimate the number of production releases we have pushed so we could bost about it on [our website](https://thinknimble.com). I quickly figured out a strategy that would work using just the `heroku apps` and `heroku releases` commands, but realized I would need to draft a script to iterate and parse the outputs. I also knew it would be best to do this in bash to make use of those heroku-cli commands.

I'm ashamed to say my bash is not strong, so I turned to ChatGPT 3.5 for help. Here's a trimmed version of the exchange with ChatGPT.

> **Me:** Please write a bash script that helps me count how total production releases to Heroku. Procedure:
>
> 1. Calls `heroku apps -A` to list my Heroku apps
> 2. Finds all apps whose names contain the substring 'prod'
> 3. For each app in #2, calls `heroku releases -a {app_name}`
> 4. Sums all the latest version numbers to get a total number of production releases

**ChatGPT** was pretty close on the first try. The overall structure of the script was correct, but it was not correctly parsing the latest release from the output of the `heroku releases` command. This was the command it drafted:

```bash
releases=$(heroku releases -a "$app" | grep -E '^[0-9]+' | head -n 1 | awk '{print $1}')
```

This is very close, but it won't yield any matches, because the regex used for `grep` is matching digits 0-9, but the release numbers are prefixed with a `v`, e.g. `v55`. The correct regex is therefore: `'^v[0-9]+'`. The variable name `releases` is also not entirely accurate and may indicate a "misunderstanding" of the goal. We'd like this line to give us just the latest release number. That said, the command is using `head -n 1` to get the latest release. So I decided to give ChatGPT an example of the output to see if it could correct the error.

> **Me:** This is close. There is just an issue parsing the latest release number from the result of the `heroku releases` command. Here is an example result:
>
> ```
> v88  Deploy b5e486a4                       dev@thinknimble.com  2023/12/15 03:33:29 -0500 (~ 12h ago)
> v87  Set REDIS_URL config vars             dev@thinknimble.com  2023/12/15 03:11:25 -0500 (~ 12h ago)
> v86  Deploy eb10b67c                       dev@thinknimble.com  2023/12/15 02:48:50 -0500 (~ 13h ago)
> v85  Deploy 2ced23ee                       dev@thinknimble.com  2023/12/15 00:41:51 -0500 (~ 15h ago)
> v84  Deploy 1f24c745                       dev@thinknimble.com  2023/12/13 02:29:13 -0500
> v83  Deploy 58c7705c                       dev@thinknimble.com  2023/12/13 02:08:38 -0500
> v82  Deploy 8b80ec50                       dev@thinknimble.com  2023/12/12 21:19:02 -0500
> v81  Deploy bb148408                       dev@thinknimble.com  2023/12/12 19:51:02 -0500
> v80  Set USE_REDIS config vars             dev@thinknimble.com  2023/12/12 18:47:41 -0500
> v79  Set REDIS_URL config vars             dev@thinknimble.com  2023/12/12 18:47:33 -0500
> v78  Set REDIS_URL config vars             dev@thinknimble.com  2023/12/12 18:44:43 -0500
> v77  Set REDIS_URL config vars             dev@thinknimble.com  2023/12/12 18:36:27 -0500
> v76  Update NEW_RELIC by newrelic          dev@thinknimble.com  2023/12/12 10:44:14 -0500
> v75  Set AWS_S3_SECURE_URLS config vars    dev@thinknimble.com  2023/12/10 17:29:48 -0500
> v74  Set AWS_S3_CUSTOM_DOMAIN config vars  dev@thinknimble.com  2023/12/10 17:29:32 -0500
> ```
>
> So in this case, we want to parse out the number 88 and add that to `total_releases`. Can you regenerate the script with that in mind?

**ChatGPT** then regenerated the script and changed the line. This time the regex is correct, but we have a regression. For some reason, ChatGPT removed the `head -n 1` step. So this will give us a list of the release numbers of all releases in the output. I think it may have done this because I gave it a list of outputs above, instead of a single line.

```bash
latest_version=$(heroku releases -a "$app" | grep -E '^v[0-9]+' | awk '{print $1}' | sed 's/v//')
```

One more nudge from me set this right:

> **Me:** Not quite. Instead of one `latest_version` this is giving me a list of all the versions. Try again?

And **ChatGPT** corrected the line. Now the variable name `latest_version` is good and we are getting a single release number to add to `total_releases`. Nice!

```bash
latest_version=$(heroku releases -a "$app" | grep -E '^v[0-9]+' | sort -rV | head -n 1 | awk '{print $1}' | sed 's/v//')
```

## The Final Script

Here is the final script mainly authored by ChatGPT that will get a list of all production Heroku apps you have access to and sum up their latest release versions to give you a total number of all-time production deployments.

In our case, the number of total production releases is over 2000! And that doesn't even include apps on AWS or those we have shut down and transferred away to clients. So I'd guess out team has probably pushed to prod almost 5000 times over the past five years. A vanity metric, perhaps, but it's still cool to think about.

```bash
#!/bin/bash

# Step 1: List Heroku apps
apps=$(heroku apps -A)

# Step 2: Find apps with names containing 'prod'
prod_apps=$(echo "$apps" | grep 'prod' | awk '{print $1}')

# Step 3 and 4: Iterate over prod apps and get total releases
total_releases=0
for app in $prod_apps; do
    latest_version=$(heroku releases -a "$app" | grep -E '^v[0-9]+' | sort -rV | head -n 1 | awk '{print $1}' | sed 's/v//')
    if [ -n "$latest_version" ]; then
        total_releases=$((total_releases + latest_version))
        echo "App $app has version v$latest_version as the latest production release."
    else
        echo "No production releases found for app $app."
    fi
done

echo "Total production releases: $total_releases"
```
