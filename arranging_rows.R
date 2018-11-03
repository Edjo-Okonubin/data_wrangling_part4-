#Load required packages-----
library(tidyverse)

###ARRANGING ROWS-----
#It is useful to arrange your summary tables. This is done using the arrange() function. 
#the default mode of this function is to sort ascending, but you can add the desc() argument
#in your call to reverse the result. Note that for string variables, it will sort alphabetically.

##Sorting numeric variables:

msleep %>% 
  group_by(vore) %>% 
  summarise(avg_sleep = mean(sleep_total)) %>% 
  arrange(desc(avg_sleep))

#If you had already grouped your data, you can refer to that group within the 
#arrange() within the arrange statement as well as by adding the .group=TRUE statement.
#As shown in the code below, this will sort by descending total sleep time, but within
#each group.

msleep %>%                                #Take msleep dataset, and then...
  select(order, name, sleep_total) %>%    # Select variable of interest
  group_by(order) %>%                     # Group the selected variables by "order"
  arrange(desc(sleep_total), .by_group = TRUE) #Arrange the "sleep_total column" in descending format within each group


###SHOWING ONLY PART OF YOUR DATA----
#In some cases you just do not want to show all rows available. In such
# situations you may use the following short cuts to save you a lot of time.

#Show the five highest and lowest figures.
#Technique 1: combining arrange() function with head(n=5) statement.
#the top 5 values

msleep %>%                #Take msleep dataset, and then...
  group_by(order) %>%     # Group dataset by "order" variable
  summarise(average = mean(sleep_total)) %>%  #Take the average of total sleep hours by group
  arrange(desc(average)) %>%   # Sort the results in descending order from highest to lowest
  head(n = 5)                  # show the first 5 values

# the lowest 5 values

msleep %>%                  #Take msleep dataset, and then...
  group_by(order) %>%       # Group dataset by "order" variable
  summarise(average = mean(sleep_total)) %>% #Take average of total sleep hours per group
  arrange(average) %>%      # Sort the results from lowest to highest
  head(n=5)                 # Show the first five values

#Technique2: using the top_n() function.Note that this function will retain the top five values unsorted.
#Top 5 values:

msleep %>% 
  group_by(order) %>% 
  summarise(average = mean(sleep_total)) %>% 
  top_n(5)


#Lowest 5 values:

msleep %>%              #Take msleep dataset, and then...
  group_by(order) %>%   # Group it by "order" variable
  summarise(average=mean(sleep_total)) %>%  #Take average of sleep_total per group
  top_n(-5)             # Show lowest 5 values of average total sleep per group

###Dealing with more than one column----
#Just add the variable you want to use and proceed as before.

msleep %>%      #Take msleep dataset, and then...
  group_by(order) %>%  #Group by "order" variable
  summarise(average_sleep = mean(sleep_total), max_sleep = max(sleep_total)) %>%  #take average of variable "sleep_total", and maximum value of sleep_total
  top_n(5, average_sleep) #Display top five values of average sleep per group

###Conducting a random selection of rows:
#Technique 1: using sample_n() function.

msleep %>%      #Take msleep dataset, and then...
  sample_n(10)  # Select a random sample of ten rows.

# Technique 2: using sample_frac() function.

msleep %>%          #Take msleep dataset, and then...
  sample_frac(.1)   # Select random sample of 0.1 fraction of the dataset


### A USER DEFINED SLICE OF ROWS
#Note that the head() function call will show the first 6 rows by default, which can
#be modified by adding n-argument, that is, head(n=10) for example. Similarly, the 
# tail() function shows the last 6 rows by default and can also be modified by adding 
# n-argument thus tail(n=10). However, you may sometimes want to take a slice through
#the middle of the data. THis is where the slice() function comes in handy. The code
# below will enable you slice through rows 51 to 65.

msleep %>%   # Take msleep dataset, and then...
  slice(51:65) # Show rows within the specified range. 
