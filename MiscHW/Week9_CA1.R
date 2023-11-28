library(mvtnorm)
library(cluster)
library(plotrix)
library(graphics)
library(mclust)
library(MASS)

############## Data ##################################################

# Generating data with four clusters and two variables
x <- matrix(0, nrow=100, ncol=2)
x[1:25,] <- rmvnorm(25, c(2,2))
x[26:50,] <- rmvnorm(25, c(-2,2))
x[51:75,] <- rmvnorm(25, c(-2,-2))
x[76:100,] <- rmvnorm(25, c(2,-2))
# True cluster assignments
cl.true <- c(rep(1, 25), rep(2, 25), rep(3, 25), rep(4, 25))  

# Cancer Data
cancerData <- read.table(file="14cancer.xtrain",sep="")
# namesCancer<-read.table(file="namesCancer.txt",sep="",header="FALSE")
namesCancer <- read.table(file="namesCancer.txt")
myLabels <- c('breast','prostate','lung','collorectal','lymphoma',
              'bladder','melanoma','uterus','leukemia','renal','pancreas',
              'ovary','meso','cns')
names(cancerData) <- c(namesCancer)
# dim(cancerData)
myLabels <- c('breast','prostate','lung','collorectal','lymphoma',
              'bladder','melanoma','uterus','leukemia','renal','pancreas',
              'ovary','meso','cns')

# Handwritten Digit Data
digit = read.table('Digit_recog_train.txt')
digit_no = digit[,1]
digit_pix = digit[,-1]
digit_no3 = digit_no[digit_no == 3]
digit_pix3 = digit_pix[digit_no == 3,]

sel = sample(c(0,1), length(digit_no), replace = T, prob = c(4/5,1/5))
digit_pix = digit_pix[sel == 1,]
digit_no = digit_no[sel==1]

######################## K-means Algorithm ###################################

# x <- t(cancerData)
# x <- digit_pix

cl <- kmeans(x, centers = 4)  # k-means clustering with 4 clusters
cl$cluster  # cluster membership of each point
cl <- pam(x, k=4)  # k-medoids clustering with 4 clusters
cl$clustering  # cluster membership of each point

# Misclassification table for true and estimated clusters
table(cl$clustering, cl.true)  

sil <- silhouette(cl$clustering, dist(x))  # Finding cluster silhouette
avg.sil <- mean(sil[,3])  # Finding average silhouette for the clustering
plot(sil)  # Plotting average silhouette for each cluster

# Finding average silhouette for each number of cluster from 2 to 9
avg.sil <- rep(0, 10)
for(k1 in 2:9) {
  cl <- pam(x, k = k1)  # k-medoids clustering
  sil <- silhouette(cl$clustering, dist(x))
  avg.sil[k1] <- mean(sil[,3])  # Finding average silhouette for the clustering
}
# Plotting average silhouette for each cluster number
plot(2:9, avg.sil[2:9], xlab = "Number of clusters", 
     ylab = "Average Cluster Silhouette")  # Maximum is for 4 clusters

########## Spectral Clustering ########################################

w <- as.matrix(dist(x))  # Generating the distance matrix
n <- dim(x)[1]  # Number of data points

#############

# Generating k-nn graph
k <- 10         # Number of nearest neighbors connected for each point
A <- matrix(0, nrow=n, ncol=n)  
# plot(x[,1], x[,2])
for(i in 1:n) {
  #	id <- rep(1,n)  
  #	id[i] <- 2
  nn <- order(w[i,])[2:(k+1)]  # Finding the nearest k neighbors
  #	id[nn] <- 6
  A[i,nn] <- 1  # Forming the Adjacency matrix
  #	segments(x[p1,1],x[p1,2],x[nn[1],1],x[nn[1],2], col=6, lwd = 3)
  #	segments(x[p1,1],x[p1,2],x[nn[2],1],x[nn[2],2], col=6, lwd = 3)
  #	segments(x[p1,1],x[p1,2],x[nn[3],1],x[nn[3],2], col=6, lwd = 3)
  #	Sys.sleep(2)
}
A = A + t(A)  # Making the adjacency matrix symmetric
A[A > 0] = 1  # Ensuring the adjacency matrix is binary
D = diag(rowSums(A))  # Finding the diagonal degree matrix 
L = D - A  # Finding the Laplacian

# Scree Plot of eigenvalues of L
plot(eigen(L)$values)  
# Zooming on the lowest 5 eigenvalues
plot(eigen(L)$values[(n-4):n])  # Note the gap between 4th and 5th lowest
# Plotting the eigenvectors corresponding to lowest two eigenvalues
plot(eigen(L)$vectors[,n], eigen(L)$vectors[,(n-1)])  

