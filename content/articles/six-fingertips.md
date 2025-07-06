Title: Six Fingertips
Date: 2025-07-06 17:31
Category: Blog
Tags: web,front-end,back-end,c-sharp,AI
Description: My experience creating my first AI agent
Thumb_Image: six_fingertips.jpg

All I seem to see on my Twitter/X feed (aside from copious amounts of Elon-recommended MAGA content) is mega threads from AI exponents claiming you can "just build things" no matter what your previous level of experience. It seems that AI tools have come a long way and AI-assisted software development almost the most of any of these tools.

With [possible redundancy](https://www.thisisoxfordshire.co.uk/news/25219936.job-cuts-considered-nhs-chiefs-amid-oxfordshire-overhaul/) staring me down (thanks Wes), I thought now is the time to throw off my somewhat luddite priors about the capabilities of AI, embrace the cold-hard reality of linear algebra driven agents and try some so-called "vibe coding". 

In this blog post I detail my experiences with AI-driven software development and include a blow-by-blow account of making my first AI agent. If you just want to see what I made, then simply click on the picture below to take you to the website. I'm keen to see what results people get - feel free to Tweet me [@henrydwright](https://twitter.com/henrydwright) with your results.

<a href="https://six-fingertips.azure.henrydwright.co.uk/"><img src="/images/articles/six-fingertips/end_product.png" style="width: 90%; max-width:500px; border: 1px solid #000000"/></a>

_Figure 1: The end result of my vibe coding exercise_

## The brief / rules of the challenge
In my day job, the phrase of the hour is strategic commissioning. Whilst the core of this concept has been around for ages the latest NHS re-organisation has thrown it back into the limelight.

<img src="https://www.england.nhs.uk/wp-content/uploads/2017/03/commission-cycle.jpg" style="width: 90%; max-width:300px">

_Figure 2: Commissioning cycle (credit: NHS England, [Open Government Licence](https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/))_

One of the key components of the healthcare commissioning wheel is assessing needs of the population. There is an excellent dataset of public health data called [Fingertips](https://fingertips.phe.org.uk/) from the Department of Health and Social Care which helps you do just that.

Wouldn't it be cool if you could just ask natural language questions and get answers based on Fingertips data? I set my goal as a tool called Six Fingertips (A funny (?) reference to how the first AI image generators had a tendency to generate human hands with huge numbers of fingers) which will allow users to provide natural language queries and get accurate data / analysis out the other end.

## Caveats to the vibe

I am not a perfect "vibe coder" as I'm starting from a fair level of understanding with a Computer Science bachelor's degree. I also have some knowledge of the data available in Fingertips.

I wanted a programming language I hadn't used in a while so that I didn't start with too much/any experience of how it works. C# was therefore my language of choice using .NET Core.

I'm also studying for an AI Engineering cert so will make use of Azure's offering of AI services.

Without further adieu, here's what I thought of my first experience of AI-assisted development and here's what I learnt:

## Finding 1 - Wow!
In common with the other ways I've seen AI Large Language Models (LLMs) used, my first experience is amazement. With very little prompting it went from an empty folder to a website with a text box which prompts an action when submitted. That just wouldn't have been possible a year or two ago.

<img src="/images/articles/six-fingertips/after_layout_add.png" style="width: 90%; max-width:500px; border: 1px solid #000000"/>

_Figure 3: The result of very little human labour_

The feeling you get when you get something to work with AI is magical beyond any other feeling when programming. It simply takes words that you've written and turns them into code. When my agent works and performs all the steps it needs to and spits out a graph with correct data from a simple query it's magical in just the same way. It can navigate data and present it back in a way a human might.

<img src="/images/articles/six-fingertips/wow.png" style="width: 90%; max-width:500px; border: 1px solid #000000"/>

_Figure 4: My agent behaving and making a (mostly legible) graph_

This wow factor is also the downfall of these models. The confidence and magic of the AI belies its fragility - it will happily be wrong with confidence, even when it has the information and context a human would have needed to solve the same problem easily. This means that the "wow!" can be shattered when you start asking it about things you know about. As an example, the agent I built to look up public health data will make the right requests to the Fingertips service and get the right data and then sometimes just make up a number rather than doing the calculation (e.g. I have spotted it get a list of all the GPs in an area to answer a query and then make up a number rather than counting how many were in the response returned).

## Finding 2 - It's REALLY frustrating when it doesn't "get" it
The AI-assistance features can get frustrating when, despite your best effort, they just don't quite understand what you're looking for or know what you're asking about.

<img src="/images/articles/six-fingertips/halleluljah.png" style="width: 90%; max-width:500px; border: 1px solid #000000"/>

_Figure 5: This image is called halleluljah.png because that's how I felt after ages prompting the AI (and intervening manually) to get it to work_

One weak spot is that LLMs have a knowledge cut off date which is usually a few months in the past. For anything in human existance produced after this date, they simply don't know about it unless they are told or have the ability to augment their knowledge by searching the internet. This meant that when I asked it to use external libraries, it used old versions and when I asked it to help me with the more recent Azure AI models, it just wasn't much help.

Sometimes they just miss the point and the frustration of repeated prompting builds to the extent you just do it yourself in the same way you might with a co-worker who hasn't quite understood the task you gave them.

On the worst end, some features were so annoying I turned them off entirely. As an example Cursor (and Copilot) have a feature where it suggests what code comes next and you can hit "tab" to accept it. This is like an AI version of the normal code completion features you get in your IDE. The only difference is that I found it useless and annoying.

## Finding 3 - Stop doing the small stuff
Some of the tasks I hate most about coding my side projects are the ones that require careful reading and adjustments to code to get working but yield little in terms of extra features. For example large refactors, or writing documentation. I used AI several times during this project to generate documentation or to refactor code across several files to improve code quality. These are tasks I might have skipped for a hobby project, and I can absolutely see why it can ramp up productivity for professional developers for whom these tasks are a "must".

You can also use the AI to assess your codebase for potential security risks and stylistic mishaps. It's like a ready mode code reviewer. This is especially useful for side projects like this one where it's a team of me, myself and I.

## Finding 4 - You have to put in to get out
The main way to get AI to do what you want is to be super explicit about what you want. Where I had the best results and greatest satisfaction was when I was super explicit about what I wanted. You don't just have to give a few more instructions than you'd give to a reasonably clued in colleague, you have to give it answers to all the questions it might ask too. I can see how this would turn me into a better Product Manager over time as you have to give all the information at the start rather than expecting folks to come back and ask questions.

In the same vein, when I was giving the AI the ability to use the Fingertips API, I had to add a lot of natural language documentation, and reduce the number of methods available to it to allow it to make the right choice more often. If you want the AI to make the right choices, you have to guide it in the right direction. To make the best use of AI, we're going to need to get better at documenting things in a tidy way.


<table class="table row-hover" style="width: 60%">
<thead>
<tr>
<td>Original documentation</td>
<td>Edited documentation</td>
</tr>
</thead>
<tbody>
<tr>
<td>Searches geographical area names</td>
<td>Search for an area by name and area type ID. Can be useful for finding the area code (e.g. for use in other API calls) if you only have a name for an area.</td>
</tr>
</tbody>
</table>

_Figure 6: Comparison between original Fingertips API documentation and the adapted documentation I pass to the AI agent_

## Conclusion
AI is here to stay but it's not here to replace humans. My experience with using AI to code was that it aided me but needed my manual help more than I thought it would. If I were somebody with absolutely no knowledge of how coding worked, I think I would find the experience very frustrating and do things in ways in inefficient or insecure ways. As with any profession - knowing how to ask a good question, or check an answer you've been given, is as much of a talent as being able to answer those questions.

I worried before this experiment about the effect AI will have on the way we learn and that is unchanged by this experience. I found that when I left things entirely to the AI, I learnt less about how things worked. The more things we leave to AI, the less of the thinking we do ourselves and the less we'll learn. In some areas this won't be important, but in others like education, students will find themselves speeding through with ChatGPT but learning little in reality.

I continue to worry about the effect AI will have on our corpus of knowledge. LLMs hallucinate, make things up and draw incorrect conclusions from source material. The volume of incorrect information AI has the ability to produce could overwhelm the sum of human knowledge and make it much harder to tell fact from fiction. As they start to feed on their own mistakes, it will only get worse. 

All this leads me to ask: will we start talking of a pre-AI and post-AI age?

Only time will tell...

<hr style="border: 3px solid #60a917"/>
<b>THE END</b>
<hr style="border: 3px solid #60a917"/>

## Addendum: Stream of consciousness
The section below details my minute-by-minute experience in creating my app with Cursor and GitHub Copilot. Read only if you're very curious.

#### Minute 0-30

* Created a Cursor account using Github SSO - very easy
* Editor experience incredibly familiar (nice!)
* Reading the docs - completion, inline and chat (seems sensible)
    * Can get an agent to do some work for you, ask questions about certain parts of code and make custom modes
    * Want the blog post ignored in code base - `.cursorignore` looks like right thing. User specific so also needs to go in `.gitignore`

#### Minute 30-60
* Still reading the docs
    * You can choose what context you give models using `@` like you would naturally when chatting
    * Rules allow you to change how the AI models respond - project and user level but also generated through chat
    * Need rules as LLMs don't memorise between completions. Rules are the Cursor way of adding extra prompt content in addition to the code.
* Pricing
    * Based on requests
    * $0.04 (3p) per request
    * Each request is actually several "requests" depending on how expensive the model is
    * I hate that models just have stupid non-intuitive names and versioning.
    * Big name models that I recognise are all there with different pricing. No idea which model to use.
    * Get a budget of "requests" and when its spent they still work but it goes slower
* I want to make a blank web app using .NET core and C#
    * That's enough reading - who needs that when AI exists
    * Not sure how much effort to put into my initial prompt. Went with the below<br/>
<code>
Please do the following things for me:
1. Install the latest .NET Core tools
2. Create a blank web app project in my current directory using C# and .NET Core best practice.

The basic web app should have a single page with the contents "Hello World".
</code><br/>

* First reactions  
    * Weird how we say please isn't it!
    * Doesn't look like I have to select a model - guess it "just works?"
    * It asks me before running commands in my shell. That seems like a sensible security and sanity measure. It starts by checking if .NET is already installed.
    * It's going to wget some source repo packages from some microsoft.com URL and then apt-get install them. Seems sensible. Pressed run again.
    * Would have got stuck on my password. Clicked in the terminal and entered my password. Neat that it lets you enter its terminal like that.
    * OK that just full on didn't work. It's apologised to me and is going to try another script from dot.net. I don't recognise that so Google it - official MS site. Clicked run again.
    * It's going to add a non existant `.dotnet` directory to my path and then create a new webapp apparently. Run.
    * It shows me the diff of the changes its made. Or at least I think so as there's also a "Tick" and "Cross".
    * It's gonna run the app now. Cool let's try that. Run.
    * It's running based on the console output. I manually open URL in browser. OK that worked and it did make the changes.
    * Use old fashioned human brain to git commit progress so far.

#### Minute 60-90 

* Came back after a few days
    * No idea how to run this web app - tried the command the AI said and it doesn't work. Going to use "ask" mode.
    * OK it was the AI's fault for not adding the installed dotnet to path
    * I'm not convinced it installed it in the best way if I'm honest, but there we go
    * Wanted to rename - ran the commands and it broke. Tried deleting things using human brain. Didn't work.
    * Asked AI to fix its own mess - it gave a solution (to rename to be explicit about namespace) but I worked out a better one - change the view imports. Take that AI.
    * Want to fix .gitignore so asked the AI to do it. All ignored correctly.
* Let's get it to create the user interface
    * I think I'm going to get AI to do it in stages like I would
    * Went with<br/>
    <code>
    Modify @/SixFingertips web app to modify the front page

    to have a single large text box and a submit button which 

    calls a function.
    </code><br/>

    * It's actually quite cool that this works.
    * OK wonder if it will do all the styling. I want it to use NHS design system<br/>
    <code>
    Restyle the app to use the NHS.uk frontend library. 
    
    Use NHS.uk frontend components to replace bootstrap components. 
    
    Documentation on how to import the relevant parts are at @https://service-manual.nhs.uk/design-system/production 
    </code><br/>

    * For some reason it's used version v7.1.0 and when I check the latest is v9.6.2
    * Let's see how it looks - it looks pretty good. The footer is a bit broken though. I wonder if we can fix that.<br/>
    <code>
    Can you fix the footer to use the footer component as intended?
    </code><br/>

    * Let's ask it to use the latest version instead. Those who don't know what they're doing will definitely get old stuff or the wrong stuff.
    * It downloaded it but made the wrong imports I think. Changed them. Still broken. Asked AI to fix it.<br/>
    <code>
    The styling is broken - the menu and footer don't look right.
    </code><br/>

    * Let's see if it can revert back the changes it made<br/>
    <code>
    It is still broken. Revert the changes back to before you changed from v7.1.0
    </code><br/>

    * It works again. We'll try again now. Will it avoid messing it up this time?<br/>
    <code>
    Update the version of nhsuk-frontend to v9.6.2 from v7.1.0. Update any component code as needed to ensure it looks the same after the version change.
    </code><br/>

    * It starts by barking up the wrong tree and looking for an automatically imported package. It can identify the changes needed but instead of doing them, like it did before. It stops part of the way through and asks me if I'd like more help.<br/>
    <code>
    Please download and replace the old files with the new files
    </code><br/>

    * It's not found the right place to download them this time. It's getting frustrating. I'm just going to help it out and do it myself.
    * It's broken in exactly the same way. Guess there were breaking changes between v7.1.0 and v9.6.2 it didn't identify.<br/>
    <code>
    The header doesn't look right and has an out of place "Menu" text. Can you fix it to use the correct NHS design system header?
    </code><br/>
    * It hasn't fixed anything. I'll try asking in a different way. I'm starting to find this frustrating. I could have done this much more quickly myself.<br/>
    <code>
    Remove the text and button that says "Menu"
    </code><br/>
    * It's removed the whole navigation section now...<br/>
    <code>
    I didn't ask you to remove the whole navigation bar. Put the Home and Privacy Policy links back.
    </code><br/>
    * We did it Joe! Now to fix the footer again.<br/>
    <code>
    Fix the footer now. Do not change any of the links, just fix the styling to use the correct NHS Design System styling.
    </code><br/>
    * Hmm it's still broken<br/>
    <code>
    It's still not fixed. Look again to ensure the footer component is being used correctly.
    </code><br/>
    * It's still broken, so let's try prompting a bit differently.<br/>
    <code>
    Remove the footer entirely. Insert a new NHS Design System footer component.
    </code><br/>
    * I give up.<br/>
    <code>
    Remove the whole footer
    </code><br/>
    * I'm having to rebuild every time - I wonder if there's a live watch style way of doing this. AI gave the right answer (`dotnet watch`) first time with explanation.

#### Minute 90-120

* It's time to get meta. I don't think I'm using the tool effectively. I'm going to ask Cursor how to prompt Cursor effectively.
    * It looks like clarity and context is key. Somebody on Twitter (I got distracted) has described it as a junior dev with amnesia, which sounds about right.
    * It's almost like you have a highly skilled dev but they need a micromangement level of direction
    * No wonder my vague instructions about the footer didn't work. I wonder whether I need to provide the documentation up front.<br/>
    <code>
    I am creating a .NET core web app in @/SixFingertips using the NHS Design System. Carry out the following steps:
    1. Update the site-wide page template to match the "Content Page Template" on @https://service-manual.nhs.uk/design-system/styles/page-template
    2. Remove the search box
    </code><br/>
    * That worked a LOT better.
* Big leagues time now. I'm going to get it to help me decide between Terraform and Azure ARM Templates
    * It's recommended Terraform. Let's try using my learning to see if I can give it a good prompt and get it going<br/>
    <code>
    I am writing a web app which will allow users to ask questions to an AI agent connected to a third party service. Plesae perform the following steps - perform these strictly in order and do not skip any steps:
    1. Install Terraform if it is not already installed
    2. Create a new Terraform project inside a new top level project folder called "SixFingertipsInfrastructure"
    3. Write Terraform code to deploy an Azure AI Foundry Agent that uses GPT-4o-mini
    </code><br/>
    * It's produced some feasible looking Terraform with some minor redundant code and some names I think could be clearer. I tidy up after it.
    * Let's let rip - `terraform plan` seems sensible so I apply it. I get an error on apply.
    * I ask the model for a correction. It tells me my model name is wrong. I don't believe it. I look at the docs and come to a different answer. It works this time.
    * I'm not sure if it's just me but I'm having to do a fair bit of babysitting and keep my eye on the ball to tidy up errors. Perhaps I'm using the wrong models, perhaps I'm not providing enough context. Next time I am going to add way more.
* I think it's time to get it to write some backend code. I'm going to use a huge prompt and give very explicit instructions. Let's see if that does any better.<br/>
    <code>
    You are an AI agent writing a .NET core web app in C# (code in @/SixFingertips ) which allows the user to interact with an AI agent.

    The objective is to create a working interface so that when the user inputs text into the main textarea and clicks Submit in @Index.cshtml, the input is submitted to an agent and the answer displayed on the same page.

    DO NOT finish until the objective is complete. Complete the objective by completing ALL of the steps below:
    1. Study the documentation for the Azure.AI.Agents.Persistent package at @https://learn.microsoft.com/en-us/dotnet/api/overview/azure/ai.agents.persistent-readme?view=azure-dotnet 
    2. Install the package to the project
    3. Create code that instantiates an agent using an already deployed Azure OpenAI Services resource (allow deployment details to be input via environment variables or similar)
    4. Allow the user to submit input to the agent using the textarea and submit button
    5. Display the messages returned by the agent on the main page
    6. Ensure the user interface uses NHS Design System components
    </code><br/>

* A common theme is emerging. Given knowledge cut off, it does seem to struggle with getting the right package versions. I'm getting build errors and security vulnerabilities.
    * What I am really enjoying is the "Ask" function which definitely saves time versus looking in the documentation. This is especially true given my shaky understanding of .NET Core.
    * Getting build errors still, but at least they're not package related.
    * I'm going to get the agent to fix these errors.<br/>
    <code>
    There are some build errors. Please correct the build errors and verify the code builds correctly. Continue until you have fixed the code so it builds correctly.
    </code><br/>

* More errors. Let's try chucking the context and pretend I made the mistakes. Now there's modesty.<br/>
    <code>
    I am building a web app in @/SixFingertips using .NET Core in C# and the Azure AI Persistent Agents library.

    I appear to have made some mistakes whilst creating the code and need you to fix them. The build errors I am getting are provided as context.

    You may need to use a web search to find relevant documentation, or navigate links off the documentation homepage for the library@https://learn.microsoft.com/en-us/dotnet/api/azure.ai.agents.persistent?view=azure-dotnet
    </code><br/>

* Still not quite working, we roll again. I realise I feel quite vulnerable handing over all this control to AI as I don't really fully understand anything its doing. I also feel like I'm not learning anywhere near as much from the process as I'm not understanding what it's doing or fixing things.<br/>
    <code>
    There is one more issue to fix. I have provided the build error. Please provide a fix that enables the code to build.
    </code><br/>
    
* In any case simply adding a new package hasn't fixed things and doesn't give me a good gut feel. I'm going to reject those changes and try again.
    * This time I use my human brain to find the right AI documentation for the line of code causing the error. I use the inline function and tell the AI what mistake it's made and give it the documentation link to use to try and find the right methods.
    * New build error. I fust around in the docs and make some manual changes to get the errors to go away. I don't know what I'm doing but I have at least got it to build. Let's see the vibe.
    * LOL I forgot to add my credentials. Let us try again.

#### Minute 120-150
* It's added some quite good error handling at least. But the code is very much still broken.
    * I think it's actually the infrastructure that isn't quite working and it's no fault of the agent that did the backend code. I tried to use an Azure AI project I'd set up earlier to give it a model to call and work with.
    * Now there are new errors. It's really really struggling with this to be honest. Neither the inline code editing chat, nor tab suggestions yield correct or valid code, even with prompting.
    * I really hate the automatic tab suggestions in Cursor. I'd happily accept the suggestions if they were any good but every time I've tried to accept them it's yielded garbage. What I really want to do is accept the "legacy" suggestion from the interface. 
    * Given I don't have any documentation pop ups myself I wonder if the lack of type information is helping or hindering it. The lack of documentation hoverovers are really hindering me for sure.
    * Maybe it's because I ignored a prompt to install an extension. Yeah the extension isn't installed for C# - doh.
    * AI is still unable to write async code after installing the code, but then again so am I as I have no clue how it works in C#. Luckily with the extension enabled I am now able to guess my way through the methods to get something working.
    * After much pain and suffering I got it to work.
* I think it really struggles to use its own knowledge if the library you want to use didn't exist at the knoweledge cut off date. I wonder if some very targeted prompting will help it do better for the next task. It certainly seems adept at using the .NET core components but it makes mistakes I don't make even with complete "most likely next suggestion" guesswork.

#### Minute 150-180
* After consulting docs it seems that what I need doesn't have Terraform helpers that can create it. So I Terraform destory things and delete the folder. Nothing ventured nothing gained.
* I want to refine the user interface so I try and get it to add a simple generating message whilst the agent is thinking<br/>
    <code>
    You are editing a .NET core app which connects to an Azure AI Agent. 

    Currently when the user clicks the submit button, nothing is displayed in the user interface whilst a response is being generated.

    Please add an informative message to the screen which is displayed only whilst waiting on the AgentService to generate the result.
    </code><br/>

* It has an attempt, but that attempt uses JQuery, which does not exist in the project and the JavaScript just fails to function. Clear the context. Try again with a new prompt.<br/>
    <code>
    Make edits to @Index.cshtml and @Index.cshtml.cs so that an informative message is displayed to the user between clicking "Submit" and the result being displayed.
    </code><br/>
    
* That also didn't work. It's trying to change the page display using server side code only, but the issue is the page doesn't do anything whilst waiting for a post response
    * Maybe it's using a dud model. What if I specifically task Claude with the job? It's going to cost more requests but mucking around as-is is costing a huge amount of requests.<br/>
    <code>
    Make edits to @Index.cshtml ONLY which display an informative message between clicking on the "Send" button and the page completing loading the response once generated.

    Use only pure JavaScript. Do not assume any libraries are installed.
    </code><br/>
    
* With a bit more direction it succeeds. Not sure the manually specified model makes any difference though. This seems to be a theme!
* The agent often returns Markdown, but we want that displayed in the interface as HTML. Time to ask an Agent to help us out...<br/>
    <code>
    I am creating a .NET core app in @/SixFingertips which allows the user to enter a prompt and have an AI agent respond.

    The response String that is returned by the agent in the highlighted line in @Index.cshtml.cs often contains Markdown text.

    Add processing logic to @Index.cshtml and/or @Index.cshtml.cs which processes any Markdown returned and displays the information back to user with correct formatting.
    </code><br/>
    
* OK, I'm getting way better at this. That just worked first time.
    * Sometimes it feels like I'm a superhero with the AI when it works and sometimes I just feel stupid and supernumerary.
* Now I want to get the agent to use Fingertips data so I grab the API spec, convert from Swagger v2 to OpenAPI v3 and dump into my project folder.
    * Time to use AI to integrate the tool<br/>
    <code>
    I am writing an AI agent to help users make use of data from the Fingertips public health dataset. 

    The agent is implemented using the Azure AI Foundry Agent library (documented at @https://learn.microsoft.com/en-us/dotnet/api/overview/azure/ai.agents.persistent-readme?view=azure-dotnet#function-call )

    Using the example in @https://learn.microsoft.com/en-us/azure/ai-services/agents/how-to/tools/openapi-spec-samples?pivots=csharp , modify ONLY code in @AgentService.cs  to add an OpenApiToolDefinition that uses the OpenAPI spec defined in "wwwroot/fingertips_api_spec.json"
    </code><br/>
    * Again, worked first time! I suspect I need to improve the prompt because it's getting stuck using the (admittedly very complicated) API for Fingertips.

#### Minute 180 to a number much much larger than 180
* Now it's time to refine the design and functionality of the app before readying this blog post for publication
* The prompt to the agent clearly needs work as it fails to understand how to use the Fingertips API
    * To be fair to it, I don't currently understand how to use the Fingertips API
    * This is an area I know that I will now need to understand better to augment the context provided to the AI to help it solve more problems
    * I need a way of testing if I'm making the agent better or worse, so I design a set of test cases in a .csv file.
    * OK so I needed to understand the API a bit better to understand what sorts of questions that can and can't be answered before writing my CSV
    * Doing this as a human I'm learning things. For example the API uses the NHS ODS codes for some thigns (e.g. GP practices, NHS Trusts) but not others (e.g. ICBs and CCG boundaries which get ONS style E.... codes)
    * Turns out you can trace what your agent is doing if you try it out on the Azure AI Foundry portal. This helps me see what API calls its trying before failing.
* It appears that the agent gets confused by the overwhelming choice of methods to call to find an area and can't construct a coherent chain of thought to get from prompt to answer.
    * I've cut down the different functions the agent can use to a single function by manually curating a subset of 1 function of the whole OpenAPI spec. I have also modified some of the documentation to explain better in plain English what that method does.
    * I plan to slowly add back in methods and tweak the documentation to improve performance. Before that I'd better write a few test queries and then I can report back here on the score for each iteration.
    * Turns out there's a lot of things in Fingertips (who guessed!) so I'm going to write test prompts that target correct answers about GP practices and their related entities.
    * Wrote some test cases that should be enough to do a little fine tuning as this is just an experimental project. Tested with the first agent which had the full API first as "v0" and stored the responses in the spreadsheet with the prompts.
    * Version 0 passes only 1 out of 11 test cases - a paltry 9%.
    * I've further tweaked the documentation and provided a restricted list of the area methods to help the agent get the right method first time to get the codes it needs to use any of the other API calls. This is version 1 and should do a lot better at the various area questions in my test set.
    * The new version now passes 7 out of 11 test cases - a vast improvement. In both versions the LLM displays some weird behaviour - pretending it could do it if the system worked properly or just lying.
    * The oddest thing about this, is it hasn't really been code I've been editing, its been prompts and documentation. If AI is to take off, we must curate clearly written information and docmentation to help it understand the world.
* Time to start work on V2 of the agent which I want to gain a few more methods from the full API library (without overwhelming the agent with choice) to actually have some data to work with rather than just geographical hierarchy.
    * Huh - one of the methods I want for v2 doesn't have OpenAPI schema documentation. LLM-assited coding comes in useful here - it's grunt work and boring grunt work at that. AI does the heavy lifting and I come in and check it. This is a good use of the inline (Ctrl + K) editor.<br/>
    <code>
    Write an OpenAPI compliant schema object for the below JSON 
    <copy of JSON output from API call>
    </code><br/>
    * Documentation is king - I know what some of the figures mean by inference and setting specific knowledge. The AI can guess, but it's much better for it just to be able to know. If we write what we know down, AI can use it to generate new results.
    * The early results from simply adding the GP summary data endpoint are pretty amazing. It can now write comparisons about PCNs based on Fingertips data. The Azure AI Foundry portal allows us to look at traces.
    * Even more amazingly, with the addition of the code interpreter tool in the AI Foundry portal interface, it can also make graphs! Very exciting...
* The Fingertips API goes down sometimes completely randomly so I've decided to make the final design tweaks.
    * I start by asking the AI to replace the normal design header with the transactional service header as this app will only have the one page<br/>
    <code>
    Make changes to @_Layout.cshtml only so that the header uses the NHS transactional service header as detailed on @https://service-manual.nhs.uk/design-system/components/header 
    </code><br/>
    * It does half a job, but doesn't remove the navigation elements. I just copy and paste from the docs instead as it's far quicker.
    * I manually remove the reference to Frutiger in the CSS as I don't have a license for it
    * I generate a new logo to replace the NHS logo in the header using Copilot on my laptop. It doesn't want to generate a hand with six fingers - clearly they've been prompted quite strongly to get the hands right.
    * With a bit of additional help it can now start answering useful queries. It now has access to all the data it needs in theory, however LLMs are famously weak at arithmetic and arithmeic reasoning. By default the answers are astoundingly poor - inventing figures that have never ever existed.
    * In the debug interface of Azure AI Foundry I try the same agent design but add the code interpreter tool. This is slightly better at simple queries, but still fails at things I'd expect a GCSE Maths student to pass.
    * For example, with the code interpreter tool enabled, I ask the agent to create a graph showing male and female population history over the last five years. The AI correctly identifies the API calls to make to retrieve this data. But it misses a reasoning step and just displays the 0-4 population.
* I want to publish this but I don't want it to bankrupt me so I want to add a limit to the API to stop API calls after a certain total cost
    * I've asked AI a few questions which have set me in the right direction, but I actually do want to learn this so this time I'm going to implement myself and maybe get AI involved if I screw it up.<br/>
    <code>
    How do I get the token usage for the model with name `_modeDeploymentName` within code?
    </code><br/>
    * Doing this yourself requires a lot more rabbit holes and reading to find what's relevant. I feel like I understand the potential pitfalls a lot more than if I'd just let AI do this though. I also found a more efficient method myself which requires less Azure resource use and spend so that's also a win.
    * I understand enough now to know that the code that the AI generated for me doesn't quite do what I want. However, I can now use bits of it to get to what I want.
    * I did it! The satisfaction is much greater when you do it yourself!
* It needs to be able to retrieve more data to work with, so I add in some prompt changes and carefully curate a few more methods from the Fingertips API into my adapted API spec
* I really want to show people what tool calls the agent made so they can verify if the steps its taken are valid. Sadly AI is non-deterministic so you can get more than one answer for exactly the same prompt.
    * The SDK for .NET Core hasn't implemented the required methods to pull out the details of the tool call. It's not useful enough to verify output to know a tool was called, I need to know what tool was called.
    * My Cursor Pro trial ran out so I need to be judicious with how I use those completions. I use Copilot online to ask questions as it's free...
    ```
    I am used to using the `requests` library in Python. I am now using .NET Core. Can you give me examples of how you would do a GET request in both `requests` in Python and the best-practice equivalent in .NET Core?
    ```
    * Aaah I hate dealing with Authentication in these APIs - suffice to say I'm a bit of an idiot for forgetting scopes and the need to prefix with "Bearer " for your token. Lots of AI help required to get me to the answer<br/>
    <code>
    How do you use httpClient to do a GET request with headers set
    </code><br/>
    <code>
    Show me how to use HttpClient in C# to make an API call to this API endpoint - https://learn.microsoft.com/en-us/rest/api/aifoundry/aiagents/run-steps/get-run-step?view=rest-aifoundry-aiagents-v1&tabs=HTTP#security
    </code><br/>
    <code>
    How do I get the right access token to use that API using DefaultAzureCredential
    </code><br/>
    <code>
    401 PermissionDenied when using Bearer with https://ai.azure.com/.default scopes
    </code><br/>
    <code>
    What headers do I need to make REST API calls to Azure APIs?
    </code><br/>
    * I got there in the end. The JSON I wanted _is_ in the content that the API returns. Shame on your Microsoft for putting out an SDK which doesn't even work for all the methods in your API!
* I don't know how to work with arbitrary JSON in C#. I just want to retrieve some arbitrary values from JSON strings to be able to display them in the page UI
    * Time to ask AI<br/>
    <code>
    What is the best way to work with arbitrary JSON in C#
    </code><br/>
    * A bit of code writing later I have something to try but it's broken. Turns out Cursor doesn't work with the VS .NET debugger so I have to switch back to VS Code...
    * The C# syntax highlighting is MUCH nicer in VS Code but I'm sure I could have fixed that. Wonder what the dodgy default was.
    * Debugger - I missed you! Time to find out what I'm doing wrong... Yeah I just missed out one level of navigation when navigating the JSON hierarchy.
    * Got everything ready to display in the page UI but now I've got a class and a completely impenetrable error from .NET - lovely.<br/>
    <code>
    Are there any restrictions on type for elements of a PageModel class in .NET Core?
    </code><br/>
    * Turns out `dotnet watch` just hates me making the changes I was making on the fly. Restarting the server fixed things.
    * This also gives me an opportunity to try out Github Copilot. The inline fixes seem much the same as Cursor which is good and it helps me fix some grunt work changing the way I wrote something earlier which I didn't like and fixing some syntax to be less verbose
    * Copilot chat is very similar to Cursor but it doesn't seem as agentic - admittedly it did perform the small task I asked of it very well<br/>
    <code>
    Modify the provided code selection which is a bullet point list in the format YYY [ZZZ] - XXX [MMM] to be a table where the first column is ZZZ (YYY) and the second column is MMM (XXX).

    Use the following table as an example of the classes to apply so it matches the formatting of the rest of the site
    <NHS table example from website>
    </code><br/>

    * It gets confused sometimes with whole of England queries between the area type ID and area code for England so I hard code those into the system prompt.
    * This makes it stop using search and start using "Get children" for the whole of England which is not good. I change it back and live with the problem. My last step will be to modify the system prompt to improve performance at some point.
    * Now added the ability to download and display images (for example if a graph is created)
    * Time to tidy up some bad practices using AI to help me fix my mistakes<br/>
    <code>
    Modify the AgentService to replace all uses of Console.WriteLine with the correct logging for .NET core
    </code><br/>
#### Nearing the end
* It's time to tidy up the code a bit before I publish it. Luckily AI is really good at helping with this sort of thing<br/>
    <code>
    You are an agent responsible for inspecting codebases to suggest improvements. Inspect the code base in SixFingertips. Evaluate it against best principles for C# and .NET Core code. Provide a list of possible improvements that would increase the quality of the code.
    </code><br/>

    * This has given me a list of things to start addressing. One of those is that AgentService is now huge and contains all the logic for everything. I want to split out the bit that does costs into it's own service.<br/>
    <code>
    Currently the logic for interacting with the agent and the logic for looking up the resource usage metrics are all in AgentService.cs.

    Please split out all the logic that is to do with resource utilisation metrics into a new Service called UsageMetricsService.
    </code><br/>

    * Flawless! My mess turned into something with a bit more separation of concerns.<br/> 
    <code>
    Make a new interface IAgentService based on AgentService and use the interface in appropriate places in the codebase to separate code interface from implementation.
    </code><br/>

    * This really does improve my experience of coding. This is the important, but boring stuff that an AI can do really easily.
* And then use my existing knowledge and Google to get it on the web - challenge complete!
