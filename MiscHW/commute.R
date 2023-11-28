# Charlotte's code for the not very successful comparison
# of commute methods by state.

# Loads ggplot2, and other core members of tidyverse, e.g. dplyr
library(tidyverse)

commute <- read_rds("http://data.cwick.co.nz/commute.rds")

# a subset of "Western" states for class
states <- c("or", "ak", "ca", "wa", "id", "nv")
commute_nw <- filter(commute, state %in% states)

head(commute_nw)

dev.off()

ggplot(commute_nw) +
  geom_bar(aes(x = "", y = prop, fill = factor(transport_type)), 
    stat = "identity", width = 1) +
  facet_wrap(~ state_name) +
  coord_polar(theta = "y") +
  theme_minimal(18) + 
  xlab("") + ylab("") +
  theme(axis.text = element_blank())

ggplot(commute_nw, aes(x = state_name, y = med_time, fill = transport_type, colour = transport_type)) + 
  geom_bar(stat = "identity")
