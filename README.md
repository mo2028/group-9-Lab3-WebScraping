# Lab 3 - Web Scraping in Ruby

Write a Ruby program to scrape and process some interesting data from a publicly accessible OSU site. Some possibilities are:

Careers at Ohio State
OSU News Room
Courses as listed by the registrar
CSE Class Schedules
For example, your program might search the OSU jobs site for all job postings related to HTML or CSS. You could even use a cron job (see cron and crontab) to run the script, so that every morning your script queries for particular job postings, creates a digest, and sends you an email with the results.

As another example, you could automate the process of figuring out how many credits each course in a given list of courses is worth. For example, given a text file with the course numbers of all the GEC courses that count in the "Social Science" category, your tool would return the credit load of each individual course!

You can use whatever source for data you like, provided it is an OSU source and is publicly visible. Non-OSU sources may also be acceptable; ask me first if you find something that interests you. There are other sources of data available that provide data in an xml or json format; those are also acceptable for this project but may require additional research on your part for how to interact with those formats in Ruby.

If you are doing many successive queries, you must space them out in time (eg using sleep between successive GETs) so as to not overload the server. You can do whatever scraping and processing you like, provided the result is interesting and doesn't violate any department or university policies.
