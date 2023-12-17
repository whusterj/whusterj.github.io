---
layout: post
title: "String Matching with Levenshtein Distance"
date: 2019-12-05 22:00
description:
category: blog
tags: python programming
---

Posted on Slack to the ThinkNimble team:

Hi all, I wanted to share an interesting problem and my solution. A couple weeks ago, we started a data migration for the Catalogue for Philanthropy. In short: they have a 15-year-old database with thousands of nonprofits and ALSO our new app database with the few hundred nonprofits that applied to be part of the Catalogue in 2019/2020.

Our goal is to import nonprofit data the old database, some of which is duplicated in the new database... This means checking for matches between over 400 nonprofits. Easy, but manual and time-consuming. We can't simply automate it, because (a) the old system itself has duplicate records and (b) nonprofit names do not match up exactly between the two systems. So for example the old system would have "A D Cherry Early Childhood Music Outreach Program Inc." while the new system has "AD Cherry Early Childhood Music Program". A human can tell that these are the same and match them up, but computers need some direction.

So I wrote a quick-and-dirty command-line script in Python that:

1. Computes the Levenshtein Distance (https://en.wikipedia.org/wiki/Levenshtein_distance) for each pair of nonprofit names. It sounds fancy, but I just had to install this package: https://pypi.org/project/python-Levenshtein/ to use the algorithm.
2. It then displays the top 10 matches by Levenshtein score (lower score means 'closer match', 0 means strings are identical)
3. It prompts the user to select the best match from the list (or "no match")
4. Generates two CSV files containing results as you go along: a 'matched' CSV and an 'unmatched' CSV

In this way, I was able to thoroughly cross-reference the two lists of >400 nonprofits in about 20 minutes with
a fair bit of confidence. Now when we import the legacy data into our new app, we have some assurance that there won't be too many (or any) duplicates.

Here's a video of the script in action:

<video controls>
  <source src="https://images.williamhuster.com/videos/cfp-matching-script.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

I know I talk about clean, maintainable code a lot, but sometimes messy throwaway code is the right choice, too. This is also a pattern I we can reuse for semi-manual extract-transfer-load (ETL) workflows for other clients in the future.

```python
#!/usr/bin/python
import csv
import Levenshtein


def main():
    """Suggest matches for each nonprofit, save user selections to file.

    The script outputs the user's selections to CSV as they go.

    Data Structures:
        selected_matches = [
            (legacy_id, legacy_name, new_id, nonprofit name, ),
            ...
        ]
    """
    old_nonprofits = get_old_nonprofits()
    new_nonprofits = get_new_nonprofits()

    selected_matches = []
    uncertain_matches = []

    matched_csv_filename = 'matched.csv'
    uncertain_csv_filename = 'unmatched.csv'

    # Loop over every new nonprofit
    for count, new_np in enumerate(new_nonprofits, start=1):
        print(f'Handling Nonprofit #{count} of {len(new_nonprofits)}...')

        """
        Brute-force Levenshtein check that generates this data structure:

            matches = [
                (score, legacy_id, legacy_name, new_id, new_name, ),
                ...
            ]
        """
        matches = []
        for old_np in old_nonprofits:
            matches.append((
                Levenshtein.distance(new_np[1], old_np[1]),
                old_np[0],
                old_np[1],
                new_np[0],
                new_np[1],
            ))

        # Sort matches by Levenshtein distance
        matches.sort(key=lambda x: x[0])

        # Get top ten matches
        top_matches = matches[:10]

        # List the top five matches from the legacy DB
        # and prompt the user to select the one that looks best.
        # The user can also indicate that they are not sure, which will
        # be placed in another list.
        done = False
        while not done:
            print('\n')
            print(f'Top matches for "{new_np[1]}":')
            for num, match in enumerate(top_matches, start=1):
                print(f'{num}. {str(match[0]).rjust(4)} | {str(match[1]).rjust(6)} | {match[2]}')
            print('11. Not Sure...')

            selection = int(input('Best Match? '))

            # Handle selection out of range.
            if 0 > selection > 11:
                print('Not a valid selection')
                continue

            # User is not certain
            elif selection == 11:
                with open(uncertain_csv_filename, 'a') as f:
                    writer = csv.writer(f)
                    writer.writerow(new_np)

            # User picked a match, append it to the list
            else:
                match = top_matches[selection - 1]
                with open(matched_csv_filename, 'a') as f:
                    writer = csv.writer(f)
                    writer.writerow(top_matches[selection - 1])

            done = True

#
# Nonprofit Data
#

def get_old_nonprofits():
    return [
        (71894,'YouthBuild Public Charter School',),
        (84003,'Youth Leadership Foundation ',),
        (1068,'Young Women\'s Project ',),
        (94231,'Young Playwrights\' Theater ',),
        # etc...
    ]

def get_new_nonprofits():
    return [
        ('6eeab870-c0f2-44a3-a280-e4687dd0a241','Abramson Scholarship Foundation',),
        ('0756f4f7-45af-4fe2-8f45-f8ea5d9db0ea','Academy of Hope Adult Public Charter School',),
        ('c7734b49-68f3-46bf-97e5-24de211bb33b','ACTS',),
        ('cf553241-eff4-426e-b714-f2eb799008aa','A D Cherry Early Childhood Music Outreach Program Inc.',),
        # etc...
    ]


if __name__ == "__main__":
    main()
```
