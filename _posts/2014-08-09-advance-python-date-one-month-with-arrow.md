---
layout: post
title: "Easily Advance a Python datetime.date by One Month with Arrow"
date: 2014-08-09 12:00
description: Here’s a nice one-liner using the Arrow library to advance a Python datetime.date object by one month.
category: blog
tags: python programming
---

Here’s a nice one-liner using the Arrow library to advance a Python datetime.date object by one month:

```python
>>> (arrow.get(<datetime object>).replace(months=1)).date()
```

Let’s break this apart to see what’s going on here:

```python
# First, 'get' creates an arrow object from the date object
>>> a = arrow.get(<datetime object>)

# This allows us to use arrow's replace() method to
# advance the date by one month. Note this is not a
# transform. It returns a new arrow object:
>>> a2 = a.replace(months=1)

# Note also that  you need to use 'months=#' (plural!)
# and not 'month=#' (singular!)
# The latter actually sets the month to the number provided,
# while the former adds or subtracts the given number

# Finally, we can get the date
>>> a2.date()
```

This is great because it takes care of edge cases like:

 * What date comes one month after Dec. 1, 2014? (Jan. 1, 2015)
 * What date comes one month after Jan. 31, 2014? (Feb. 28, 2014)

The second bullet above deserves special attention, because it may or may not be appropriate for your use case. For me, this was perfect because I wanted to reliably calculate the end of a one-month “service period” from a given start date. This needed to be a month based on ‘human logic,’ rather than a simple time delta.

Of course arrow’s replace() function enables you to manipulate dates a number of ways. [Check out the arrow docs for a complete reference.](https://arrow.readthedocs.io/en/latest/)
