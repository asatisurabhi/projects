x <- c(34,45,56)
y <- c(178,132,99)
plot(x,y)
gender <- factor(c("F", "M", "F"))
gender
subject1 <- list(x = x[1], y = y[1], 
                 gender = gender[1])
subject1
mydata <- data.frame(x, y, gender)
mydata
mydata$x
mydata$gender
mydata[1,]
mydata[,c(2,3)]
mydata[c(2,3),c(1,3)]
X <- matrix(c(x,y), ncol=2)
X

getwd()

#setwd("//")

usedcars <- read.csv("/Users/Surbhiasati/desktop/machine learning/Week1/usedcars.csv", stringsAsFactors = FALSE)
usedcars <- read.csv("usedcars.csv", stringsAsFactors = FALSE)
#write.csv(“mydata”, file “mydata.csv”)

head(usedcars)
summary(usedcars$price)
mean(usedcars$price)
sd(usedcars$price)
range(usedcars$price)

#install.packages(“gmodels”)

#library(gmodels)
