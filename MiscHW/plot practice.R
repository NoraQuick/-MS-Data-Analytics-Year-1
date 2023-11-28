library(tidyverse)
iah <- read_csv("http://vis.cwick.co.nz/data/iah-summary.csv")

# make sure days of week are displayed in the right order
iah$DayOfWeek <- factor(iah$DayOfWeek, 
                        levels = c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"))

p <- ggplot(iah, aes(DepHour, DayOfWeek)) +
  geom_tile(aes(fill = prop_over_15)) 
p

p + scale_fill_gradient()

p + scale_fill_gradient("Proportion", 
                        high = "white", low = "springgreen4")

#Mine
p + scale_fill_gradient("Proportion", 
                        high = "skyblue1", low = "skyblue3")
p + scale_fill_gradient("Proportion", 
                        high = "steelblue3", low = "sienna3")

library(colorspace)

hcl_palettes(plot = TRUE)

p + scale_fill_continuous_sequential("Mint")

p +  scale_fill_continuous_diverging("Blue-Red")


#Mine
p + scale_fill_continuous_sequential("Teal")
p + scale_fill_continuous_sequential("Peach")
p + scale_fill_continuous_sequential("SunsetDark")

library(ggplot2)

ggplot(iah, aes(DepHour, DayOfWeek)) +
  geom_tile(aes(fill = avg_delay_delayed)) +
  scale_fill_gradient()

ggplot(iah, aes(DepHour, DayOfWeek)) +
  geom_tile(aes(fill = avg_delay_delayed)) +
  scale_fill_gradient(limits = c(0, 120))

ggplot(iah, aes(DepHour, DayOfWeek)) +
  geom_tile(aes(fill = avg_delay_delayed)) +
  scale_fill_gradient(trans = "log10")

ggplot(iah, aes(DepHour, DayOfWeek)) +
  geom_tile(aes(fill = log10(avg_delay_delayed))) +
  scale_fill_gradient()

?trans_new

iah <- iah %>% 
  mutate(avg_delay_cut = cut(avg_delay, breaks = c(-5, 0, 15, 30, 60, 1000)))

ggplot(iah, aes(DepHour, DayOfWeek)) +
  geom_tile(aes(fill = avg_delay_cut))  +
  scale_fill_discrete_sequential("Mint")

#Me
ggplot(iah, aes(DepHour, DayOfWeek)) +
  geom_tile(aes(fill = log10(avg_delay_delayed))) +
  scale_fill_gradient() +
  scale_fill_continuous_sequential("Teal")

#ggplot(iah, aes(DepHour, DayOfWeek)) +
#  geom_tile(aes(fill = log10(avg_delay_delayed))) +
#  scale_fill_gradient() +
#  scale_fill_continuous_sequential("Purp")

ggplot(iah, aes(DepHour, DayOfWeek)) +
  geom_tile(aes(fill = log10(avg_delay_delayed))) +
  scale_fill_gradient() +
  scale_fill_continuous_sequential("Blue-Red")
