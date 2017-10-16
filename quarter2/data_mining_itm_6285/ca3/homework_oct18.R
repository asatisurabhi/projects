summary(Car_Identification_1_)
Car_Identification$Category<-as.factor(Car_Identification$Category)
Car_Identification$Category=NULL
CarStandardized=scale(Car_Identification)
kmc=kmeans(CarStandardized,3)
kmc
kmc$centers