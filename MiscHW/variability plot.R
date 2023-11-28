library(tidyverse)
library(hflights)
library(ggplot2)
library(grid)

hflights_df <- as_tibble(hflights)

hflights_df <- mutate(hflights_df, 
                      DepHour = floor(DepTime/100),
                      DayOfWeek = factor(DayOfWeek, 
                                         labels = c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")),
                      Date = ISOdate(Year, Month, DayofMonth)
)
hou <- filter(hflights_df, Origin == "HOU")

hou_mon <- filter(hou, DayOfWeek == "Mon")

# over all mondays in 2011, avg delay of flights departing by hour
hou_mon_avg <- hou_mon %>%
  group_by(DepHour) %>%
  summarise(avg_delay = mean(DepDelay))

head(hou_mon_avg)

ggplot(hou_mon_avg, aes(x=DepHour, y=avg_delay)) +
  geom_dotplot()




ggplot(hou_mon_avg, aes(DepHour, avg_delay)) + 
  geom_point() +
  geom_line() + 
  ylab("Average delay (mins)") +
  xlab("Departure time") +
  scale_x_continuous(breaks = seq(0, 24, 6),
                     labels = c("midnight", "6am", "noon", "6pm", "midnight")) +
  theme_bw(18)



