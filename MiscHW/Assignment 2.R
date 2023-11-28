# Annika Gehl
# Assignment 2

# Load libraries
library(nycsquirrels18)
library(tidyverse)
library(colorspace)
view(squirrels)

# Plot 1 - Location (coordinates) of sightings
(plot1_OG <- squirrels %>%
    ggplot(aes(x = lat, y = long, color = age))+
    geom_point()+
    facet_wrap(~ primary_fur_color))

# Plot 1 Polished
squirrels_pol <- squirrels %>%
  filter(primary_fur_color != "NA") %>%
  filter(age != "?")

(plot1_pol <- squirrels_pol %>%
    ggplot(aes(x = lat, y = long, color = age))+
    geom_point(aes(alpha = 0.9, shape = age))+
    labs(caption = "New York City squirrels most frequently have a primary fur color of gray, and most of the observed squirrels were adults.")+
    xlab("Latitude")+
    ylab("Longitude")+
    ggtitle("Gray-Furred Squirrels: Most Common & Evenly Distributed")+
    facet_wrap(~ primary_fur_color)+
    theme(legend.title = element_text(colour = "black"))+
    guides(alpha = FALSE)+
    scale_color_manual(values = c("red", "blue")))

?theme
?geom_point
hcl_palettes(plot = TRUE)
