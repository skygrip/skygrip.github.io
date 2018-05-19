---
layout: post
title: Motorbike Clock Part 1
created_at: 2012-09-02 09:00:00 +0000
kind: article
feature-img: "assets/img/pexels/circuit.jpeg"
thumbnail: "assets/img/pexels/circuit.jpeg"
tags:
  - Motorbike Clock
  - Electronics
---
I got sick of not knowing the time when i ride my motorbike. So i designed a clock to tell the time for me!

Using a [7segment Display from SparkFun](https://www.sparkfun.com/products/9482) a Real Time Clock (I used the ultra accurate DS3232) and a ATMEGA328p.

For the sake of saving space i built it in two layers. This is the first time ive used a SMPS in a design. I used the 5v version of the LM2594 and it was surprisingly simple to use. It worked pretty well. I had originally planned to control the brightness of the display using a LDR but i never implemented this.

![sch](/assets/img/posts/2012-09-02/MotorbikeClockv01sch.png)

![brd](/assets/img/posts/2012-09-02/MotorbikeClockv01brd.png)

After getting the boards made with another order they came out pretty nice.

![brd1](/assets/img/posts/2012-09-02/IMG_0022.jpg)

![brd2](/assets/img/posts/2012-09-02/IMG_0024.jpg)


Covered the 12mm battery in kapton tape to keep it in its holder and insulate it.

![brd1](/assets/img/posts/2012-09-02/IMG_0025.jpg)

![brd2](/assets/img/posts/2012-09-02/IMG_0027.jpg)

Programing it was a sinch! Using a mixture of C, pre existing arduino libs and processing to upload the time. The clock works in 12 hour time and the seconds are shown in binary on the decimal places on the display with 4 second accuracy (one bit equals 4 seconds).
