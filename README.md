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

## ABOUT THIS PROGRAM

Choosing professors when scheduling classes can be a hassle. This program simplifies that process. 

Given any class at the Ohio State University, this program outputs the professors that have taught the class in the past, alongside meaningful information about the various professors such as rating, difficulty, etc. Using this information, choosing a professor when scheduling a class becomes much easier.


## HOW TO USE

In order to use this program, first make sure that you are in the correct directory. If you cloned this repo, this directory is called **group-9-Lab3-WebScraping**.

Gems utilized include Mechanize, Nokogiri and Open-URI.

To run the program, type **_exactly_** "ruby main.rb" into the terminal, and press enter.
Two prompts will show up asking you to enter a course subject and a course number. 

You must enter a valid course at the Ohio State University or else the program will not be able to give you the appropriate results.

Using the entered information, the program scrapes data from https://www.coursicle.com/osu/. The data collected covers the professors teaching that specific course. This list of professors is then used to scrape https://www.ratemyprofessors.com/. Using the data from Coursicle and Rate My Professor, professor information such as rating, difficulty, etc. will be output by the program.

This data can be used in the decision-making process when scheduling classes. 
