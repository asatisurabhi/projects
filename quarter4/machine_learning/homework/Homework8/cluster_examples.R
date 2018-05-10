# Clustering Examples

library(mlbench)

library(fpc)
library(cluster)
library(mclust)
library(dbscan)

###########################################################
# simulate data

set.seed(665544)
n <- 600

# Simulate 10 centers with normal random error
x <- cbind(runif(10, 0, 10)+rnorm(n, sd=0.2), runif(10, 0, 10)+rnorm(n, sd=0.2))
plot(x)

x <- scale(x)
plot(x)

par(bg="grey80")

# Using the mlbench function to simulate normals in 2d

library(mlbench)

set.seed(665544)

# 2 classes
p <- mlbench.2dnormals(n=500, cl=2, sd=0.25)
plot(p)
# 10 classes
p <- mlbench.2dnormals(n=500, cl=10, sd=0.25)
plot(p)

# x <- p$x  # Remove to try other simulated data.

###########################################################
# kmeans

km <- kmeans(x, centers=10, nstart=20)
plot(x, col=km$cluster)
#get diff colors everytime we run it
points(km$centers, pch=3, cex=2) # this adds the centroids
text(km$centers, labels=1:10, pos=2) # this adds the cluster ID

clusplot(x, km$cluster)

km$centers

def.par <- par(no.readonly = TRUE) # save default, for resetting...
layout(t(1:10)) # 4 plots in one
for(i in 1:10) barplot(km$centers[i,], ylim=c(-2,2), main=paste("Cluster", i))

###########################################################
# Mclust

m <- Mclust(x)
summary(m)

par(mfrow=c(1,1))
plot(m, what = "classification")

m <- Mclust(x, G=10)
summary(m)

par(mfrow=c(1,1))
plot(m, what = "classification")

###########################################################
# dbscan

kNNdistplot(x, k = 3)
abline(h=.14, col="red")

ds <- dbscan(x, 0.14)
ds <- dbscan(x, 0.07)
# run with showplot=1 to see how dbscan works.

ds

plot(x, col=ds$cluster+1L)

clusplot(x, ds$cluster)

###########################################################
# Big Data Analytics
# reference: http://artax.karlin.mff.cuni.cz/r-help/library/biganalytics/html/bigkmeans.html

# Simple example (with one processor):

library(biganalytics)
#install.packages("biganalytics")
#install.packages("foreach")
# simulated data
x <- big.matrix(1000000, 3, init=0, type="double")
x[seq(1,1000000,by=2),] <- rnorm(1500000)
x[seq(2,1000000,by=2),] <- rnorm(1500000, 5, 1)

ans <- bigkmeans(x, 1)  # One cluster isn't always allowed
                        # but is convenient.

ans$centers
ans$withinss
ans$size

apply(x, 2, mean)

ans <- bigkmeans(x, 2, nstart=5) # Sequential multiple starts.

class(ans)
names(ans)
ans$centers
ans$withinss
ans$size

# To use a parallel backend, try something like the following,
# assuming you have at least 3 cores available on this machine.
# Each processor does incur memory overhead for the storage of
# cluster memberships.

library(doSNOW)
#install.packages("doSNOW")
cl <- makeCluster(4)
registerDoSNOW(cl)

ans <- bigkmeans(x, 2, nstart=5)

# Both the following are run iteratively, but with less memory overhead
# using bigkmeans(). Note that the gc() comparisons aren't completely
# fair, because the big.matrix objects aren't reflected in the gc()
# summary. But the savings is there.

gc(reset=TRUE)
time.new <- system.time(print(bigkmeans(x, 2, nstart=5)$centers))
gc()
y <- x[,]
rm(x)
gc(reset=TRUE)
time.old <- system.time(print(kmeans(y, 2, nstart=5)$centers))
gc()

# The new kmeans() centers should match the old kmeans() centers, without
# the memory overhead amd running more quickly.

time.new
time.old

stopCluster(cl)








