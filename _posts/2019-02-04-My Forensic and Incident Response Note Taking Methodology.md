---
layout: post
title: 'My Forensic and Incident Response Note Taking Methodology'
DateTime: 2019-02-04 17:00:00 +1100
feature-img: "assets/img/pexels/book-glass.jpeg"
thumbnail: "assets/img/pexels/book-glass.jpeg"
tags:
    - Cyber Security
    - Cyber Intelligence
    - Forensics and Incident Response
---

# Why You Should Take Good Notes During Forensic and Incident Response

Note taking is critical during Incident Response and Forensics of any kind. It is however very easy fail to take notes, especially when time is a constraint, it can be very tempting to forgo notes for the sake of speed or lack of perceived complexity, however in pretty much every instance this is a mistake. The scope of incidents can expand, their criticality can increase, and its even possible law enforcement could get involved.

On the other hand, going to the extra effort of having good notes can help you be calm and prepared. Here are just a few of the ways good notes can help you:

-   **Save time:** Avoiding doing the same thing twice! When you record your findings and how you got there, you don't need to constantly backtrack.
-   **Manage Stress and Burnout:** Its very easy to get overwhelmed from pressure and the huge amount of information, good notes give you the confidence to let things fade from mind and relax at the end of the day.
-   **Reproducibility:** Having good notes ensures that you have the right amount of detail to repeat previous commands to validate output, and justify working hypothesises. Without reproducibility all your findings could be brought into question.
-   **Work in a Team:** No one wants to inherit a project that has no documentation, or work on the exact same thing at the same time, but they will love you if you have detailed notes and documentation. Detailed notes describe where you are at in your investigation and help prevent you taking phone calls while you are on vacation.
-   **Refresh your Memory:** Occasionally you will need to come back to an investigation weeks, months, or years later. Having detailed notes ensures that you have a good chance of remembering what happened.
-   **Easily Produce Great Status Updates and Reports:** When you have great notes, then the hard work is already done for you! You can communicate what you have done, what you have found, and harbour questions with confidence.
-   **Navigate Misleading and Uncertain Data:** At some point you will encounter evidence that contradicts other evidence, or simply doesn't make sense. Good notes allow you to record this as evidence, while making it clear how the evidence was collected. Fields like file timestamps cant always be trusted, but by having the right notes available you can consider their legitimacy during analysis, or even track the use of Anti-Forensic techniques.
-   **Good notes cover your ass:** Good notes can keep you from missing key observations, making mistakes, getting fired, being grilled by lawyers, and looking down the barrel of the law. You have evidence of what you did, when, where, why, how, and for how long, its going to be much harder for anyone to question the legitimacy of the work you have done, challenge your findings, or claim credit for your hard work.

# Breaking it all Down

