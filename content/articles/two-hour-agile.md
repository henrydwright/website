Title: Perfecting patient privacy - 2 hour Agile challenge
Date: 2023-12-04 12:30
Category: Blog
Tags: NHS,agile,web
Description: Can you do a Disco + Alpha in 2 hours?
Thumb_Image: 2_hour_agile.jpg

I've a bit of time between jobs and wanted to keep my user centred design skills sharp so I set myself a challenge to see how far I could get with a Discovery and Alpha into the tricky issue of health data privacy in just 2 hours. The blog below details that story:

# 00:00 to 00:08
I've started with a blank folder and just this Markdown-based blog post to track my progress. **Starts the timer.**

Before I get going properly, I make a little plan of action for the first 30-45 mins (in which I'm hoping to get the Discovery completed). This basically goes into the three questions I always like to ask myself before I start prototyping.

1. Who are my users?
    1. What are their demographics?
    1. What is their digital maturity and accessibility needs like?
    1. What are their beliefs and desires?
1. What problem am I solving for them?
    1. What are the needs involved in this problem space (patient data privacy)?
    1. Where do these needs interact with current services?
    1. Which of these needs are most important to users?
1. What product best fits these needs?
    1. What solutions fit best? (off the shelf / build from components)
    1. How will this solution integrate with existing services?

# 00:08 to 00:46
With my plan created I start to research in earnest - creating very rough notes. The WiFi in this Starbucks is a bit rubbish so I switch to my phone.

I've decided I'm going to scope this to England so I can use NHS data / ONS data. Given time constraints I also quickly decide that as Wales has a population of about 3m (vs 56m for England), I can treat English and Welsh data as "good enough" for England. 

This is the point where, using Google (I find ChatGPT tools slow me down), I end up down a rabbit hole of public demographic and opinion data.

# 00:46 to 00:57
Lots of useful information found which will inform the next stage of doing some synthesis. This has revealed several pain points which this 2-hour product could address:

* Users find the current "opt-out" system confusing and some find it difficult to navigate
* Users generally do not trust large data sharing schemes (e.g. care.data) unless they know what it will be used for
* Users' comfort with sharing data differs based on the professional group and usage criteria
* Existing solutions do not allow patients to see who has viewed their information, despite this being important to them

At this point I'd do a whole load of user interviews, but given the time constraints we'll skip that and go off the data we already have. The bits I'm least sure about which I would have asked about in interviews are:

* How do you view the NHS? (i.e. is there understanding it's made up of different organisations)
* Who do you *expect* to be able to see your health data? (e.g. notes, test results, appointments, etc)
* Who would you be happy / not happy sharing your data with, if all ways of knowing it belongs to you had been removed?
* What level of control would you want about who *could* see / use your data?
* What level of knowledge would you want about who *had* seen / used your data?


Of course, this would fail any service standard assessment worth its salt as there's been no direct user engagement!

# 00:57 to 01:15

On behalf of my imaginary users I've created a series of user needs using the early research. In the real world I'd record how many times I heard each, and from which user groups to ensure I'd been comprehensive enough and to help with prioritisation exercises.

<table class="table">
<thead>
<tr>
<th>ID</th>
<th>As a(n)</th>
<th>I need</th>
<th>So that</th>
</tr>
</thead>
<tbody>
<tr>
<td>01</td>
<td>English citizen</td>
<td>To set which <strong>categories of professional</strong> (e.g. doctor, pharmacists, researcher, pharma company) can access my <strong>identifiable</strong> data</td>
<td>I can control which categories of practitioner can access my data</td>
</tr>
<tr>
<td>02</td>
<td>English citizen</td>
<td>To set which <strong>purposes</strong> my <strong>identifiable</strong> data can be used for</td>
<td>I can control what purposes my data can be used for</td>
</tr>
<tr>
<td>03</td>
<td>English citizen</td>
<td>To see who has accessed my <strong>identifiable</strong> data</td>
<td>I can check for suspicious activity and verify my wishes are being respected</td>
</tr>
<tr>
<td>04</td>
<td>English citizen</td>
<td>To see for what purposes my <strong>identifiable</strong> data was accessed</td>
<td>I can check for suspicious activity and verify my wishes are being respected</td>
</tr>
<tr>
<td>05</td>
<td>English citizen</td>
<td>To report any access to <strong>identifiable</strong> data I do not agree with</td>
<td>It can be checked in line with &quot;need to know&quot; basis rules</td>
</tr>
<tr>
<td>06</td>
<td>English citizen</td>
<td>To set which purposes my <strong>anonymous</strong> data can be used for</td>
<td>I can choose which types of research and/or planning my data can be used for</td>
</tr>
<tr>
<td>07</td>
<td>English citizen</td>
<td>To understand which organisations have used my <strong>anonymous</strong> data and for what purposes</td>
<td>I can opt-out or object to specific uses I disagree with</td>
</tr>
<tr>
<td>08</td>
<td>Prospective research participant</td>
<td>To be able to provide consent for specific studies</td>
<td>I can override any previous preferences for specific studies</td>
</tr>
<tr>
<td>09</td>
<td>Prospective research participant</td>
<td>To note my willingness to be contacted about studies my data says I might be interested in</td>
<td>I can be contacted and consent to research I agree to</td>
</tr>
<tr>
<td>10</td>
<td>Commercial app user</td>
<td>To be able to control access of specific apps I&#39;ve chosen to my healthcare data</td>
<td>I can access services I have chosen to pay for</td>
</tr>
<tr>
<td>11</td>
<td>Second language English speaker</td>
<td>Information to be available in my chosen language</td>
<td>I can fully understand how my data is being used</td>
</tr>
</tbody>
</table>

# 01:15 to 01:21

Time is ticking pretty quickly (I've overshot the time I allocated for the Disco by a fair bit) and it looks like I definitely won't be able to address all of the needs given above so it's time to carry out a quick prioritisation exercise. My favourite framework for this is the MoSCoW (Must, Should, Could, Won't) way of grouping needs.

I'd usually do this with a workshop style exercise with relevant people in the room, but again, given time I've used a workshop with sample size (`n=1` - my girlfriend) to categorise the needs. I paused the clock and gave her 5 minutes to prioritise.

<img src="/images/articles/2-hour-agile/ur_outcome.jpg" width="500">

Hmm... The importance of user research - I probably wouldn't have rated these in the same way. Worth saying that this is why having a diverse group of user research participants is important since this may affect your prioritisation - though obviously you may need to rearrange a little for technical or business reasons.

# 01:21 to 01:35

There's 40 minutes to go and we've got three needs which are rated as 1* (the highest priority).

* I want to see for what purposes my __identifiable__ data was accessed
* I want to understand which organisations have used my __anonymous__ data and for what purposes
* I want information to be available in my chosen language so I can fully understand how my data is being used

Three is probably the limits of my speedy prototyping. I'd probably check where users expect to see these settings, but knowing from the Discovery that the existing service is already in the NHS App that's probably where it belongs. The easiest way to do this is using the [NHS Prototyping Kit](https://nhsuk-prototype-kit.azurewebsites.net/docs) so it's time to download into my working folder.

Pause the clock - I don't have Node installed `:-(` - one quick Node install later and I'm ready to go.

# 01:35 to 02:00

First order of business - choose a name for the service. I've gone for _View how data from your health records has been used_.

One of the trickiest things creating the first (start) page of this prototype is that there's a lot of jargon in health privacy. I'd want to do user research to confirm it - but my hunch is that anonymised / identifiable are not widely understood. I've made a start, but I'd definitely want to iterate this to make sure it matches the [NHS Content Style Guide](https://service-manual.nhs.uk/content). 

Well I've spent far too much time on that and only have 7 minutes left for the rest of the design (eek!). 

# 02:00 to 02:26

I didn't use that 7 minutes well and spent another 26 minutes to get something good enough. The trickiest thing about this design turned out to be the same issue as above - the content issue. It's really hard to make healthcare terminology easily understandable. 

Were this a real project, I'd probably spend most of my effort checking the content and getting the level of detail and wording correct.

I've included screenshots below:

<a href="/images/articles/2-hour-agile/page1.png"><img src="/images/articles/2-hour-agile/page1.png" width="350"/></a>

<a href="/images/articles/2-hour-agile/page2.png"><img src="/images/articles/2-hour-agile/page2.png" width="350"/></a>

# Appendix
## Research Notes
I've included my raw research notes to give an idea of what information went into the above assumptions:

* [https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/populationestimates/bulletins/populationandhouseholdestimatesenglandandwales/census2021](https://www.ons.gov.uk/peoplepopulationandcommunity/populationandmigration/populationestimates/bulletins/populationandhouseholdestimatesenglandandwales/census2021)
    * 56m people in England
    * About 50:50 Men and Women
* [https://www.ons.gov.uk/peoplepopulationandcommunity/culturalidentity/language/bulletins/languageenglandandwales/census2021](https://www.ons.gov.uk/peoplepopulationandcommunity/culturalidentity/language/bulletins/languageenglandandwales/census2021)
    * 7.1% did not have English as main lagnauge
    * Big languages are: Polish (1.1%), Romanian (0.8%), Panjabi (0.5%) and Urdu (0.5%)
* [https://researchbriefings.files.parliament.uk/documents/POST-PN-0643/POST-PN-0643.pdf](https://researchbriefings.files.parliament.uk/documents/POST-PN-0643/POST-PN-0643.pdf)
    * 20% do not have basic digital skills
    * Inequalities in age (65+ only 46% have essential skills) and education (34% with no formal quals vs 93% with degree or above)
* [https://www.imperial.ac.uk/news/200436/public-trust-health-data-sharing-sharply/](https://www.imperial.ac.uk/news/200436/public-trust-health-data-sharing-sharply/)
    * 75% in UK willing to share health records with their doctor [lower than I thought!]
    * Lowest willingness for commercial purposes (5%)
    * 10% wouldn't share their data at all
    * Fewer than 17% reported access to their electronic health records
* [https://www.thelancet.com/journals/landig/article/PIIS2589-7500(20)30161-8/fulltext](https://www.thelancet.com/journals/landig/article/PIIS2589-7500(20)30161-8/fulltext)
    * Ranking of willingness for UK goes
        * Doctor (75%)
        * Academic or medical research institute (50%)
        * Pharmacist (40%)
        * Family (40%)
        * Government (21%)
        * Pharma (20%)
        * Insurance (13%)
        * Tech company for improving healthcare (12%)
        * Not willing at all (10%)
        * Tech company for commercial purposes (3.5%)
        * Any other commercial company (1.6%)
* [https://digital.nhs.uk/services/nhs-app/nhs-app-pilot-research-report/what-we-learned-from-users](https://digital.nhs.uk/services/nhs-app/nhs-app-pilot-research-report/what-we-learned-from-users)
    * Most users used NHS app for viewing medical record
    * Least used for cancelling appointemnts and setting data sharing preferences
    * Medical record was great if you had right level of access (49% thought they had access to sufficient info)
* [https://www.kingsfund.org.uk/publications/using-data-nhs-gdpr](https://www.kingsfund.org.uk/publications/using-data-nhs-gdpr)
    * Public trust NHS organisations more than any other institution with data
    * Public anxiety about how data is used has grown as a result of high-profile breaches of data security and confidentiality
* [https://www.england.nhs.uk/about/protecting-and-safely-using-data-in-the-new-nhs-england/](https://www.england.nhs.uk/about/protecting-and-safely-using-data-in-the-new-nhs-england/)
    * NHS England categorises data usage into
        * Deliver high-quality care to individuals (direct care)
        * Understand, protect and improve health of population (PHM)
        * Plan evaluation and improve service delivery (planning)
        * Research and develop innovative preventations (research)
    * People should have confidence that their choices will be honoured and that their data is respected, secure, protected and used appropriately
    * Details available about orgs who have had access to data, what purposes and data they have used
    * Existing research says *"opt-out system is confusing and can be difficult to navigate for some people"*
* [https://digital.nhs.uk/services/national-data-opt-out](https://digital.nhs.uk/services/national-data-opt-out)
    * Patients can opt out from use of data for research and planning purposes
* [https://www.nhs.uk/your-nhs-data-matters/where-your-choice-does-not-apply/](https://www.nhs.uk/your-nhs-data-matters/where-your-choice-does-not-apply/)
    * Opt-out does not apply if identifiying information is removed first
    * Explicit consent also removes this
* [https://digital.nhs.uk/services/national-data-opt-out/understanding-the-national-data-opt-out/confidential-patient-information](https://digital.nhs.uk/services/national-data-opt-out/understanding-the-national-data-opt-out/confidential-patient-information)
    * Data categorised into demographic, administrative, medical
    * Confidential patient info - identifies the patient, and includes some information about their medical condition or treatment
    * Either anonymised or "pseudonymised" counts as anonymised data - so long as re-id can't take place
* [https://www.theguardian.com/society/2023/nov/10/patients-may-shun-new-nhs-data-store-over-privacy-fears-doctors-warn](https://www.theguardian.com/society/2023/nov/10/patients-may-shun-new-nhs-data-store-over-privacy-fears-doctors-warn)
    * BMA fears that FDP could end up falling victim to same issues as last two attempts to pull data into one place
* [https://medconfidential.org/whats-the-story/care-data-2013-2016/](https://medconfidential.org/whats-the-story/care-data-2013-2016/)
    * care.data a previous programme to pull data into one place foiled by issues
    * Idea to take GP data and link to data across NHS and make available (like for hospital data since 1999)
* [https://www.bmj.com/content/354/bmj.i3907](https://www.bmj.com/content/354/bmj.i3907)
    * Died due to public trust and lack of doctors support
* [https://www.gov.uk/government/publications/the-caldicott-principles](https://www.gov.uk/government/publications/the-caldicott-principles)
    * Caldicott sets principles for use of confidential information or sharing of it
        * Justify purpose
        * Use only when necessary
        * Use minimum neccesary
        * Access on strict need to know
        * Accessors to know responsibilities
        * Comply with law
        * Duty to share info is *as important* as duty to protect patient confidentiality
        * Inform patients and service users about how their confidential information used