---
layout: post
title: "Why and how I use Assisted-by with Claude Code and not Co-authored-by"
date: 2026-08-31 12:00
description: >-
  Co-author is the wrong attribution for an LLM. I am switching my commit and PR messages to use the Linux kernel's "Assisted-by" trailer.
category: blog
tags: ai software-engineering git attribution developer-tools
readtime: 3 min
---

I found the following blog post on Hacker News, and it caught my eye because I, too, don't allow Claude Code to add itself as a co-author on my commits. I have *always* found it distasteful that Claude Code automatically does this and that its logo appears on my commits in GitHub. I blocked this behavior in my global CLAUDE.md on practically Day 1 - and I was an early adopter in March 2025!

<a href="https://igupta.in/blog/why-i-am-no-longer-letting-claude-code-add-itself-as-coauthor/" target="_blank" rel="noopener noreferrer">"Why I am no longer letting Claude Code add itself as Co-author in my commits"</a>

In my opinion, adding Claude as a "co-author" and its logo on commits is just a marketing gimmick that over-anthropomorphizes the agent. It also sends a strong unintended "slop signal" to outsiders when they look at my own code, or my agency's, and see Claude logos everywhere.

Today, you can turn it off in `~/.claude/settings.json`. I recommend that everyone do this:

```json
{
  "attribution": {
    "commit": "",
    "pr": ""
  }
}
```

It's not that I'm trying to cover up my use of AI. Disclosure and attribution is the professional thing to do. I just think "co-author" is not the right attribution for LLMs. Back in the days of StackOverflow, I would include links attributing my sources whenever I copy-pasted a substantial amount of code, but I never would have called StackOverflow a "co-author."[^1]

Just as then, the code is my responsibility, and I am in the "driver's seat" of the AI. I wouldn't call a tractor or a vehicle the "co-driver," even in cruise control (or these days, self-driving mode). Yes, it's doing a ton of work for me, but it is still just a tool.

But that has meant that my commits have had no clear AI attribution, which doesn't feel right either. Today I'm updating my system prompt again to use <a href="https://docs.kernel.org/process/coding-assistants.html" target="_blank" rel="noopener noreferrer">the Linux kernel's standard</a> of attributing the AI model and any other specialized tools `Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]`.

For example when I'm using Claude Code:

```
Assisted-by: claude-code:claude-opus-5 spekk
```

And when I'm using opencode:

```
Assisted-by: opencode:claude-opus-5 spekk
```

This is the most reasonable standard that properly reflects the role of LLM assistants as a tool, and also gives us traceability on what models and harnesses were used to produce the code.[^2]

## Set up a script for reliable "Assisted-by" trailers

I added instructions to my system prompt that inform agents about the "Assisted-by" trailer, but I still ask agents to NEVER write the attribution themselves. I wanted to make sure the trailer was always consistent.

For this, Claude helped me cook up an `assisted-by` script that reads the harness and the model out of the agent's own session record and prints the trailer consistently and deterministically. The agent calls it when it commits:

```sh
git commit --trailer "$(assisted-by)" -m "..."
```

I use both Claude Code and opencode, and they store their sessions differently. Any commits I write by hand don't have the trailer unless I add it.

I put the script in a gist if you want it: <a href="https://gist.github.com/whusterj/01be8cde934ed45ea5264c30163d9cf5" target="_blank" rel="noopener noreferrer">Assisted-by script</a>

```sh
mkdir -p ~/.local/bin
curl -fsSL https://gist.githubusercontent.com/whusterj/01be8cde934ed45ea5264c30163d9cf5/raw/assisted-by -o ~/.local/bin/assisted-by
chmod +x ~/.local/bin/assisted-by
git config --global trailer.assisted-by.ifExists addIfDifferent
```

The last line keeps an amend or a rebase from adding a second copy of the trailer.

The same script can put the trailer at the end of a PR description, in a repository that opts in with `git config assisted-by.pr true`.

---

[^1]: One exception where I think the AI can be the "author" is purely async sessions. For example, I created the avatar <a href="https://github.com/nimble-claude" target="_blank" rel="noopener noreferrer">nimble-claude</a> on GitHub for sandboxed agents that operate autonomously. In those cases, it's helpful to have an AI account as the "author" to signal that a human may not have reviewed the work. Then when I take over the PR, I am co-author on the PR and the commits I contribute (AI assisted or not) are clearly separated.

[^2]: Basically, I stand by the <a href="https://research.thinknimble.com/notes/ai-attribution-policy/" target="_blank" rel="noopener noreferrer">AI Attribution policy</a> I wrote about a year ago for the ThinkNimble Research site. There are really only three buckets that matter here: (1) 100% human, (2) 100% AI, (3) everything in between. #1 and #2 are easy to attribute. #3 is increasingly the norm, and I think the default assumption should be that the human is making responsible use of the tool.
