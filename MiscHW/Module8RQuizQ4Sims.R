# Set the number of simulations (and different random seeds)
# to try. Don't pick a number that is much bigger than 10,000
# or it will take quite a long time and possibly crash your 
# computer.

nSim <- 1000

# Create an empty vector (just a vector of zeroes) that will
# be used to store the p-values from each new simulation.

pvals <- rep(0, nSim)

# Set the sample size n.

n <- 1000000

for(i in 1:nSim){
	# The lines below ('print(i)', etc.) are just to tell us how far 
	# through the nSim iterations we have gotten. This is 
	# slow with a large sample size because of the iterative
	# nature of the glm solution. 
	
	if(i %% 20 == 0) print(i)
	
	# For the ith simulation, we are using 'i' as the random seed,
	# so the first simulation will use 1 as the random seed, the second
	# will use 2, and so on.  We could instead randomly generate new 
	# random seeds, but I wanted to keep this simple and easily
	# reproducible.  
			
	set.seed(i)
	
	# Generate the data Y and X as in the quiz question, with
	# the designated sample size n.
	
	Y <- rbinom(n, 1, 0.3)
	X <- rnorm(n, 0, 1)
	out <- glm(Y~X, family = binomial) 
	
	# Store the p-value resulting from the estimated logistic
	# regression model.  This can be found as the element in row 2,
	# column 4 of the 'coefficients' object of the summary output.
	
	pvals[i] <- summary(out)$coeff[2,4]
}

# Count how many of the resulting p-values are less than 
# 0.05.  Here we show several ways to do that.  First, we
# use the 'table' function to tabulate how many of the p-values
# were <= 0.05, and how many were > 0.05.  A 'TRUE' value means
# the p-value was <= 0.05, while a 'FALSE' value means the p-value
# was > 0.05.

table(pvals <= 0.05)

### Output:
### -------
### FALSE  TRUE 
###  952    48 


# Another way of counting how many p-values are <= 0.05.  Note that
# R treats 'TRUE' as a 1 and 'FALSE' as a 0, so when we add up a 
# vector of 'TRUE's and 'FALSE's, we are just counting how many 'TRUE's 
# there were.

sum(pvals <= 0.05)

### Output:
### -------
### [1] 48

# Now to calculate the proportion of p-values <= 0.05, we just divide
# the number that were <= 0.05 by the total number of simulations we 
# did:

sum(pvals <= 0.05)/nSim

### Output:
### -------
### [1] 0.048

# Or we could do that in one step using the 'mean' function, since
# the mean of a vector of 1's and 0's is just the proportion of 1's:

mean(pvals <= 0.05)

### Output:
### -------
### [1] 0.048

# Same thing, but for a smaller significance level (0.006 instead of
# 0.05)

table(pvals <= 0.006)

### Output:
### -------
### FALSE  TRUE 
###  994     6 

mean(pvals <= 0.006)

### Output:
### -------
### [1] 0.006

##################################################

# Repeat all of the above, but with n = 50 instead of n = 1000000

nSim <- 1000
pvals <- rep(0, nSim)
n <- 50

for(i in 1:nSim){
	if(i %% 20 == 0) print(i)
	set.seed(i)
	Y <- rbinom(n, 1, 0.3)
	X <- rnorm(n, 0, 1)
	out <- glm(Y~X, family = binomial) 
	pvals[i] <- summary(out)$coeff[2,4]
}

table(pvals <= 0.05)
mean(pvals <= 0.05)

table(pvals <= 0.006)
mean(pvals <= 0.006)

##################################################

# Consider a single example with n = 50:

set.seed(304)
Y <- rbinom(50, 1, 0.3)
X <- rnorm(50, 0, 1)
out <- glm(Y~X, family = binomial) 
summary(out)
