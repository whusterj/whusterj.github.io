---
layout: post
title: "The FOUND Art Show"
date: 2010-03-03 17:51
description: On September 23rd, 2009, Youngsuk Altieri and I showed our 'Connections' piece at the FOUND art show at The Lodge in downtown Bloomington.
category: blog
tags: music
---

On September 23rd, 2009, Youngsuk Altieri and I showed our “Connections” piece at the FOUND art show at The Lodge in downtown Bloomington. Here's the Video:

<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/9812364?h=8e1e42c30d" style="position:absolute;top:0;left:0;width:100%;height:100%;" frameborder="0" allow="autoplay; fullscreen; picture-in-picture" allowfullscreen></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>
<p><a href="https://vimeo.com/9812364">Connections</a> from <a href="https://vimeo.com/whusterj">William Huster</a> on <a href="https://vimeo.com">Vimeo</a>.</p>

The piece was created for Leslie Sharpe’s interactive multimedia course in the fall of 2008. Conceptually, the piece represents the aged theme of humanity vs. nature. By interacting with the piece, the viewer is meant to play the role of "intruder." The viewer's actions disrupt the nature imagery in the projection and overwhelm the soothing nature sounds with sounds of machinery and war. At first, we used a Numark Total Control ® DJ controller as our interface device.

![Numark Total Control DJ Controller]({{ "/static/images/posts/found-art-show/numark.jpg" | absolute_url }})

The sounds, imagery, and interaction were processed using Pure Data. Later, we replaced the controller with force sensors and used an arduino micro controller as an interface device with the computer.

Initially, the interface was designed so that the viewer manipulated the knobs and dials on the controller without fully understanding how their actions affected the piece, just as human actions affect nature in ways that are not yet entirely understood. We wrapped the controller in tin foil to conceal the original design and to give it more of a "space-age" feel, but admittedly this was a hasty, last-minute decision. While the controller was functional and matched the piece on a conceptual level, we were not satisfied with its appearance. For this reason, we redesigned the interface using the arduino microcontroller and 6 force resistors. We also added a few whole new sculptural elements to the piece.

Youngsuk suggested using some eggshells along with a spare tire that she had left over from her wrecked car. In line with our concept, the eggshells would be a nice natural contrast to the thick, heavy, industrial nature of the tire. Youngsuk really wanted to use some kind of motor to destroy the eggs. This is what gave us the most trouble. We spent a couple weeks experimenting with ways to destroy the eggs - you'd be surprised at how difficult this actually is! First, we tried using solenoids, and though they created interested percussive noises, they were not strong enough to crack the eggs. After that, I constructed a whirling blade (much like a weed-whacker) from a 12 volt motor, some wire, and a washer. This proved to be too powerful and unpredictable. Finally, we decided to use a servo motor to drop the eggs into a blender a few at a time. Our final design was pretty rough and improvised, but it worked well given the sustainability theme of the FOUND show.

The blender reacted to visitor input via the force resistors (pressure sensors) hidden beneath an earth-colored cloth on the ground. Two of the sensors turned the blender on and also switched the projection to something more violent - an image of a tank or a combat helicopter, which was layered over the images of the animals. The other force sensors also controlled the fading of the various animations.

The blender, perched atop the wounded tire, looked like a miniature makeshift monument to a machine-powered civilization. Viciously, it devoured each egg that was fed to it. By the end of the night, however, the blender could take no more. It had eaten so many eggshells, that their remnants caked the inside. Eggshells that fell on top of this hardened residue could not reach the blade below, and thus were saved. We saw this as an unexpected, yet fitting end to our piece. In the end, with time and perseverance, nature had overcome our machine, broken it down, and rendered it useless.

From a Human Computer Interaction (HCI) standpoint, we were able to make a few observations. First, while some people were more bold than others in terms of interacting with the piece, almost everybody needed to be told in some way that they should interact with the piece. This stands to reason: with art, the physical boundaries are always unclear ("am I really allowed to touch it?"), and as much as the artist would like to allow the artwork to speak for itself, it is sometimes necessary with interactive pieces to give the visitor/viewer/user clear instructions like “Step Here.”

This is definitely one of the challenges of this field. We would like to differentiate ourselves from the folks over in the Human Interface Design and HCI departments, and yet it seems we must either use familiar interface devices to draw the user in or issue explicit instructions. Even referring to the viewer as a “user” may be distasteful to some artists. In the end, I feel that the whole aspect of discovery should be left open to the viewer. I'd rather not tell someone how they should view my work, and yet, if the work relies on viewer interaction for meaning, then perhaps some compromises must be made.
