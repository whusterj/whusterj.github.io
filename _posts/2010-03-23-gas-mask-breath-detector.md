---
layout: post
title: "Gas Mask Breath Detector"
date: 2010-03-23 11:06
description: "Sharing progress on a new interactive media piece I'm working on."
category: blog
tags: digital-art
---

One of the main reasons I started this blog was to assist in my artistic process as well as to encourage myself to document my artwork better. To that end, I'd like to share some of my progress on a new piece that I'm working on in the vein of interactive media. Here is a sketch:

![Sketch for the Gas Mask](/static/images/posts/gas-mask/mask.jpg "Gas Mask art concept sketch")

OK, so this requires some explanation: the gas mask will have one or two embedded piezo vibration sensors connected via conductive thread to a lilypad arduino on the strap on the back. I've built a prototype already from a dust mask, a little wooden frame, and some electrical tape. So far the test model works beautifully. With no breath, the arduino returns values flickering around 150 with a margin of +-40. Exhaling, the arduino returns values up to about 1200, and inhaling drops the value to 0.

In this way, it's possible to detect the wearer's breath and even to differentiate between exhales and inhales. The device is remarkably sensitive, and is in fact more receptive to subtle breaths than it is powerful gusty breaths. I think this may in part be due to the thermal sensitivity of the piezo transducer. When exhaling calmly, the heat from one's breath excites the transducer material, causing it to deform slightly and produce voltage. When inhaling, heat is sucked away from the transducer, reducing the voltage. When exhaling strongly, the warmth of the breath is counterbalanced by the speed of the air passing over the sensor, producing only small, random changes in voltage. This is just my untested theory, though. Anyone with more insight on this subject should definitely contact me! The way it works right now is just fine for my purposes and gives me a lot of possibilities to play around with.

I'm considering several possibilities for my gas mask breath detector, among them: gallery installation, performance with sound and projection, and a 3D art game (where the object of the game is to keep breathing). Ultimately, I want the wearer of the gas mask to be very (perhaps even uncomfortably) aware of their breathing and the fact that they need to breath and need air to survive.

Here are some images of the prototype in progress:

![Gas Mask - In Progress Image 1](/static/images/posts/gas-mask/wip01.jpg "Gas mask - work in progress image 1")

![Gas Mask - In Progress Image 2](/static/images/posts/gas-mask/wip02.jpg "Gas mask - work in progress image 2")

![Gas Mask - In Progress Image 3](/static/images/posts/gas-mask/wip03.jpg "Gas mask - work in progress image 3")

![Gas Mask - In Progress Image 4](/static/images/posts/gas-mask/wip04.jpg "Gas mask - work in progress image 4")

![Gas Mask - In Progress Image 5](/static/images/posts/gas-mask/wip05.jpg "Gas mask - work in progress image 5")
