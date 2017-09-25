a=5
b="HelloWorld"
c='Hello'
d=FALSE
f=6
g<-a+f
y <- 5%%2
y
x=5^2
u<-x>y
v<-(x==x)
a=TRUE&TRUE
b=(3==3)|(3!=3)
c=(1:10)
c
d=c(1,3,5,10)
d
e=3 %in% d
f=4 %in% d
g=c(1,23,34,51,657,6,75,8)
h=g[1:4]
i=g[-1]
i
length(g)
j=g[(length(g)-5):length(g)]
j
k=c(g,100)
k
g[length(g)+1]<-100
g
list1=list(5,"Hello",T)
list2=merge(list1, list2)
list3[1]
textmatrix=matrix(c(1,2,3,4,5,5,6,7,9,10
                    ),2,5
                  ,byrow=T,
                  dimnames=list(c("r1","r2"),c("c1","c2","c3","c4","c5")))
textmatrix
myscore=59
if (myscore>=60){
  print("congo")
} else if (myscore<=59){
  print("damn")
} else if

sum = 0
for(i in c(1:100)){
  sum=sum+i
}
sum
lettergrade=c()
scores=c(68,80,89,54,64,88,77)
for(i in scores) {
  if (i>=90){
    lettergrade=c(lettergrade,"A")
  } else if (i>=80){
    lettergrade=c(lettergrade,"B")
  }else if (i>=70){
    lettergrade=c(lettergrade,"C")
  }else if (i>=60){
    lettergrade=c(lettergrade,"D")
  }else {
    lettergrade=c(lettergrade,"F")
  }
}
lettergrade
library(lattice)
?lattice
mydata=data(environmental)
mydata
head(environmental)
xyplot(ozone ~ radiation, data = environmental)
equal.count(environmental$temperature,4)
xyplot(ozone ~ radiation|environmental$temperature>70,data=environmental,main="True:temp>70")
tempcut=equal.count(environmental$temperature,4)
xyplot(ozone ~ radiation|tempcut,data=environmental,main="True:temp>70")
head(environmental)
windcut=equal.count(environmental$wind,4)
xyplot(ozone ~ radiation|tempcut*windcut,data=environmental,main="True:temp>70")
