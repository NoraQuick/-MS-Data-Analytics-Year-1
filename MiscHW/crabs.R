#
# Example using Agresti's crab data
#

library(ggplot2)
#install.packages("glm2")
library(glm2)
help(crabs, package = "glm2")
data(crabs, package = "glm2")

#
# Take a look at the number of satellites (males) vs Width
#

work = crabs
ggplot(work,aes(Width,Satellites)) + geom_point()

#
# There are some zeroes, let's adjust for log transformation
# and re-plot
#

work$lSat = log(ifelse(work$Satellites==0,0.1,work$Satellites))
ggplot(work,aes(Width,lSat)) + geom_point() + ylab("log(Satellites)")

ggplot(work,aes(Dark,lSat)) + geom_point() + ylab("log(Satellites)")
ggplot(work,aes(GoodSpine,lSat)) + geom_point() + ylab("log(Satellites)")
ggplot(work,aes(Width,lSat)) + geom_point()  + facet_wrap(~Dark+GoodSpine)+ ylab("log(Satellites)")


#
# Fit a rich model with all interactions
#

mod1 = glm(Satellites~Width*Dark*GoodSpine,data=work,family=poisson)
summary(mod1)

#
# Look at residuals and fitted values
#

work$res = residuals(mod1)
work$fits = predict.glm(mod1,type="response")

ggplot(work,aes(Width,res)) + geom_point()
ggplot(work,aes(Satellites,fits)) + geom_point()



