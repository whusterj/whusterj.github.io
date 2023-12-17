---
layout: post
title: "VueJS Radio Buttons, v-model, and the name Attribute"
date: 2018-01-23 12:30
description: I just ran into an annoying issue with the `name` attribute while using radio buttons with VueJS.
category: blog
tags: javascript programming vanillajs
readtime: 2 min
---

I just had an annoying problem with radio buttons in VueJS.

TL;DR: If you plan on using `v-model` with a group of radio buttons or checkboxes in VueJS, you should probably leave out the `name` attribute.

I'm working on a project where I have a Survey object containing a list of Question objects. The questions are in various formats, for example: multiple choice, scale value, open text, etc. Questions are rendered one at a time using different child components for each question format.

For scale value questions, I render a component that shows radio buttons 1-5, like this:

![Screenshot of radio buttons for a "scale value" question.]({{ "https://images.williamhuster.com/posts/2018-01-23-radio-buttons-vue.png" | absolute_url }})

The currently-selected answer (`question.answer`) is bound to the input like this:

```html
<input
  type="radio"
  :id="`q_${question.id}_5`"
  :name="`q_${question.id}`"
  v-model="question.answer"
/>
```

You'll notice that the `:id` and `:name` properties are also bound.

The `:id` attribute allows a clickable label to be linked to the input (using `for=` on the label).

Meanwhile, in plain HTML, the `name` property is used to group radio buttons and checkboxes together. ...I assumed that I would need the `:name` property to do the same in VueJS.

But, no!

## The Bug

The markup above worked fine when all of the questions were displayed at once. Clicking on a radio button marked the radio button and also updated the answer in the store object.

But when I updated my interface to render only one question at a time, the radio inputs stopped updating properly. For example, I'd answer `1` for question 1 and then go to question 2 and answer `2`, but when I'd go back to question 1, the radio button would not be checked anymore.[^1]

Through all this, the VueJS debugger reported that the data model was updating properly. The component was definitely updating everything else, so it was definitely just a rendering issue with checkbox.

## The Solution

After a lot of trial and error, I figured out that the problem was the `:name` attribute. I guess it conflicts with how Vue handles v-model on multiple radio buttons internally. Changing my mark-up to this fixed it:

```html
<input type="radio" :id="`q_${question.id}_5`" v-model="question.answer" />
```

I suppose this makes sense. If you bind the same model to multiple radio buttons, they _should_ be grouped together. I just didn't expect that VueJS would conflict with a feature of plain HTML.

---

_Notes_

[^1]: Even more infuriating, this behavior did not seem to be consistent. If I moved from a question with a lower-number answer like `3` to a question with an answer of `4`, then the checkbox would update properly. This behavior was super strange. I still don't know why this would be.
