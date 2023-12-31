
library(dplyr)
library(hflights)
??hflights
??dplyr


dim(hflights)
head(hflights)

#
# this next command is from the dplyr package (see the vignette), and it
# basically allows for a cleaner display of the data
#

hflights_df <- tibble::as_tibble(hflights) 
hflights_df

#
# How do we calculate the mean arrival delay for January?
#

attach(hflights_df) 

mean(ArrDelay[Month==1],na.rm=T)

# the dplyr way
jan <- filter(hflights_df, Month == 1)
summarise(jan, avg_delay = mean(ArrDelay, na.rm = TRUE))

#
# How about for all 12 months?
#

sapply(split(ArrDelay,Month),mean,na.rm=T)

# 
# here's the dplyr version of the same commands (means for all 12 months)


flight_month <- group_by(hflights_df, Month)
summarize(flight_month, 
          avg_delay = mean(ArrDelay, na.rm = TRUE))

#
# But in addition, with dplyr, we can create other summaries at the same time:
#

summarize(flight_month, 
          mean(ArrDelay, na.rm = TRUE),
          n(),
          sum(is.na(ArrDelay)))

#
# How about the dplyr verbs
#

# Selecting rows
filter(hflights_df, Dest == "PDX")

# Selecting columns
select(hflights_df, ArrDelay, UniqueCarrier)

# Rearranging rows
# here rearranging rows with respect to column ArrDelay
arrange(hflights_df, desc(ArrDelay))

# Adding new columns
# here the new column is more15
mutate(hflights_df, more15 = ArrDelay > 15)


#
# We could do this using sapply 3 times (once for mean, once for sample size,
#       once for number of NAs); or by creating a new function to do all three
#

#
# what if I want to know if there are differences in flight delays 
# between carriers?
#

boxplot(split(ArrDelay,UniqueCarrier))

#
# not a good idea to use ANOVA here...lots of long-tailed distibutions, but it
# is interesting to see what happens...
#

out <- aov(ArrDelay~UniqueCarrier)
summary(out)
tapply(ArrDelay,UniqueCarrier,mean,na.rm=T)
tapply(ArrDelay,UniqueCarrier,median,na.rm=T)
str(out) # there's lots of stuff getting carried around in the model object

rm(out)
detach(hflights_df)

#
# Now try to answer
#
# What if we want to compare the average flight delays by month for the last 20 years
# between Houston and Atlanta?
#


