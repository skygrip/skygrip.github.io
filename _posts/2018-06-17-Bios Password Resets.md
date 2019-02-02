---
layout: post
title: 'Bios Password Resets The Hard Way'
date: 2018-06-17 09:00:00 +1100
feature-img: "assets/img/posts/2018-06-17/20180617_over.jpg"
thumbnail: "assets/img/posts/2018-06-17/20180617_over.jpg"
tags:
    - Electronics
    - Cyber Security
---

Sometimes you forget the password on your new [System76 Galiga Pro 3](https://system76.com/laptops/galago) laptop and you don't realise until you broke your bootloader and need to change your boot order manually.

And while im sure the kind people over at System76 would be more than able to assist you with this problem, its much more fun if you fix it yourself. In this post we will be reflashing the BIOS EEPROM manually.

You used to be able to reset the BIOS password by simply removing the CMOS battery, but these days the battery is less about keeping volatile storage readable, and more about maintaining the real time clock. Let's have a look at how it works these days by looking at the System Block Diagram.

![System Block Diagram](/assets/img/posts/2018-06-17/System Block Diagram.png)

We are looking for something that stores a BIOS firmware image. Right next to the Processor on the left is a block called "BIOS SPI", this is the chip that contins the BIOS firmware image. It's usually an 8 pin EEPROM chip, and now that we know that it plugs into the CPU directly, we know it's going to be located on the board somewhere close to the processor.

The system schematic from the service manual shows the chip labeled U22 and it's a 64bit SPI EEPROM chip.

![SPI Chip](/assets/img/posts/2018-06-17/SPI.png)

The chip in our board isn't a GD25B64CSIGR as labeled in the schematic, but it's a MX25L6473F, and equivlient chip. Let's have a look at the pinout from the [MX25L6473F datasheet](http://www.macronix.com/Lists/Datasheet/Attachments/6731/MX25L6473F,%203V,%2064Mb,%20v1.3.pdf).

![SPI pinout](/assets/img/posts/2018-06-17/MX25L6473F_pinout.png)

Now that we know the pinout, we can solder on some wires to interact with this chip using a [Bus Pirate](http://dangerousprototypes.com/docs/Bus_Pirate). We need to solder every pin except for SIO2 and SIO3 as they are optional.

![Soldered SPI chip](/assets/img/posts/2018-06-17/20180617_0021.jpg)

Now all we need to do is grab the firmware from [system76's firmware website](https://firmware.system76.com/master/) and flash the chip with the Bus Pirate. Only system76's firmware site isn't easy to understand, and it contians every system76 laptop. To find the firmware image i needed, i downloaded every firmware zip file and extracted the firmware.rom file in search of the model number mated to my laptop. I found the Clevo model number shows up just before the string "DATE:". I eventually found the right one.

    strings firmware.rom | grep -i "DATE:"
    PRJ:N130WU$DATE: 2017/10/31$VER: 1.05.02$

We can now flash the firmware using [flashrom](https://github.com/flashrom/flashrom), lucky for us it has Bus Pirate support. Ensure the laptop is disconnected from power before running flashrom.

    ./flashrom --programmer buspirate_spi:dev=/dev/ttyACM0 -c "MX25L6436E/MX25L6445E/MX25L6465E/MX25L6473E/MX25L6473F" -w ~/Downloads/firmware.rom

Success! Not only have we fixed the booting issues, but we have reset the password!
