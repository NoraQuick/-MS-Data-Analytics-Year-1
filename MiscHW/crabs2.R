#
# Fit and compare quasi-Poisson and negative binomial models to the Crab
# data
# 

library(ggplot2)
library(MASS)     # access the glm.nb function
library(glm2)     # access the crab data

data(crabs, package = "glm2")

work = crabs

# fit the Poisson, quasi-Poisson and negative binomial models

mod1 = glm(Satellites~Width*Dark*GoodSpine,data=work,family=poisson)
mod2 = glm(Satellites~Width*Dark*GoodSpine,data=work,family=quasipoisson)
mod3 = glm.nb(Satellites~Width*Dark*GoodSpine,data=work)

# compare coefficient estimates

cbind(coef(mod1),coef(mod2),coef(mod3))

# compare output from the two models that account for over dispersion

summary(mod2)
summary(mod3)

# look at some residual plots

work$res2 = resid(mod2)
work$res3 = resid(mod3)

ggplot(work,aes(Width,res2)) + geom_point()
ggplot(work,aes(Width,res3)) + geom_point()

# conclusion: favor the negative binomial approach over the quasi-poisson
# approach (likelihood-based, we get AIC)

# more to come: almost 36% of the satellite counts are zero...another
# modeling approach is to use a zero-inflated model...module 6