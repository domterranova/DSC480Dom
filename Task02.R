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
Converts timestamps to the number of days since coverage_start_date in POSIXct format like the assignment says
```{r}

colnames(events_full)

events_full <- events %>% # Converting Timestamps to Date Format
  mutate(across(contains("timestamp"),
   ~as.POSIXct(.x, format = "%Y-%m-%d %H:%M:%S")))  %>%
  mutate_at(vars(contains("timestamp")), ~as_date(.x)) %>% # Renaming Columns
  rename_with(~str_replace(., "timestamp", "date"), contains("timestamp")) %>%
  mutate(across(event_type, ~ str_replace(.x, " ", "_"))) |> # Cleaning event_type Strings
  mutate(across(event_type, ~as.factor(.x))) #Converting event_type to Factor
```

```{r}

colnames(report_full)
#now do for report data
report_full <- report %>%
  mutate(across(contains("timestamp"),
   ~as.POSIXct(.x, format = "%Y-%m-%d %H:%M:%S")))  %>% # Converting Timestamps to Date Format
  mutate_at(vars(contains("timestamp")), ~as_date(.x)) %>% #Renaming Columns
  rename_with(~str_replace(., "timestamp", "date"), contains("timestamp")) %>%
    mutate(across(event_type, ~ str_replace(.x, " ", "_"))) |> #Cleaning event_type Strings
  mutate(across(event_type, ~as.factor(.x))) #Converting event_type to Factor
```

Preview now
```{r}
head(events_full)
```
```{r}
head(report_full)
```

#Create logical or 0, 1 columns for whether the event took place between
#- coverage_start_date and ibis_coverage_start_date, and whether 
#between - ibis_coverage_start_date and ibis_coverage_end_date
Now we create the binary columns (1(before Ibis coverage) or 0) for events that happens before Ibis coverage 
```{r}
events_full <- events_full %>% 
  mutate(pre_ibis = ifelse(event_start_date >= coverage_start_date & event_start_date < ibis_coverage_start_date, 1,0),
#creates the binary column we described
    during_ibis = ifelse(
      event_start_date >= ibis_coverage_start_date & event_start_date <= ibis_coverage_end_date,  
      1,0))
```

```{r}
##now showing the event start date with the new binary columns
head(events_full %>% select(event_start_date, pre_ibis, during_ibis))
```

#Check whether these agree with any existing 0,1 columns in the events data frame
```{r}
head(colnames(events_full))

#compare pre_ibis with pre_ibis_inpatient
table(events_full$pre_ibis, events_full$pre_ibis_inpatient, useNA = "ifany")

#compare during_ibis with ibis_inpatient
table(events_full$during_ibis, events_full$ibis_inpatient, useNA = "ifany")
```

```{r}
#check mismatches in pre_ibis and in during_ibis

mismatches <- events_full %>%
  filter(
    pre_ibis != pre_ibis_inpatient |  
    during_ibis != ibis_inpatient   
  )

head(mismatches)

table(mismatches$event_type, mismatches$pre_ibis, mismatches$pre_ibis_inpatient)
```

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
