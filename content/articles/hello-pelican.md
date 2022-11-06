Title: Static site generation with Pelican
Date: 2022-11-06 14:32
Category: Blog
Tags: front-end,devops,python

Nothing lasts forever - something that definitely applies to software support cycles ([RIP Windows Phone: gone but not forgotten](https://en.wikipedia.org/wiki/Windows_Phone)) and something *I had definitely* forgotten about for this long neglected website which was running on Apache over on a [solidly end of life](https://www.debian.org/releases/stretch/) Debian 9 virtual private server (VPS).

Not only was it a security risk (probably) it was also a pain in the a\*\*\* to maintain (definitely) as I'd decided - partly through blind pride and ignorance - to hand craft all the HTML. 

**Why is handcrafting bad?**

There's a couple of reasons why handcrafting all the pages was a bad idea:

- Making changes to shared site components required hand crafting changes to every page
- The editing experience wasn't the most fun (clearly I'm not a [**real** programmer](https://xkcd.com/378/))
- Creating new content took time and edits were harder so blog style content like this was pretty much a no-goer

**Static site generators**

The first question you might be asking me is: Henry, why not use a CMS like everyone else? Well, in addition to moving away from hand crafting I was also pretty keen to move away from hosting my site on a VPS - which a) requires active effort to keep up to date and b) was massively overkill for a little site like mine. It would also save me about £3 a month that I was spending on my AWS Lightsail VM (every little helps) by allowing sticking it on a free CDN offering.



