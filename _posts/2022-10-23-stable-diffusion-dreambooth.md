---
layout: post
title: Fun with Stable Diffusion and Dreambooth
date: 2022-10-23 12:00
description: "Today I played around with Stable Diffusion and Dreambooth to make a bunch of silly pictures of myself and friends."
tags: AI programming
image: /static/images/posts/2022-10-23_sylvia-game-character.png
readtime: 4 min
---

Today I played around with Stable Diffusion and Dreambooth to make a bunch of silly pictures of myself and friends.

[Click here if you just want to see the AI generated pictures!](https://photos.google.com/share/AF1QipOPlXIUvcyFZGhfIzyvbRKO1bCOykswMkViAybtNtlappkEVCK22WPAphEI1J3fNA?key=LWV1RVk0SFNmSHhjREQ5ZzZjemtNSFhHMHIxemZB)
<a href="https://photos.google.com/share/AF1QipOPlXIUvcyFZGhfIzyvbRKO1bCOykswMkViAybtNtlappkEVCK22WPAphEI1J3fNA?key=LWV1RVk0SFNmSHhjREQ5ZzZjemtNSFhHMHIxemZB" target="_blank_">
<img
	    src="/static/images/posts/2022-10-23_stable-diffusion-ai-william-jedi.png"
	    alt="I am a Jedi! AI generated image of William as a Jedi holding a lightsaber. Generated using Stable Diffusion and Dreambooth."/>
</a>

All of these images are AI generated using a combination of Stable Diffusion and Dreambooth.

- [Check it out on GitHub](https://github.com/XavierXiao/Dreambooth-Stable-Diffusion)
- [Google Colab Notebook I used](https://colab.research.google.com/github/ShivamShrirao/diffusers/blob/main/examples/dreambooth/DreamBooth_Stable_Diffusion.ipynb)

Stable Diffusion is an open source image generation AI similar to the well-known Dall-E engine. Dreambooth is an "add-on" of sorts that allows you to extend Stable Diffusion's model using just eight or so pictures of a person (or thing) to create a unique "class name" for it. You can then use that class name to inject that person's likeness into images.

I didn't even have to use good images of myself or my friends or very many angles. I just went through my personal pictures and took square screenshots wherever I had an OK close-up of their face. I resized these all to 512px square and then uploaded them to the Colab notebook.

For each person, it probably took 45-60 minutes to train Dreambooth, but after that I could generate images from prompts to my heart's content.

Prompts like this gave great results:

    photo of sks william as a starfleet captain, star trek, wrath of khan

Notice that it says "sks william" - the "sks" string is a known rare identifier, so it helps Stable Diffusion to understand that we specifically mean _me_, and not some other William.

The progress in AI-generated images this year has been astounding. Of course everyone was amazed when GPT-3 and Dall-E came onto the scene with extremely convincing text and image content. But access to these tools and the source code behind them remains limited, because the source code and training models are proprietary.

Now, in just the past half-year or so, we've seen a proliferation of open source alternatives that use the same underlying tech. Back in June, I came across [this now famous AI Generated music video](https://www.youtube.com/watch?v=0fDJXmqdN-A) by DoodleChaos on Youtube.

He explained how he used the open source AI tool Disco Diffusion to generate the video and was very transparent with his process and setup. So much so, that I was able ot sit down one weekend and get it up and running within an hour or two.

Here's a demo music video I made with Disco Diffusion:

<iframe class="youtube-embed" src="https://www.youtube.com/embed/xijahF3VCd4" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

I experimented with this for a while, and shared the results with my brother. Together, we created a complete AI music video for his band [Mighty Brother](https://mightybrotherband.com/). That video is set to release in early 2023, and I'll drop a link here when it does.
