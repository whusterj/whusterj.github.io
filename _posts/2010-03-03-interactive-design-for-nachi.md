---
layout: post
title: "Interactive Design for 'Nachi'"
date: 2010-03-03 01:07
description: "In December 2009, I collaborated with digital artist Arthur Liou on the interactive design for his piece 'Nachi'."
category: blog
tags: digital-art
---

In December 2009, [Arthur Liou](https://www.arthurliou.net/) approached me about the design of an interactive component for his projection piece "Nachi," which is being shown at the Poissant gallery in Houston, Texas this month. He is in Houston this week setting up. You can see my portfolio for more details. "Nachi" is a high-definition "moving photograph" of a waterfall, and is part of a series of waterfall videos that Arthur shot in Japan last summer.

To accompany the video, Arthur had some specific sound effects in mind. The first was the powerful rush of water down the hillside, which Arthur wanted to fade in as the viewer came approached his work. Just yesterday morning, I helped Arthur load the huge sub-woofer, which will be booming that sound, into his Enterprise Rent-A-Van. Arthur also wanted the sound of wet footsteps to be roughly synchronized with the viewers' motions in the gallery. We initially explored the possibility of using vibration sensors on the floor to detect actual footsteps, but this proved impractical. In the end, we settled on infrared (PIR) sensors, which, besides being fairly cheap, also faithfully track general motion in the gallery. These are the same kinds of sensors used in professional security systems, and now I know why! They are very effective and simple to interface with. I plan on writing a tutorial on the subject soon.

Data from the four infrared sensors in the gallery is passed through 75 feet of wire to an arduino board, which then passes the information to a computer running Max 5. I mounted a custom prototype board on top of the arduino to make it easy for Arthur to set it up in the gallery. Plug and Play! Unfortunately, I didn't take any pictures of the set-up before he left, but I'll provide them as soon as my arduino returns.

A front-back facsimile of the (very glossy) flyer for Arthur's show:

![Arthur Liou Poissant Flyer](/static/images/posts/arthur_liou_poissant.jpg "Arthur Liou - 'Nachi' at the Poissant Gallery")

And here's a video:

<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/11658295?h=2f8ad5b781" style="position:absolute;top:0;left:0;width:100%;height:100%;" frameborder="0" allow="autoplay; fullscreen; picture-in-picture" allowfullscreen></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>
<p><a href="https://vimeo.com/11658295">Nachi</a> from <a href="https://vimeo.com/arthurliou">Jawshing Arthur Liou 劉肇興</a> on <a href="https://vimeo.com">Vimeo</a>.</p>
