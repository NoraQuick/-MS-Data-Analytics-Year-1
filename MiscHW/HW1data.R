#Import package
library(Sleuth3)
library(Math2)

#Get head data
head(ex2117)

#Control
boyprobno <- 51.2 * 0.01
nboyno <- 20337
totalboyno <- round(nboyno * boyprobno)
totalboyno

#Ex1
boyprob13 <- 52.1 * 0.01
nboy13 <- 71
totalboy13 <- round(nboy13 * boyprob13)
totalboy13

#Ex2
boyprob12 <- 49.6 * 0.01
nboy12 <- 789
totalboy12 <- round(nboy12 * boyprob12)
totalboy12

#Ex3
boyprob0 <- 48.9 * 0.01
nboy0 <- 1922
totalboy0 <- round(nboy0 * boyprob0)
totalboy0

#Ex4
boyprob1st <- 46.0 * 0.01
nboy1st <- 290
totalboy1st <- round(nboy * boyprob)
totalboy1st

#Q2: Answer
ex2117$NumBoys <- c(totalboyno, totalboy13, totalboy12, totalboy0, totalboy1st)
ex2117$NumBoys


