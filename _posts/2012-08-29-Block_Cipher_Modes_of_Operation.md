---
layout: post
title: Block Cipher Modes of Operation
created_at: 2012-08-29 09:00:00
kind: article
feature-img: "assets/img/posts/2012-08-29/Mode-of-operations-comparison.jpg"
thumbnail: "assets/img/posts/2012-08-29/Mode-of-operations-comparison.jpg"
tags:
  - Cryptography
---
There is more to encryption than just a fancy cipher. A badly implemented encryption method can be just as bad as an insecure cipher. One of the factors when choosing how to encrypt a file is the mode of operation.

Say you are working on a brand-new top secret tank design. You have finished the blueprints and now you need to send it halfway across the country to be built. Due to the nature of this special tank you need to ensure that it is kept a secret so you decide to encrypt the plans with AES.
You pre-shared a key the last time you where at the manufacturing facility so the key is secure but you use vanilla AES-128-ECB (Electronic codebook) encryption, where every block of the file is simply encrypted using the key.

    $ openssl aes-128-ecb -in M1A1.BMP -out M1A1-ecb.BMP
    enter aes-128-cbc encryption password: ****
    Verifying – enter aes-128-cbc encryption password: ****

However, during transport a 3rd party was able to intercept the files. They were not able to decrypt the file as they did not know the encryption key, but they were able to copy the BMP header from another similar sized file.

    $ dd if=M1A1.BMP of=M1A1-ecb.BMP bs=1 count=54 conv=notrunc

When they opened the file in a image program, they were able to get a rough outline of the image.

![Cipher Modes](/assets/img/posts/2012-08-29/Mode-of-operations-comparison.jpg)

<!-- more -->

There is not enough information to independently construct the tank, but they can see what is being worked on. This happens due to problems in how repetitive data is encrypted and is a problem with all major encryption standards. When you encrypt 2 identical blocks of data, you can expect it to have the same output. Images can have large blocks of color that are identical. Because of this, when rendered in an image program you can get an outline like above.
Because of this there was a need for new ways to encrypt data so that it appears as completely unreadable data such as in the AES128 CBC example above. One of the most popular ways of doing this is by using Cipher-block chaining (CBC). This is the default mode for encrypted ZIP files and by far the most common of all modes.

![Cipher Modes](/assets/img/posts/2012-08-29/Cbc_encryption.png)

Here there is an addition of a Initialization Vector (IV) and the input is different for every block. The key is a product of the previous data so similar plain-text blocks do not equal the same encrypted blocks. The Initialization Vector (IV) is added as to guarantee uniqueness for the first and successive blocks. The Initialization Vector (IV) is considered public information and is normally included in the beginning of the file. It is however important to never use the same Initialization Vector (IV)/password pair as doing so may give away information about the first block of data. Generally the Initialization Vector (IV) is randomly generated.

![Cipher Modes](/assets/img/posts/2012-08-29/Ctr_encryption.png)

Another method of introducing this random propagation to the cypher-text is by transforming the block cypher into a stream cypher. Using it to create a key-stream by encrypting a increasing counter using a secret key and XOR’ing that with the plaintext. This has the added benefit of not requiring padding of data as a precise length of key-stream can be created. This is called Counter (CTR) mode. Some people feel that having such a systematic input is an unnecessary risk so the addition of a Initialization Vector (IV) added in some way to the counter recommended. However, the Security of this mode is largely dependent on the security of the underlying block cipher.

This mode has the benefit of being able to encrypt and decrypt any block using parallel computations making it very suitable for disk level encryption. Random access and even pre-processing making this one of the fastest common modes and also the simplest to implement.

One of the problems, especially with CTR and CBC is that while you have confidentiality you do not have integrity or authenticity. For this reason modes that provided confidentiality, integrity and authenticity where developed and are referred to as Authenticated Encryption Modes.

One such mode is Counter with CBC-MAC (CCM). It has the requirement of 128-bit blocks such as AES. It uses a Counter (CTR) Mode for confidentiality and CBC-MAC for integrity and authenticity. While these steps are normally considered independent there are implementations that are not secure so this standard defines a good interleaving of data before combination with the key-stream. This way any change to the data will result in a large and unpredictable change in the MAC, showing proof if the data has been tampered. This however comes at the cost of data expansion. The MAC takes up space at the cost of improved security.

I won't go into the detail of how this mode works as it is very complex but I will mention that its major disadvantage is that it is very slow and has no support for parallel computation. For this reason Galois/Counter Mode (GCM) is preferred for high speed communication. Its major speed improvement is the use of a much faster hash function, but uses the CTR (counter) mode for confidentiality like CCM.

Some modes are purpose built or chosen to serve certain functions. Counter (CTR) for example is very useful for fast, random-access and parallel computation and because of this it is very useful for hard drive storage. Hard drives are already split up into blocks known as sectors so you could easily use the sector number as the counter and achieve hard drive encryption with very little modification of a file-system driver.

However, this would raise various other problems unique to hard disk drives such as differences between logical and physical sectors so the XEX-based tweaked-codebook mode with cipher-text stealing (XTS) was created with the purpose of securely encrypting block based storage devices. It does not provide full integrity and authenticity protection but does provide some limited protection from malicious manipulation of encrypted data. This limitation is due to a design decision to avoid data expansion caused by adding integrity and authenticity.

There are various modes of operation with block based cyphers, the exact mode that should be used depends highly on the work being done. There are many other modes not mentioned here but have similar purposes to the modes already mentioned above. In computer security the weakest link is often enough to break the rest of the system. Plain encryption alone is not enough to secure your data.
