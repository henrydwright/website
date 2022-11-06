Title: Static site generation with Pelican
Date: 2022-11-06 17:53
Category: Blog
Tags: front-end,web,python
Description: How to let go of hand crafting your HTML and love static site generators instead

Nothing lasts forever - something that definitely applies to software support cycles ([RIP Windows Phone: gone but not forgotten](https://en.wikipedia.org/wiki/Windows_Phone)) and something *I had definitely* forgotten about for this long neglected website, which was running on a [solidly end of life](https://www.debian.org/releases/stretch/) Debian 9 virtual private server (VPS).

Not only was it a security risk (probably) it was also a pain in the a\*\*\* to maintain (definitely) as I'd decided - partly through blind pride and ignorance - to hand craft all the HTML. 

**Why is handcrafting bad?**

There's a couple of reasons why handcrafting all the pages was a bad idea:

- Making changes to shared site components required hand crafting changes to every page
- The editing experience wasn't the most fun (clearly I'm not a [**real** programmer](https://xkcd.com/378/))
- Creating new content took time and edits were harder so blog style content like this was pretty much a no-goer

**Static site generators**

The first question you might be asking me is: Henry, why not use a CMS like everyone else? Well, in addition to moving away from hand crafting I was also pretty keen to move away from hosting my site on a VPS - which a) requires active effort to keep up to date and b) was massively overkill for a little site like mine. It would also save me about £3 a month that I was spending on my AWS Lightsail VM (every little helps) by sticking it on a free CDN offering.

So, no CMS, no backend and no hand crafting - what solutions are on offer for someone in that market? Enter the *static site generator*: templates and markup language in - static HTML website out.

Several good solutions exist: one such example is [Middleman](https://middlemanapp.com/) for Ruby fans which powers, amongst other things [GDS' excellent Tech Docs Template](https://tdt-documentation.london.cloudapps.digital/) used to produce technical documentation for many UK Government services.

**Pelican**

But I don't know Ruby so wanted a solution with a hint more Python - this is where [Pelican](https://getpelican.com/) comes in. After a short configuration period and an afternoon of coding up my old website in Pelican, I have several thoughts.

Things I like:

* It's very customisable - even down to being able to write readers for new types of markup if you want
* Nearly all of the editing you'll want to do is in HTML and [Jinja](https://jinja.palletsprojects.com/en/3.1.x/) so feels like Python-esque templating you'll have done before
* Builds happen quickly and it's autodetected on my build platform of choice ([Render](https://render.com/)) - though you do have to make sure to use ```pip install "pelican[markdown]"``` to get your markdown pages to work

Things I'm not such a fan of:

* The site structure is reasonably pre-defined for a basic blogging site - meaty theme changes are required to get it to do exactly what you want
* Theme management is not the easiest task in the world - requires manual downloading and pointing of paths despite the lure of a themes tool (whose purpose I can't quite work out)

**Conclusion**

Moving to a static site generator is something I would definitely recommend if your site is reasonably static or you want to avoid running any backend. If you like this theme and want to adapt it for yourself you can [steal it off my GitHub](https://github.com/henrydwright/website/tree/main/themes).