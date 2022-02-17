---
layout: post
title: "Python Code Style Linting with SublimeText"
date: 2014-04-26 12:00
description: PEP 8 sets out some style guidelines for Python. Rather than commit these to memory, use a linter! Here's how to do it in SublimeText.
category: blog
tags: python programming tools
readtime: 2 min
---

_UPDATE: Jan 26, 2018: This post previously used the pep8 package and SublimeLinter-pep8, but both were renamed at the recommendation of Guido van Rossum (yes, the creator of Python himself). [The discussion thread on Github](https://github.com/PyCQA/pycodestyle/issues/466) about PEP8 and the name of the linting tool is a fascinating example of the Python community at work._

For Django (and Python generally) PEP 8 lays out a number of useful style guidelines. You can commit these guidelines to memory, or you can find a “linter” for your text editor, and let it take care of remembering all the rules. Which option do you suppose is better? SublimeText 3 has a very convenient linter, **SublimeLinter 3** with a plug-in that instantly adds PEP 8 support. Here’s how to get up and running with PEP 8 linting in SublimeText right away.

## Install SublimeLinter 3 and SublimeLinter-pycodestyle

First, make sure you have SublimeText 3 and SublimeText 3 Package Control installed (see those links for installation instructions).

Next, we’ll install the pycodestyle package, which includes the linter. install the package system-wide (that is, make sure you deactivate any active virtualenvs)

```bash
$ sudo pip install pycodestyle
```

Now, open SublimeText 3, and:

1. Press **ctrl + shift + P** to open command prompt

2. Find **'Package Control: Install Package'** and click it

3. Search for **SublimeLinter** and click or press Enter to install

4. Repeat Steps 1 and 2 and this time search for **SublimeLinter-pycodestyle**. Click or press Enter to install

Restart SublimeText and open a .py file. You should see red or yellow dots next to lines that violate the style guidelines. You should see thin red boxes around the exact area where the violation is occurring.

Click on a line with a red or yellow dot, and you will see an error description violation in the status bar at the bottom of the Sublime Text editor.

## Change Maximum Line Length to 100

By default, PEP 8 has a 79-character line width restriction. For the purposes of my projects, 100 characters is an acceptable line width. I personally find that the 79 character width forces illogical line breaks that often makes code harder, not easier, to read.

To override the default settings, open the SublimeLinter settings file:

Preferences > Package Settings > SublimeLinter > Settings

Then add the following inside of the “default” object:

```json
"linters": {
    "pycodestyle": {
        "max-line-length": 100
    }
}
```
