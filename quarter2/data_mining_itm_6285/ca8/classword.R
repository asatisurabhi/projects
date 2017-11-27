mydata= Zombie_Datasetnov27
summary(mydata)
mydata$Class<-as.factor(mydata$Class)
library(e1071)
mymodel=svm(Class~.,data=mydata)
summary(mymodel)
predictedclass=predict(mymodel,data=mydata)
mydata<-cbind(mydata,predictedclass)
performance=table(predict=predictedclass,real=mydata[,5])
accuracy=sum(diag(performance))/sum(performance)
#accuracy
#diag(performance)
pcadata=mydata[,1:4]
my.prc=prcomp(pcadata,scale=TRUE,center=T)
my.prc
#scree plot
plot(my.prc)
#my.prc$sdev
#(my.prc$sdev)*(my.prc$sdev)
pcavariance=(my.prc$sdev)*(my.prc$sdev)
sum(pcavariance)
percentagevar=pcavariance/sum(pcavariance)
plot(percentagevar)
#Calculate the coordinates  on the PC space
pcadata.scale=scale(pcadata)
pcacoordinate=pcadata.scale %*% my.prc$rotation
my.prc$rotation
pc1reading=pcacoordinate[,1]
combinedata=cbind(mydata,pc1reading)
svmwithpc1data=combinedata[,c(5,7)]
svmwithpc1=svm(Class~.,data=svmwithpc1data)
predictedclasspc1=predict(svmwithpc1,data=svmwithpc1data)
performancepc1=table(predictedclasspc1,svmwithpc1data$Class)
accuracy=sum(diag(performancepc1))/sum(performancepc1)
# With all 4 attributes, accuracy = 94.5%
# With just 1 pc1, accuracy = 68.5%
# pc1 variance accounts for almost 60% of 
biplot(my.prc,xlabs=rep(".",nrow(mydata)))
