---
layout: post
title: A tale of 102 RFID cards
date: 2013-06-24 09:00:00 +0000
feature-img: "assets/img/posts/2013-06-24/capture.png"
thumbnail: "assets/img/posts/2013-06-24/capture.png"
tags:
    - RFID
    - Physical Security
    - Security
    - Cryprography
---
About 6 months ago i bought 102 EM4100 protocol RFID cards (From [here](http://tinyurl.com/axrct2r)) and a compatible RFID reader [https://www.sparkfun.com/products/8419](https://www.sparkfun.com/products/8419). This was to investigate how it was that these common RFID cards work.

EM4100 protocol cards, like the ones I bought, are factory programed with a 8bit Customer or Version ID, 32bit unique code and some parity information. Once the card powers up from being within proximity of a reader it starts blasting out this code encoded in Manchester Encoding and looks something like the following:

![Data capture](/assets/img/posts/2013-06-24/capture.png)

The theoretical minimum transmission speed possible is about 28ms, however many readers require you to transmit this code twice for it to be accepted.

This gives a total possible number of unique cards of 4,294,967,296 (2^32) or 1,099,511,627,776 (2^40) depending on if unique Customer or Version IDs are used. At the theoretical minimum transmission speed of 28ms this gives the worst case brute force time of 3.8 years or 975.5 years if also using the Customer or Version ID’s bits.

<!--more-->

Lets assume you don’t know the Customer or Version ID a reader accepts and you are attacking a door with 10,000 valid cards, at 0.028 seconds per card it would take 35.63 days to guess a valid card. Knowledge of the Customer or Version ID takes this time down to 3.341 hours.

A more realistic example of 200 valid cards would take 6.959 days or 4.87895 years without knowledge of the Customer or Version ID.

One major security feature is the relatively slow reading time, you will have a hard time finding a commercial reader that can read cards back-to-back at 28 milliseconds each. Generally you get a reading time between 0.1 and 1 seconds.

However, this security is relying on the numbers being uniquely random. If all cards use the same Customer or Version ID and an attacker has knowledge of this Customer or Version ID they have reduced the system entropy by 1,095,216,660,480 potential cards, a 99.61% reduction.

So with the entire security of the system relying on the strength of the random number generator used to program these cards, lets have a look at two separate packs of 51 cards i bought on eBay from China.

99 of the cards had the same Customer or Version ID of 0×06 with the remaining 3 cards having 0×07.

Here is a graph showing the 99 cards in the order they were shipped in with their Customer or Version ID omitted.

![Data capture](/assets/img/posts/2013-06-24/graph.png)

|---------------|---------------|
|**Min:** 		|25773269859	|
|**Max:**		|25785845002	|
|**Range:**		|12575143	    |

Right off the bat you can tell that there is a problem here, the vast majority of cards are a proximity of others. The problem is even worse when the cards have been clustered.

|Cluster|%	    |Mean		    |STD Deviation|
|-------|-------|---------------|-------------|
|1	    |42.42%	|25775067346.5	|14166.12     |
|2  	|39.39%	|25774974455	|11566.25     |
|3	    |10.10%	|25785758931.5	|6361.64      |
|4  	|4.04%	|25785473311.5	|9401.02      |
|5      |1.01%	|25785845002	|N/A One card only|
|6  	|1.01%	|25785343243	|N/A One card only|
|7  	|1.01%	|25773269859	|N/A One card only|
|8  	|1.01%	|25775166994	|N/A One card only|

Even with a more realistic reading time of 0.2 seconds per card you have a 40.4% chance of guessing a valid RFID card within 5666.448 seconds or 95 minutes based on 1 card within cluster 1 alone. Including cluster 2 you have a 78.08% chance of guessing a valid RFID card in under 10292.948 seconds or 172 minutes.

This pattern persisted through two stacks of cards (individually packaged I might add) so if you know the supplier used you could have a good chance of guessing a valid card. The big “security by X” logo stuck on the door can be a big hint here. The clusters appear pretty quickly so buying even 10 cards from a company could be enough to start an attack with good chances.

Another scenario is if you obtain a lost invalid or partially valid (eg. low security areas only) card, you can use that to stage an attack by guessing numbers around it with potentially some success.

However, the addition of even a 2 digit pincode along with the RFID card makes these attacks infeasible on increased input time alone.

Another mitigation strategy is to increase the processing time of cards into the range of seconds. This has the added benefit of not only decreasing the feasibility of such an attack but also not requiring users to change their behavior. This however does not protect from lost or stolen cards like an additional pincode.
