---
layout: post
title: Fixing a broken Samsung 2233 LCD
created_at: 2012-11-05 09:00:00 +0000
kind: article
feature-img: "assets/img/pexels/circuit.jpeg"
thumbnail: "assets/img/pexels/circuit.jpeg"
tags:
  - Electronics
---
I bought 3 Samsung 2233 120hz LCD’s on the cheap before they were being discontinued over a year ago. They are great screens and the 120hz refresh rate is just very nice on the eyes.

However one of them broke! Devastated i immediately took the thing apart. It would turn on for only a second, the back-light would flash and turn off with the LCD still functioning, a broken backlight. Having encounterd the problem many times i immediately thought it was a leaky capacitor. Easy enough thing to fix, replace a few broken capacitors with some from jaycar. However, all the capacitors where 100% fine.

I checked the primary rails of 13v, 5v, 3.3v, and they were all fine when the screen was on. So its not the capacitors or the rails. So I checked the Backlight control lines that lead into the power supply for spikes or changes. Everything still operating as expected.

![Backlight](/assets/img/posts/2012-11-05/Backlight.jpg)

I followed where the control lines lead on the PCB and was lead to a Control chip. After some probing, I noticed one of its feed back lines was out of the expected range according to the datasheet of 1-2v. Its lines connected to a set of transistors that in turn connected to the LCD inverter output.

![Backlight outline](/assets/img/posts/2012-11-05/backlight_outline.jpg)

This meant that either the MOSFET was blown or the transformer was broken. Some probing later and it appeared as if the MOSFET was working fine. I then de-soldered the transformer to measure its coil resistance.

![Coil resistance](/assets/img/posts/2012-11-05/coil_resistance.jpg)

The identical secondary coils where out of sync by a massive 40%! 881 and 1233 ohms respectively. I have zero idea how a passive component could fail like this but it has.

I ordered a replacement off ebay [here](http://www.ebay.com/itm/TM-0915-Inverter-Transformer-for-SAMSUNG-LCD-/150935782915?pt=US_Monitor_Replacement_Parts&hash=item2324794603) and the screen was then fine! The coil resistance was 890 ohms on both secondary coils The feedback loop was then stable at 1.5V. Exactly between the expected range of 1-2V
