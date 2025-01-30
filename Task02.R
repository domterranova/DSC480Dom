---
  title: "Task_02 2/2/2025"
author: Dominick Terranova
date: 2025/02/2
format: pdf
editor_options: 
  chunk_output_type: console
---

#Create new file and write code to replace date with columns for
#days since coverage_start_date (days between event start days and coverage start days)

events_full %>% mutate(days_since_start = event_start_date - coverage_start_date) %>%
  mutate(days_since_ibis = event_start_date - ibis_start_date) %>%
  select(coverage_start_date, event_start_date, days_since_start, ibis_coverage_start_date, days_since_ibis)


#Create logical or 0, 1 columns for whether the event took place between
#- coverage_start_date and ibis_coverage_start_date, and whether 
#between - ibis_coverage_start_date and ibis_coverage_end_date




#Check whether these agree with any existing 0,1 columns in the events data frame



#As a separate exercise, in the same file, write code that tweaks 
#the dates by adding a random number of days. Use uniform on \[-5, 5\]. 
#Do this with the unprocessed data; that is, the dates are numerical 
#and are the number of seconds since a baseline date. You can find what
#the dates are using as.POSIXct(). You can check what 0 is with as.POSIXct(0).
#So you just need to add uniform random days, in seconds. 
#Try a toy data set to see test your code, for example
#df \<- tibble(timestamp = c(rep(1732424400, 10))). 
#You can use mutate(across(contains("timestamp")....


#Note: mutate_at() is deprecated. It still works fine, but it has 
#been superceded by a new dplyr verb, mutate(across()). 
#Thus mutate_at(vars(contains("timestamp")), \~as.POSIXct(.x, format = "%Y-%m-%d %H:%M:%S")) 
#Can be replaced with mutate(across(contains("timestamp"), \~as.POSIXct(.x, format = "%Y-%m-%d %H:%M:%S")))
