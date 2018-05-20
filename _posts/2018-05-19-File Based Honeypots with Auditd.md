---
layout: post
title: File Based Honeypots with Auditd
date: 2018-05-19 09:00:00 +1000
feature-img: "assets/img/pexels/computer.jpeg"
thumbnail: "assets/img/pexels/computer.jpeg"
tags:
    - Honeypots
    - Linux
    - Security
    - Auditd
---
Honeypots are all the rage with them being a fantastic tool to quickly identify malicious activity from usual system activity. there aremany kinds of honeypots, including honeypot ports (honeyports) and even entire honey networks (honeynet), however the one i want to talk about is honeypot files (honeyfiles).

These are files that can be placed on a filesystem that are designed to look entising, and when accessed trigger an auditd rule to let you know.

Honeyfiles are super easy to setup on 
