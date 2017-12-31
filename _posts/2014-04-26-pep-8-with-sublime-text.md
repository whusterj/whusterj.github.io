---
layout: post
title: "PEP 8 Linting with SublimeText"
date: 2014-04-26 12:00
---

With Django, PEP 8 is the recommended set of style guidelines. You can commit these guidelines to memory, or you can find a “linter” for your text editor, and let it take care of remembering all the rules. Which option do you suppose is better? SublimeText 3 has a very convenient linter, **SublimeLinter 3** with a plug-in that instantly adds PEP 8 support. Here’s how to get up and running with PEP 8 linting in SublimeText right away.

## Install SublimeLinter 3 and SublimeLinter-pep8

First, make sure you have SublimeText 3 and SublimeText 3 Package Control installed (see those links for installation instructions).

Next, we’ll install the pep8 package, which includes the linter. install the pep8 package system-wide (that is, make sure you deactivate any active virtualenvs)

```bash
$ sudo pip install pep8
```

Now, open SublimeText 3, and:

1. Press **ctrl + shift + P** to open command prompt

2. Find **'Package Control: Install Package'** and click it

3. Search for **SublimeLinter** and click or press Enter to install

4. Repeat Steps 1 and 2 and this time search for **SublimeLinter-pep8**. Click or press Enter to install

Restart SublimeText and open a .py file. You should see red or yellow dots next to lines that violate PEP8. You should see thin red boxes around the exact area where the violation is occurring.

Click on a line with a red or yellow dot, and you will see an error description violation in the status bar at the bottom of the Sublime Text editor.

## Change Maximum Line Length to 100

By default, PEP 8 has a 79-character line width restriction. For the purposes of my projects, 100 characters is an acceptable line width. I personally find that the 79 character width forces illogical line breaks that often makes code harder, not easier, to read.

To override the default settings, open the SublimeLinter settings file:

Preferences > Package Settings > SublimeLinter > Default Settings

Then add the following inside of the “default” object:

```json
"linters": {
    "pep8": {
        "max-line-length": 100
    }
}
```
