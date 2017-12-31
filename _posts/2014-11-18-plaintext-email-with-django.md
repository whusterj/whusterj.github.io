---
layout: post
title: "Writing Plain Text Templates for Email in Django"
date: 2014-11-18 12:00
categories: development django
---

Short answer: **don’t**. Managing whitespace in plain text templates is a headache-and-a-half….

God forbid you want to add some if statements or for loops! Suddenly you have a steamy, tangled mess on your hands.

Writing and maintaining templates in non-whitespace-sensitive HTML is faaar more sane. So my advice: write your template in HTML, render it to a string, and then use the html2text library to convert the rendered HTML to plaintext.

[**Check out html2text on github**](https://github.com/aaronsw/html2text)

html2text actually renders the result as markdown, which applies pretty sensible and readable formatting, even for non-technical recipients.

Ideally, of course, you should be sending HTML in almost every case anyway. But you still always need plain text as a fallback. Well, now you have an easy way to generate that fallback – without any need to maintain both an HTML and plain text template.

[Here’s a gist to show how it’s done:](https://gist.github.com/whusterj/1cb3a25bd5afed57a902)
