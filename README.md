# Project 3 - Web Scraping in Ruby

## ABOUT THIS PROGRAM

Choosing professors when scheduling classes can be a hassle. This program simplifies that process.

Given any class at the Ohio State University, this program outputs the professors that have taught the class in the past, alongside meaningful information about the various professors such as rating, difficulty, etc. Using this information, choosing a professor when scheduling a class becomes much easier.

## HOW TO USE

In order to use this program, first make sure that you are in the correct directory. If you cloned this repo, this directory is called **group-9-Lab3-WebScraping**.

Gems utilized include Mechanize, Nokogiri and Open-URI.

To run the program, type **_exactly_** "ruby main.rb" into the terminal, and press enter.
Two prompts will show up asking you to enter a course subject and a course number. After you enter the course subject and the course number, you can enter '1' to get information from the OSU Class Search or '2' to get information from Coursicle or enter anything else to quit. **_Note_** that getting information from Coursicle may not work on all networks.

You must enter a valid course at the Ohio State University or else the program will not be able to give you the appropriate results.

Using the entered information, the program scrapes data from https://www.coursicle.com/osu/. The data collected covers the professors teaching that specific course. This list of professors is then used to scrape https://www.ratemyprofessors.com/. Using the data from Coursicle and Rate My Professor, professor information such as rating, difficulty, etc. will be output by the program.

This data can be used in the decision-making process when scheduling classes.
