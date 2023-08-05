---
layout: post
title: I Support Your Dark Mode Preference
date: 2023-08-23 23:00
description: "I finally updated my blog (williamhuster.com) to respect the dark mode / light mode preferences of the user's browser. It was surprisingly easy!"
tags: programming css
readtime: 1 min
---

I personally prefer dark mode and have set that as my default theme on my computers and mobile phones.

Well, I finally updated this blog to respect - dear reader - _your_ dark mode / light mode preference, based on your browser configuration. It was surprisingly easy!

The first step is to add this meta tag to the `<head>` tag.

```html
<meta name="color-scheme" content="dark light" />
```

If you don't have any CSS, then that should "just work" in modern browsers.

In your CSS, you can do this to first check for dark/light mode support and then add custom style overrides for dark mode:

```css
@supports (color-scheme: dark light) {
  @media screen and (prefers-color-scheme: dark) {
    /* Dark theme styles go here */
  }
}
```

Depending on how much CSS you have, this could be hard...

With my blog, I'm shooting for 100% on Google Pagespeed insights, and so I'm trying to keep CSS to a minimum. My light mode styles are defined first as the default and then the `@supports` and `@media` queries override those styles as needed for dark mode.
