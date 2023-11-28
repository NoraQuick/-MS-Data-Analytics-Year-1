library(MASS)
library(RandPro)

#################### Data ######################################

# Car Data
# The data are averaged marks for 24 car types from a sample of 40 persons. 
# The marks range from 1 (very good) to 6 (very bad) like German school marks. 
# The variables are:
# Model, Economy, Service, Non-depreciation of value, 
# Price - Mark 1 for very cheap cars,
# Design, Sporty car, Safety, Easy handling
x <- read.table("carmean2.txt", header =T)

######################## Multi-dimensional Scaling (MDS) ################

# Metric MDS
dat <- read.table("carmean2.txt", header=T)
dm <- dist(dat[,-1])
fit1 <- cmdscale(dm, 2)  # Metric MDS
plot(fit1[,1], fit1[,2], type="n")
text(fit1[,1], fit1[,2], labels=dat[,1], cex=0.7)

# non-metric MDS
dat <- read.table("carmean2.txt", header=T)
dm <- dist(dat[,-1])
# dm <- dist(dat[,-1], method = "minkowski", p = 4)
fit2 <- isoMDS(dm, k=2)  # non-metric MDS
x1 <- fit2$points[,1]
x2 <- fit2$points[,2]
plot(x1, x2, type="n")
text(x1, x2, labels=dat[,1], cex=0.7)

######################## Random Projection ######################

dat <- read.table("carmean2.txt", header=T)

x <- dat[,-1]
x <- matrix(unlist(x), nrow = dim(x)[1], ncol = dim(x)[2], byrow = F)
p <- dim(x)[2]
d <- 2    # dimension of the lower dimensional data matrix

# Default Gaussian projection matrix without JL transform
mat <- form_matrix(d, p, FALSE)

# Projection to lower dimensional data set
rp.x <- mat%*%t(x)
rp.x <- t(rp.x)

# Plotting the lower dimensional data
x1 <- rp.x[,1]
x2 <- rp.x[,2]
plot(x1, x2, type="n")
text(x1, x2, labels=dat[,1], cex=0.7)



