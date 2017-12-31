---
layout: post
title: "Alert! Alert!"
date: 2014-11-18 12:00
---

I built a little library to add UI notifications to any project.

You’ll need to compile the LESS CSS before use … I’ll eventually add a Gruntfile or something.

It’s very simple to use:

```javascript
    Alert.alert('info', 'A message', {timeout: 7000});
```

The last param is optional. If a timeout is given, the notification will disappear after the given number of milliseconds.

Nothing groundbreaking, but I was frustrated by the options out there that seem to over-complicate such a trivial thing.
