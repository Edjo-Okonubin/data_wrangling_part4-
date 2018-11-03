###Load required packages
library(tidyverse)

glimpse(msleep)

###COUNTING CASES AND ADDING COUNTS----
#1.) Counting the number of observations:
#The easiest way to count the number of observations for s pecific variable is to use 
# use count(). BY adding the sort= TRUE argument, it immediately returns a sorted table
#with descending number of rows.

msleep %>% 
  count(order, sort= TRUE)

#Adding multiple variables
msleep %>% 
  count(order, vore, sort = TRUE)

#2. Adding the number of observations in a column
msleep %>% 
  tally()

msleep %>% 
  select(1:3) %>% 
  add_tally()

msleep %>% 
  select(name:vore) %>% 
  add_count(vore)

####SUMMARIZING DATA

msleep %>% 
  summarise(n = n(), average = mean(sleep_total), maximum = max(sleep_total))

#Summarise by group
msleep %>% 
  group_by(vore) %>% 
  summarise(n=n(), average = mean(sleep_total), maximum =max(sleep_total))

#SUMMARISE ALL----
#1. Summarise all
msleep %>% 
  group_by(vore) %>% 
  summarise_all(mean, na.rm=TRUE)

#2. Summarise all using a function on the fly
msleep %>% 
  group_by(vore) %>% 
  summarise_all(~mean(., na.rm = TRUE) + 5)

#3. Summarise_if
msleep %>% 
  group_by(vore) %>% 
  summarise_if(is.numeric, mean, na.rm = TRUE)

#4. Renaming aggregate summarise function
msleep %>% 
  group_by(vore) %>% 
  summarise_if(is.numeric, mean, na.rm = TRUE) %>% 
  rename_if(is.numeric, ~paste0("avg_", .))

#5. summarise_at
#The function summarise_at() requires two arguments; the columns to be considered and
# information on how to summarise the data. First, it is necessary to wrap the columsn to be 
#considered inside a vars() statement. The code below will return the average of all
#columns that contain the word "sleep", and also rename them to "avg_var" for clarity.


msleep %>%                  #Take msleep dataset, and then...
    group_by(vore) %>%      # Group by the variable "vore"
  summarise_at(vars(contains("sleep")), mean, na.rm = TRUE) %>% #Summarise all columns containing "sleep" and return average
  rename_at(vars(contains("sleep")), ~paste0("avg_", .)) #rename the results

