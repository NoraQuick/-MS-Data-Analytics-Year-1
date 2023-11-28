#
# Aflatoxicol example -- dealing with tank
#

library(Sleuth3)
library(tidyverse)
library(vcdExtra)
library(magrittr)
library(lme4)     # access the mixed functions

# create additional variables in tumors file
data(ex2116)
tumors <- ex2116
tumors %<>% mutate(Dose = Dose, Tumor = Tumor, NoTumor = Total - Tumor, TankID = factor(1:nrow(tumors)),logDose = log(Dose), logDose2 = log(Dose)^2)
# fit fixed effects logisitic regression

glm1 <- glm(cbind(Tumor,NoTumor) ~ logDose + logDose2, data = tumors, family=binomial)
summary(glm1)

# fit fixed effects logistic regression with quasi-binomial likelihood

glm2 <- glm(cbind(Tumor,NoTumor) ~ logDose + logDose2, data = tumors, family=quasibinomial)
summary(glm2)

# fit mixed effects logistic regression, using Tank as random effect
glm3 <- glmer(cbind(Tumor,NoTumor) ~ logDose + logDose2 + (1|TankID), data = tumors,family=binomial)

# oops, it looks like theres' a convergence problems. Let's re-run the glmer algorithm
# using the values from the model we just fit as starting points:

(init <- getME(glm3, name =c ("theta","fixef")))
glm3 <- glmer(cbind(Tumor,NoTumor) ~ logDose + logDose2 + (1|TankID), data=tumors, start=init, family=binomial)
summary(glm3)

summary(glm1)$coefficients
summary(glm2)$coefficients
summary(glm3)$coefficients

# compare using AIC

AIC(glm1,glm3)

