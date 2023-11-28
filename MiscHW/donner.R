#
# R code to create a plot of the Donner party data and fit
# a logistic regression model
#

# install.packages("Sleuth3)

library(Sleuth3)
library(ggplot2)

#
# I like to create a "work" file for the current data file that
# I'm using; then I take a quick look at the data and create the 
# Female indicator variable:
#

work = case2001   
head(work)
work$Female = ifelse(work$Sex=="Female",1,0)

#
# Now, just a quick plot to look at the data (you'll do this
# in this module's lab too)
#

ggplot(work,aes(Age,Status,color=Sex)) + geom_point()

#
# Here's the code to fit a logistic regression model:
#

LRM = glm(Status~Age+Female,data=work,family=binomial(link="logit"))
summary(LRM)

#
# And approximate confidence intervals for the Beta's:
#

cis = confint.default(LRM)
cis
exp(cis)