## Doing the clustering
# Considering number of clusters as two
ncl <- 4  
# Eigenvectors corresponding to lowest 2 eigenvalues
u <- eigen(L)$vectors[,(n-ncl+1):n]  
cl <- pam(u, ncl)  # Performing the clustering of rows of eigenvectors
cl$clustering  # result of clustering
# Misclassification table for true and estimated clusters
table(cl$clustering, cl.true)  

#############

# Generating epsilon neighborhood graph
ep <- 2       # The distance below which points are connected by an edge
A <- matrix(0, nrow=n, ncol=n)
#plot(x[,1], x[,2], xlim=c(-4,8), ylim=c(-4,4))
for(i in 1:n) {
  #	id <- rep(1,10)
  #	id[i] <- 2
  en <- which(w[i,] <= ep)  # Finding the neighbors within ditsnce ep=1
  en <- en[en!=i]
  A[i, en] <- 1  # Forming the Adjacency matrix
  #	id[en] <- 6
  #	plot(x[,1], x[,2], pch=id, col=id)
  #	draw.circle(x[p1,1],x[p1,2],ep)
  #	for(j in 1:length(en)) {
  #		segments(x[p1,1],x[p1,2],x[en[j],1],x[en[j],2], col=6, lwd = 3)
  #	}
  #	Sys.sleep(2)
}
A = A + t(A)  # Making the adjacency matrix symmetric
A[A > 0] = 1  # Ensuring the adjacency matrix is binary
D = diag(rowSums(A))  # Finding the diagonal degree matrix 
L = D - A  # Finding the Laplacian

# Scree Plot of eigenvalues of L
plot(eigen(L)$values)  
# Zooming on the lowest 5 eigenvalues
plot(eigen(L)$values[(n-4):n])  # Note the gap between 4th and 5th lowest
# Plotting the eigenvectors corresponding to lowest two eigenvalues
plot(eigen(L)$vectors[,n], eigen(L)$vectors[,(n-1)])  

## Doing the clustering
# Considering number of clusters as four
ncl <- 4
# Eigenvectors corresponding to lowest 2 eigenvalues
u <- eigen(L)$vectors[,(n-ncl+1):n]  
cl <- pam(u, ncl)  # Performing the clustering of rows of eigenvectors
cl$clustering  # result of clustering
# Misclassification table for true and estimated clusters
table(cl$clustering, cl.true)  

##### Spectral Clustering with Normalized Laplacians

D.inv = diag((diag(D))^(-1))  # D^(-1) matrix
D.sqrt.inv <- diag((sqrt(diag(D)))^(-1))  # D^(-1/2) matrix
L_rw = D.inv%*%L  # Random walk Laplacian
L_sym = D.sqrt.inv%*%L%*%D.sqrt.inv  # Symmetric Laplacian

# Scree Plot of eigenvalues of L_rw
plot(eigen(L_rw)$values) 
# Zooming on the lowest 5 eigenvalues
plot(eigen(L_rw)$values[(n-4):n])  # Note the gap between 4th and 5th lowest
# Plotting the eigenvectors corresponding to lowest two eigenvalues
plot(eigen(L_rw)$vectors[,n], eigen(L_rw)$vectors[,(n-1)])  

## Doing the clustering
# Considering number of clusters as four
ncl <- 4
# Eigenvectors corresponding to lowest 2 eigenvalues
u <- eigen(L_rw)$vectors[,(n-ncl+1):n]  
cl <- pam(u, ncl)  # Performing the clustering of rows of eigenvectors
cl$clustering
# Misclassification table for true and estimated clusters
table(cl$clustering, cl.true)  

# Scree Plot of eigenvalues of L_sym
plot(eigen(L_sym)$values)  
# Zooming on the lowest 5 eigenvalues
plot(eigen(L)$values[(n-4):n])  # Note the gap between 4th and 5th lowest
# Plotting the eigenvectors corresponding to lowest two eigenvalues
plot(eigen(L_sym)$vectors[,n], eigen(L_sym)$vectors[,(n-1)])  

## Doing the clustering
# Considering number of clusters as four
ncl <- 4
# Eigenvectors corresponding to lowest 2 eigenvalues
u <- eigen(L_sym)$vectors[,(n-ncl+1):n]  
cl <- pam(u, ncl)  # Performing the clustering of rows of eigenvectors
cl$clustering
# Misclassification table for true and estimated clusters
table(cl$clustering, cl.true)  


