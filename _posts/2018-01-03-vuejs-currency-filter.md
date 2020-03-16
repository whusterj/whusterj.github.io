---
layout: post
title: "A Simple VueJS Currency Filter"
date: 2018-01-03 2:34
description: Unlike other front-end frameworks, VueJS does not provide any filters out of the box. Here's what to do if you need to display formatted currency amounts in your Vue project.
category: blog
tags: javascript programming vuejs
---

Displaying formatted currency amounts is a common requirement of web apps, but VueJS does not provide any filters out of the box. So here’s what you can do if you need to add a currency filter to your Vue project.

First, you'll need to know about VueJS filters and how they work. Read more here: https://vuejs.org/v2/guide/filters.html

## Using the currency-formatter NPM Package

If you are using webpack or a similar build tool and have access to node.js packages, then you can install the currency-formatter package from npm. By the way, I highly recommend using the [Vue CLI](https://cli.vuejs.org/) for your projects.

```bash
npm install currency-formatter --save
```

Then you can create a VueJS filter in your app code like so:

```javascript
import Vue from 'vue'
import currencyFormatter from 'currency-formatter'

Vue.filter('currency', formatNumberAsUSD)

function formatNumberAsUSD (value) {
  if (!value) return ''
  value = Number(value)
  return currencyFormatter.format(value, { code: 'USD' })
}
```

`Vue.filter` registers a new global Vue filter called 'currency' and `formatNumberAsUSD` function does the work. The formatting function does three things, it (a) makes sure it has a truthy value and returns a blank string if not, (b) attempts to convert the value to a `Number`, and (c) uses `currencyFormatter.format` to format the number as USD.

## Using Number.prototype.toLocaleString()

If you are not using a build tool with access to node.js packages, or you mistrust external dependencies, you might try using the Number.toLocalString() method below or [take a peek at currency-formatter source code on Github](https://github.com/smirzaei/currency-formatter/blob/master/index.js) and borrow from it. Note that while this is supported in modern browsers, it may not be available in older browsers you might need to target.

```javascript
import Vue from 'vue'
import currencyFormatter from 'currency-formatter'

Vue.filter('currency', formatNumberAsUSD)

function formatNumberAsUSD (value) {
  if (!value) return ''
  return Number(value).toLocaleString('en', {
    style: 'currency', currency: 'USD'
  })
}
```

Both `toLocaleString` and the currency-formatter package can handle currencies besides USD, too. [Check out the currency-formatter npm page](https://www.npmjs.com/package/currency-formatter) for more details.

## Summary

No matter the approach you chose, you have now created a 'currency' filter that you can use in your VueJS templates like this:

```vue
<template>
  <span>{{ 12 | currency }}</span>
</template>
```

And the output should look like this:

```text
$12.00
```

Excellent!