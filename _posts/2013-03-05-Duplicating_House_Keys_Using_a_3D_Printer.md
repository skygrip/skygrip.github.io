---
layout: post
title: Duplicating house keys using a 3d printer
created_at: 2013-03-05 09:00:00 +0000
kind: article
feature-img: "assets/img/posts/2013-03-05/IMG_0255.jpg"
thumbnail: "assets/img/posts/2013-03-05/IMG_0255.jpg"
tags:
    - 3D printing
    - Physical Security
    - Security
 
header-includes:
    - \hypersetup{colorlinks=true}

---

I had the idea to duplicate some house keys on my Makerbot Thing-O-Matic 3D printer after seeing a post about in on thingiverse [here](http://www.thingiverse.com/thing:8925).

So after messing around with the script provided by usr nrp for a while I couldn't really get it to work so i decided to just make a script from scratch to improve my SCAD skills. (SCAD is like a programing language for creating parametric 3d CAD objects)

After a few hours with a key and a pair of digital calipers I got an object that fit in the lock but has not been cut (think of a blank key).

![Key Blank Openscad](/assets/img/posts/2013-03-05/key.jpg)

![Blank comparison - front](/assets/img/posts/2013-03-05/Blank-comparison-2.jpg)

![Blank comparison - Top](/assets/img/posts/2013-03-05/Blank-comparison.jpg)

From there i started working on the cuts. On this particular key the cut depth appeared to be a multiple of 0.58mm with spacing from every cut being equal to 4.12mm. Some of these measurements where gained by using [this cheat sheet](http://web.archive.org/web/20050217020917fw_/http://dlaco.com/spacing/tips.htm).

This step was mostly trial and error, i made modifications halfway through to reduce printing time and many modifications to the multipliers, cut depths, ect…

![All keys](/assets/img/posts/2013-03-05/IMG_0255.jpg)

Eventually came up with some results as shown above. After the measurements where perfected, the keys started to work. The keys are brittle but most locks don’t have much resistance turning the key when the key fits. The use of a torsion bar from a lock pick set to turn the lock could be used on rusted or heavy locks.

Every key has a bit-code, this is a set of numbers that identify the key’s ID number. Any similar style key with the same bit-code will work in the same lock. I was able to guess the bit-code but this photo will show what im doing. We are measuring the dips and not the ridges, the ridges exist to ensure the tumbler pins rest in place.

Note: In my script the bit-code goes from base to tip, other scripts or even official documentation may be different.

![BitCode](/assets/img/posts/2013-03-05/BitCode.jpg)

The keys only have 7 ridges based on documentation linked above. This gives a total key-space of 7^7 or 823,543 different combinations.

With such a small combination of ridges its not hard to see why lock-picking isn’t difficult. Not only that but the keys are pretty easy to duplicate based off visual identification, the SNEAKEY system deminstrated this as shown [here](http://www.schneier.com/blog/archives/2011../duplicating_phy.html).

![OpeSCAD Render](/assets/img/posts/2013-03-05/OpeSCAD-Render.png)

![Cut comparison](/assets/img/posts/2013-03-05/Cut-comparison.jpg)

![Cut - Lock](/assets/img/posts/2013-03-05/CutLock.jpg)

In total i did this entire project in just a few hours, its scary how simple many of these keys are in design. I would estimate that i could duplicate high security keys in a similar time if my printer has the accuracy. Sure some of these high security keys are very difficult to pick but if all it takes is visual inspection of a key to breach a lock then this presents a problem for people who wish to keep things behind locked doors.
