mydata=Admission_2_

#Task2
logistic<-glm(Admission_2_$ADMIT~Admission_2_$GRE+Admission_2_$GPA
              +Admission_2_$RANK,famil=binomial("logit"),data = Admission_2_)
summary(logistic)

#Task 3
prdictedprob=logistic$fitted.values
table(trueclass=Admission_2_$ADMIT,prdictedprob>0.5)
#Task4  not rigt
combineddata=cbind(Admission_2_,predictedprob)
