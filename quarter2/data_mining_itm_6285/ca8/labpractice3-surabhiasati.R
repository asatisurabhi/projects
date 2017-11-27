mydata=wine
summary(mydata)
mydata$Wine<-NULL
head(mydata)
my.wine<-scale(mydata)
my.wine
my.prc=prcomp(mydata,scale=TRUE,center=T)
my.prc
#scree plot
plot(my.prc)

pcavariance=(my.prc$sdev)*(my.prc$sdev)
pcavariance
sum(pcavariance)
percentagevar=pcavariance/sum(pcavariance)
plot(percentagevar)
percentagevar
# pc1 variance accounts for 68% of Variation
pcacoordinate=my.wine %*% my.prc$rotation
pcacoordinate