My methodology is built on top of the Discovery and Note-Taking process described in ["Find Out Anything From Anyone, Anytime" by James Pyle and Maryann Karinch](https://www.amazon.com/Find-Out-Anything-Anyone-Anytime-ebook/dp/B00HEZF9J6). This book is a must read for anyone who works as a consultant, or works in unfamiliar environments and needs to learn everything about that environment in a very short time.

The methodology involves placing information uncovered during investigation into 4 Discovery Areas, People, Places, Things, and Events in Time. As information is uncovered you add notes to the relevant categories. Additionally meta notes are added to each note to describe who, when, where, why, and how those notes were created. These additional meta notes are key to this methodology.

I have found that this system works well to categorise notes into similar areas and help analyse the data and produce reports, and have used it multiple times with real world incident response to great success.


# Discovery Area: People

People is the first discovery area and it covers information relating to people. This includes things like Names, but may also include information about their job role, contact information, projects they are working on, and other information that describes them as a person.

You should make notes on every person you talk to as part of your incident response. It makes it much easier to refer to them in the future, contact them if needed, and remember their name.

Suggested Mandatory fields:

| Item                 | Description                                           |
| -------------------- | ----------------------------------------------------- |
| Given Name:           | Their legal Given name, be conscious that in some cultures a persons Given Name is after their Family Name |
| Family Name:          | Their legal Family Name, be conscious that in some cultures a persons Given Name is after their Family Name |
| Preferred Name:       | Any nicknames or preferred names separate from their legal name |
| Occupation:           | Their Occupation, Employment Status, Job Title |
| Company:              | The Company they work for |
| Email:               | Their Email Address, note that an individual may have several email addresses |
| Office Phone Number:        | Their office phone number |
| Mobile Number:        | Their Mobile Number |
| Office Desk Location: | Their desk location, this information can help you physically find this individual if necessary, and their physical office desk location could be relevant to the case. i.e. Ethernet port numbers |
| Information Source:  | From where the information was gathered.<br><br> For example the person who gave you this information, the command used to gather this information, the system where this information came from. |
| Note DateTime Added:     | The date and time the note was taken in ISO date time format |
| Note Added By:       | The name of the analyst or responder working this case who added this note |

Other Suggested fields:

| Item               | Description                                             |
| ------------------ | ------------------------------------------------------- |
| Projects | Projects they are working on |

# Discovery Area: Places

Places is information related to addresses, rooms in a building, buildings, and other objects that would not be considered to be physically movable in the real world.

| Item                | Description                                            |
| ------------------- | ------------------------------------------------------ |
| Location Description: | A description of the location, an Address, GPS Coordinates, Directions on how to get to the location. |
| Information Source: | From where the information was gathered.<br><br> For example the person who gave you this information, the command used to gather this information, the system where this information came from. |
| Note DateTime Added:    | The date and time the note was taken in ISO date time format |
| Note Added By:      | The name of the analyst or responder working this case who added this note |


# Discovery Area: Things

Things includes physical objects (bicycle, mobile phone), Digital objects, processes, and concepts. This section does not have to contain information describing physical objects, for example capitalism isn't physical, but it is a Thing.

Suggested Mandatory fields:

| Item                | Description                                            |
| ------------------- | ------------------------------------------------------ |
| Thing Description:   | A description of the thing                             |
| Information Source: | From where the information was gathered.<br><br> For example the person who gave you this information, the command used to gather this information, the system where this information came from. |
| Note DateTime Added:    | The date and time the note was taken in ISO date time format |
| Note Added By:      | The name of the analyst or responder working this case who added this note |

Other Suggested fields:

| Item               | Description                                             |
| ------------------ | ------------------------------------------------------- |
| Evidence location: | The location where this evidence can be found. For example system logs or camera footage of the event saved to a network drive. |
| Evidence Hash:      | The cryptographic hash of the evidence collected.       |
| Forensic Tool Used: | The tool used to identify the Thing.<br><br> Also include the version of the software and any relevant plugins and plugin versions. Its possible that changes in software versions produce different results and this could sour the investigation. |

# Discovery Area: Events in Time

These are events that have the metadata of time. This is likely to be your largest and most detailed Discovery Area after an incident.

Its not uncommon when adding to this section that notes will follow the order that you added them, not their chronological order. If you are using a computer it can help to sort your notes by DateTime to better understand the series of Events in Time.

Suggested Mandatory Fields:

| Item                | Description                                            |
| ------------------- | ------------------------------------------------------ |
| DateTime:           | The date and time of the event in ISO date time format |
| Event Description:   | A description of the event that has taken place       |
| Information Source: | From where the information was gathered.<br><br> For example the person who gave you this information, the command used to gather this information, the system where this information came from. |
| Note DateTime Added:    | The date and time the note was taken in ISO date time format |
| Note Added By:      | The name of the analyst or responder working this case who added this note |

Other Suggested Fields:

| Item                | Description                                            |
| ------------------- | ------------------------------------------------------ |
| Evidence location: | The location where this evidence can be found. For example system logs or camera footage of the event saved to a network drive. |
| Evidence Hash:      | The cryptographic hash of the evidence collected.      |
| Serial Number:      | Serial number of a Hard Drive                          |


# Putting it All Together, an Example - Formwork Incorporated

Here i have created an example incident that is currently underway using this methodology, see if you can answer these hypothetical questions using the notes:
-   When did the investigation start?
-   Who is the point of contact during the engagement?
-   Why was incident response triggered?
-   Why is Oliver Nixon of interest?
-   In what room number in what building should the backup tape have been?



| People | Places | Things | Events in Time |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Given Name: Lauren <br> Family Name: Woods<br> Preferred Name: N/A <br> Occupation: Head of IT <br> Company: Formwork Incorporated <br> Email: Lwoods@example.com  <br> Office Phone Number: 1234 5678  <br> Mobile Phone Number: 04 1234 5678 <br> Office Desk Location: Seat 24, Level 4 <br>  <br> Point of contact during engagement<br> <br> Information Source: Lauren Woods Phone Call<br> Note DateTime Added: 2019-01-05 08:10:00+11:00 <br> Note Added By: Analyst Bob | Formwork Incorporated Head Office <br>  70 Snake Hill St. Niles, MI 49120.  <br> <br> Information Source: Lauren Woods Phone Call <br> Note DateTime Added: 2019-01-05 08:10:00+11:00 <br> Note Added By: Analyst Bob | Missing Backup Tape containing sensitive data. Tapes are stored in the server room <br>  <br> Information Source: Lauren Woods during Interview <br> Note DateTime Added: 2019-01-05 09:05+11:00 <br> Note Added By: Analyst Bob | DateTime: 2019-01-05 08:00:00+11:00<br> Duration: 30 minutes <br> Phone Call From Lauren Woods. Requested to come onsite to Formwork Incorporated Head Office to investigate a missing backup tape<br> <br> Information Source: Analyst Bob’s<br> Note DateTime Added:  2019-01-05 08:10:00+11:00<br> Note Added By: Analyst Bob |
| Given Name: Jonty<br> Family Name: Cooper<br> Preferred Name: John <br> Occupation: Shipping Manager <br> Company: Formwork Incorporated <br> Email: Lwoods@example.com <br> Office Phone Number: 1234 5679 <br> Mobile Phone Number: 04 1234 5679 <br> Office Desk Location: Seat 11, Level 2 <br>  <br> Working on a project addressing warehouse inventory problems <br>  <br> Data Source: Lauren Woods <br> Note DateTime Added:2019-01-05 09:30:00+11:00  <br> Note Added By: Analyst Bob | Server Room, Level 2 of Formwork Incorporated Head Office <br> <br> <br> Information Source: Lauren Woods Interview<br> Note DateTime Added: 2019-01-05 09:15:00+11:00<br> Note Added By: Analyst Bob | Camera outside Server Room door <br>  <br> Information Source: Jonty Cooper during interview<br> Note DateTime Added: 2019-01-01 09:35:00+11:00 <br> Note Added By: Analyst Bob | DateTime: 2019-01-05 09:00:00+11:00 <br> <br> Begun Interviewing Lauren Woods about missing backup tape.<br> <br> Information Source: Analyst Bob<br> Note DateTime Added:  2019-01-05 09:00+11:00<br> Note Added By: Analyst Bob |
| Given Name: Oliver<br> Family Name: Nixon<br> Preferred Name: N/A <br> Occupation: Sales Representative <br> Company: Formwork Incorporated <br> Email: ONixon@example.com <br> Office Phone Number: 1234 5680 <br> Mobile Phone Number: 04 1234 5690 <br> Office Desk Location: Seat 4, Level 6 <br> <br> Information Source: Lauren Woods <br> Note DateTime Added: 2019-01-05 10:15:00+11:00 <br> Note Added By: Analyst Bob |  |  | DateTime: 2019-01-05 09:25:00+11:00<br> <br> Finished Interviewing Lauren Woods<br> <br> Information Source: Analyst Bob<br> Note DateTime Added:  2019-01-05 09:30:00+11:00<br> Note Added By: Analyst Bob Evidence Location: 2019-01-05_09:30:00.mp3 Evidence Hash: 9874359873459438480948 |
|  |  |  | DateTime: 2019-01-05 09:30:00+11:00<br> <br> Begun interviewing Jonty Cooper whose desk is located next to the server room<br> <br> Information Source: Analyst Bob<br> Note DateTime Added:  2019-01-05 09:30:00+11:00<br> Note Added By: Analyst Bob |
|  |  |  | DateTime: 2019-01-05 10:00:00+11:00<br> <br> Finished Interviewing Jonty Cooper <br> <br> Information Source: Analyst Bob<br> Note DateTime Added:  2019-01-05 10:00:00+11:00<br> Note Added By: Analyst Bob Evidence Location: 2019-01-05_10:00:00.mp3 Evidence Hash: 9874359873459438480948 |
|  |  |  | DateTime: 2019-01-05 10:10:00+11:00<br> <br> Begun reviewing camera footage<br> <br> Information Source: Analyst Bob<br> Note DateTime Added:  2019-01-05 10:10:00+11:00<br> Note Added By: Analyst Bob |
|  |  |  | DateTime: 2019-01-04 11:24+11:00<br> <br> Camera Footage Showing Oliver Nixon entering Server Room.<br> <br> Information Source: Camera 3 Video Footage<br> Note DateTime Added:  2019-01-05 10:15:00+11:00<br> Note Added By: Analyst Bob |
|  |  |  | DateTime: 2019-01-04 11:27+11:00<br> <br> Camera Footage Showing Oliver Nixon Leaving Server Room.<br> <br> Information Source: Camera 3 Video Footage<br> Note DateTime Added:  2019-01-05 10:20:00+11:00<br> Note Added By: Analyst Bob<br> <br><br> Evidence Location: E:/Cases/Case332/Camera3VideoFootage.mp4 Evidence Hash: 12438398462786437823647832 |
|  |  |  | DateTime: 2019-01-05 10:30:00+11:00<br> <br> Finished reviewing camera footage<br> <br> Information Source: Analyst Bob<br> Note DateTime Added:  2019-01-05 10:30:00+11:00<br> Note Added By: Analyst Bob |

# Handling Note Integrity, Mistakes, and Corrections
Mistakes happen, but how you handle your mistakes can be critical to ensuring you have a solid feet to stand on. Notes that have been altered after the date they were created can be brought into question and potentially dismissed.

The Acronym "NO ELBOWS" can be used to describe some note taking rules to help ensure that your notes have a good chance of being usable in court.

>**NO E**rasures<br>
>**NO L**eaves Torn out<br>
>**No B**lank Spaces<br>
>**No O**verwriting<br>
>**No W**riting Between Lines<br>
>**S**tatements must be written in 'Direct Speech'<br>

Only some of these will be relevant to digital notes.

When you find a mistake, don't directly correct it, instead mark the note with a ~~strikethrough~~, but still readable, and then create a new note replicating the original with the correction you intend to make, and then ensure the *"Note DateTime"* data is updated with the current time.

For example to correct a mistake to an address in the Places discovery area, you can do the following. The **bold** is used for illustrative purposes only.

|Places|
|---|
|~~Formwork Incorporated Head Office<br>70 Snake Hill St. Niles, MI 49120.<br><br>Information Source: Lauren Woods Phone Call <br>Note DateTime Added: 2019-01-05 08:10:00+11:00 <br>Note Added By: Analyst Bob	<br>~~|
|Formwork Incorporated Head Office<br>**75 Snake Hill St. Niles, MI 49120.**<br><br>Corrected address from 70 Snake Hill St, 75 Snake Hill St<br><br>Information Source: Lauren Woods Phone Call <br>**Note DateTime Added: 2019-01-05 12:35:00+11:00** <br>Note Added By: Analyst Bob	<br>|

# Digital or Physical Notes
There are some pretty significant differences between physical notes and digital notes, and in general i would suggest you use whatever works best for you and your team. However there are a few pros and cons to be aware of and consider before you settle in on a choice.

## Digital Notes
Pros:

*   Copy and Paste saves a considerable amount of time and reduces the chances of errors being introduced
*   Screenshots can be added to your notes without the use of cameras and printers
*   Working in a team is significantly easier when you can digitally share notes
*   Collected Intelligence can be easily exported to reports, or external programs for further analysis
*   Offsite or cloud based backups are easy to setup

Cons:

*   Digital notes are likely to attract questions about how you can prove your notes have not been modified. Depending on the answer the notes could be dismissed as evidence in court.
*   Security of the digital notes is critical, as an attacker could in theory gain access to the notes and know exactly where you are at in the investigation and use it to keep one step ahead of you. When starting an investigation it could be difficult to determine if the computer you are using to take notes on is already compromised.

## Physical Notes

Pros:

*   Physical notes are less likely to be dismissed as evidence in a court of law
*   Malicious modifications to notes are more difficult to perform without the analyst noticing
*   Eavesdropping on physical documents is significantly more difficult from the digital world

Cons:

*   Lack of Copy and Paste make copying out notes highly time consuming and error prone
*   Cooperation in a team is much more complicated with physical notes
*   Secure storage locations and physical backups can be complicated to setup and maintain
*   Depending on your handwriting, your notes may not be independently legible enough to be usable

# Conclusion
Note taking is time consuming, but it has enough benefits that make it a worthwhile investment. You may find it difficult to determine what Discovery Area a note should fit into, but ultimately it doesn't matter so long as you still write that note. I have shared this methodology in the hope that it may help others to ensure that they take good notes during incident response, but ultimately how well it works is up to you, use whatever note taking system works best for you. If you work in law enforcement this note taking system might not work for you for example, it may not fulfil the requirements needed to keep you out of trouble in court. If you have any questions or would like to contribute useful suggested fields send me an email by vising the about page.

# References and Links
During the research of this methodology and writing this blogpost i read the following:

*   <https://www.amazon.com/Find-Out-Anything-Anyone-Anytime-ebook/dp/B00HEZF9J6>
*   <https://www.forensicnotes.com/ms-word-and-onenote-should-never-be-used-for-contemporaneous-notes/> #NotSponsored
*   <https://www.wiltshire.police.uk/media/1603/Pocket-Notebooks-Procedure/pdf/Pocket_Notebooks_Procedure.pdf>
*   <https://bitofhex.com/2018/08/02/contemporaneous-notes/>
*   <https://brettshavers.com/entry/brett-s-notes-on-note-taking>
*   <https://windowsir.blogspot.com/2018/08/notes-etc.html>


# Version History

| Date       | Update Note     |
|------------|-----------------|
| 2019-02-04 | Initial post    |
| 2019-02-10 | Added "Reproducibility" as a note taking benefit.<br> Added "Digital or Physical Notes", "Handling Note Integrity, Mistakes, and Corrections", and "References and Links" sections. |
