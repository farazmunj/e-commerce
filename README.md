[![Build Status](https://travis-ci.org/farazilu/CakeDays.svg?branch=master)](https://travis-ci.org/farazilu/CakeDays)

# CakeDays

This utility should receive as an input a text file containing a list of employee birthdays, in
the following format with one entry per line:
*Person Name, Birthday (yyyy-mm-dd)*
The utility should output a CSV detailing the dates we have cake, in the following format:
*Date, Number of Small Cakes, Number of Large Cakes, Names of people getting cake*

“Cake Days” are calculated according to the following rules:

 - A small cake is provided on the employee’s first working day after
   their birthday.
 - All employees get their birthday off.
 - The office is closed on weekends, Christmas Day, Boxing Day and New Year’s Day.
 - If the office is closed on an employee’s birthday, they get the next
   working day off.
 - If two or more cakes days coincide, we instead provide one large cake
   to share.
 - If there is to be cake two days in a row, we instead provide one
   large cake on the second day.
 - For health reasons, the day after each cake must be cake-free. Any
   cakes due on a cake-free day are postponed to the next working day.
 - There is never more than one cake a day.
