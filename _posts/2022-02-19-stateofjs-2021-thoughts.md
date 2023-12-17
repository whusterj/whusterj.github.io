---
layout: post
title: "State of JS 2021 Thoughts"
date: 2022-02-19 11:15
description: The 'State of JS' survey results are always an interesting and informative read - my observations and TILs.
category: blog
tags: javascript programming
image: https://images.williamhuster.com/posts/js2021-social.png
readtime: 5 min
---

The State of JS survey and results have been collected and published every year for the past 6 years or so. I have responded a few times, but not this year. Their design and data visualization skills are top-notch. It's always an interesting and informative read. I often refer to it when clients ask me why we are/are not using framework XYZ. That's JS-only, of course, but a quick Google can get you similar survey results for other topics.

The results this year seem to reflect my own impression of things from watching the ecosystem and talking to engineers.

## General Observations

**Respondents are primarily male, white, and age 24-34** (surprise, surprise).

**The majority of people came to the survey through Twitter.** I'm always struck by how Twitter has managed to stay relevant while other oldies like Facebook suffer. I've used it intermittently, but never got into it. Perhaps because I never found "my people" there.

**More than half of respondents are from companies with 100+ people**, but there's also good representation from companies of all sizes between 1 and 100.

**Clients always ask me about React vs. Vue. This year, React is still on top and Vue fell in popularity and usage** for the first time since appearing on the survey. My personal opinion is that this is because Vue 3 made some big changes that make it a bit harder to work with, and consequently sentiment is turning against it. I think it's also generally true that all frameworks start to decline after a few years anyway.

**Almost every framework that has appeared on the survey more than 2 times dipped in terms of satisfaction and usage.** This makes me think, you know, there hasn't been a major turnover in frameworks or tools for 4-6 years, since reactive frameworks "took over." Are we seeing any up-and-coming disruptors on the survey? Hard to say. I don't see any serious contenders on the frontend framework side except maybe Svelte. I'm a fan of Svelte - I used it in the very early days before even Vue was released! But I don't see any React-killing features in Svelte. Vue remains relevant, but I think we can say at this point it has definitively failed to take the throne. Aside, another engineer once dubbed me a hipster (_gasp_) for using Vue over React. I wonder if that opinion persists.

## Build Tools

The build tools side of things is more interesting. I think **[esbuild](https://github.com/evanw/esbuild)** could be a disruptor. Gulp has taken a major dive over the years (good riddance), and webpack remains on top, but is starting to take a turn. IMO, webpack was an improvement over all that came before, but it has ended up suffering the same issues as Gulp. It requires too much fiddling with configuration to get to _just right_. It's not accessible, and builds are v-e-r-y s-l-o-w.

I have been using esbuild on a side project and the speed is so incredible, I could see this paradigm of build tool taking over within a few years. The basic idea is that build tools can be made orders of magnitude faster by writing them in a fast language like Go. Vite is another contender here.

My use-case for esbuild is very simple, though. I'm just transpiling and bundling some ES6 modules. No typescript or frontend component stuff like JSX or Vue single-file components. I briefly looked into that configuration and the path ahead did seem a bit foggy, but I'm sure we'll see progress there.

I also always learn something new from the survey. This year, I learned about:

- **[The Browser WebAnimation API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Animations_API/Using_the_Web_Animations_API)** looks really simple and powerful. The API matches how CSS anims work.
- **tsc cli** - Just the command line tools for TypeScript. They have a very high satisfaction rating in the survey. I would like to spend some more time working with TypeScript.
- **[The Browser FileSystem API](https://developer.mozilla.org/en-US/docs/Web/API/FileSystem)** is something I've heard murmurings about. For security reasons, browsers haven't been able to write files, so this is a pretty big step. I wonder what interesting applications may already exist - writing to local sqlite databases perhaps?
- **[The Browser PageVisibility API](https://developer.mozilla.org/en-US/docs/Web/API/Page_Visibility_API)** - I didn't look at this closely, but made a mental note. This could be useful for lazy-loading or triggering animations. I could also see a use case for chat apps to mark on-screen messages as 'read' or 'viewed'.

## What's Up with WASM?

I'm also keeping an eye on WASM, which is also mentioned in the survey. I feel like it's often talked about, but very seldom used. I keep hearing that it's going to totally disrupt web development and bring in languages besides JavaScript to frontend development, but I haven't actually seen this happening.

One exception is Figma, which apparently owes its speed to a rendering engine powered by WASM, which was written by the CTO Evan Wallace. I think the source language is go. This same guy wrote esbuild - mad respect!

It seems to me that WASM may only make a difference at the "top tier" of web development where in-browser performance lends companies like Figma a real, competitive edge. I could see companies like Netflix and HBO investing in WASM to build slick, high-performance web interfaces for video. I could see Adobe and Microsoft porting their desktop software to the web through WASM engines - they are probably already doing this.

But your average web developer probably won't ever use WASM directly. They'll continue working in frameworks and, largely, JavaScript. BUT I do see a future where the framework handed to a web developer is _based_ on a WASM engine developed by a Big Tech. My crystal ball says that the next gen front end framework that will replace React and Vue will have a WASM engine underneath it. Developers won't have to learn new skills or tools to build on top of it, but it will blow away the performance and capabilities of today's pure-JS frameworks. One man's opinion.
