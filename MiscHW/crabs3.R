#
# Fit and compare ZIP and and ZINB models to the Crab data
# 

library(ggplot2)
#install.packages("pscl")
library(pscl)     # access the zeroinfl function
library(MASS)     # access the glm.nb function
library(glm2)     # access the crab data ***order of accessing these
                  #         libraries is important for getting the 
                  #         appropriate crabs dataset

data(crabs, package = "glm2")
work = crabs
head(work)
ggplot(work,aes(Width,Satellites)) + geom_point()

# fit the ZIP model

mod1 = zeroinfl(Satellites~Width+Dark+GoodSpine,dist="poisson",data=work)
summary(mod1)

# compare to Poisson model

mod0 = glm(Satellites~Width+Dark+GoodSpine,family=poisson,data=work)
summary(mod0)

AIC(mod0,mod1)

# fit the ZINB model

mod2 = zeroinfl(Satellites~Width+Dark+GoodSpine,dist="negbin",data=work)
summary(mod2)

# compare to the negative binomial model

mod0 = glm.nb(Satellites~Width+Dark+GoodSpine,data=work)
summary(mod0)

AIC(mod0,mod2)

mod3 = hurdle(Satellites~Width+Dark+GoodSpine,dist="poisson",data=work)
summary(mod3)

mod4 = hurdle(Satellites~Width+Dark+GoodSpine,dist="negbin",data=work)
summary(mod4)

AIC(mod0,mod1,mod2,mod3,mod4)

