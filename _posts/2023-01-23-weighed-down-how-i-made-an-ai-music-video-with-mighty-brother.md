---
layout: post
title: "'Weighed Down' - How I Made an AI Music Video with Mighty Brother"
date: 2023-01-23 12:00
description: "We told an AI the story of this song, and fed it some lyrics, and here is the result."
tags: generative-ai artificial-intelligence video
readtime: 6 min
---

<p>
    <iframe class="youtube-embed" src="https://www.youtube.com/embed/QCZtpYYUrpM?si=BxC-XjJeetuqVNe0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
</p>

Back in July of 2022 I asked an AI to help make a music video for Mighty Brother's song "Weighed Down."

I used Disco Diffusion, Flowframes, and Adobe Premiere Pro to put it all together. Each frame was generated by running Disco Diffusion on Google CoLab at 10fps. I used Flowframes to smooth it out and combined everything in Premiere for some final tweaks. Each part was generated overnight, usually taking 6-8 hours, or around a minute per frame.

Here are the prompts we used. Each prompt helps define the content, style, and camera movement. By design we accepted what the AI created and made minimal edits after the fact.

```python
# 0:00 - 1:02  (Frame 0-620)
text_prompts = {
    0: [
        "A dark tower under a full moon on a stormy night:2",
        "Magazine, collage, photograph, Kolaj Magazine",
        "text:-1",
        "people:-1",
    ],
    110: [
        "Lightning strikes from a dark cloud:2",
        "Magazine, collage, photograph, Kolaj Magazine",
        "text:-1",
        "people:-1",
    ],
    160: [
        "Rain falling:2",
        "Magazine, collage, photograph, Kolaj Magazine",
        "text:-1",
        "people:-1",
    ],
    190: [
        "A tower window:2",
        "Magazine, collage, photograph, Kolaj Magazine",
        "text:-1",
        "people:-1",
    220: [
        "A young wizard sits at a desk writing in an old book",
        "Magazine, collage, photograph, Kolaj Magazine",
        "text:-1",
    ],
    330: [
        "A demonic choir encircles a young wizard",
        "Magazine, collage, photograph, Kolaj Magazine",
        "text:-1",
    ],
    440: [
        "A young wizard looks out of a tower window as candlelight flickers",
        "acrylic painting",
        "cool color scheme",
        "text:-1",
    ],
    490: [
        "A rusted beam falls from a tower",
        "acrylic painting",
        "cool color scheme",
        "text:-1",
    ],
    550: [
        "A spiral staircase going down to a secret door",
        "acrylic painting",
        "cool color scheme",
        "text:-1",
    ],
}
```

```python
MOVEMENT MAP = [
    "translation_x": "0:(0),620:(0)",
    "translation_y": "0:(0),439:(0),440:(-9),550:(0),620:(0)",
    "translation_z": "0:(0),49:(0),50:(3),219:(3),220:(0),221:(-3),439:(-3),440:(0),620:(0)",
    "rotation_3d_x": "0:(0),549:(0),550:(-3),619:(-3),620:(0)",
    "rotation_3d_y": "0:(0),549:(0),550:(-3),619:(-3),620:(0)",
    "rotation_3d_z": "0:(0),549:(0),550:(-3),619:(-3),620:(0)",
]
```
