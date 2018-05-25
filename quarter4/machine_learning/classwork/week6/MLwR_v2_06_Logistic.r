##### Chapter 6: Regression Methods -------------------

#### Part 3: Logistic Regression -------------------

## A nice reference for fitting logistic regression in R
## http://www.r-bloggers.com/how-to-perform-a-logistic-regression-in-r/

## A nice reference for generalized linear models in R
## http://www.statmethods.net/advstats/glm.html

## Understanding regression ----
## Example: Space Shuttle Launch Data ----
launch <- read.csv("http://www.sci.csueastbay.edu/~esuess/classes/Statistics_6620/Presentations/ml10/challenger.csv")

# examine the launch data
str(launch)

# logisitic regression

# First recode the distress_ct variable into 0 and 1, making 1 to represent at least
# one failure during a launch.

launch$distress_ct <- ifelse(launch$distress_ct<1,0,1)
launch$distress_ct

# set up trainning and test data sets

indx <- sample(1:nrow(launch), as.integer(0.9*nrow(launch)))
indx

launch_train <- launch[indx,]
launch_test <- launch[-indx,]

launch_train_labels <- launch[indx,1]
launch_test_labels <- launch[-indx,1]   

# Check if there are any missing values

library(Amelia)
missmap(launch, main = "Missing values vs observed")

# number of missing values in each column

sapply(launch,function(x) sum(is.na(x)))

# number of unique values in each column

sapply(launch, function(x) length(unique(x)))

# fit the logistic regression model, with all predictor variables

model <- glm(distress_ct ~.,family=binomial(link='logit'),data=launch_train)
model

summary(model)

anova(model, test="Chisq")

# drop the insignificant predictors, alpha = 0.10

model <- glm(distress_ct ~ temperature,family=binomial(link='logit'),data=launch_train)
model

summary(model)

anova(model, test="Chisq")

# check Accuracy

fitted.results <- predict(model,newdata=launch_test,type='response')
fitted.results <- ifelse(fitted.results > 0.5,1,0)

misClasificError <- mean(fitted.results != launch_test$distress_ct)
print(paste('Accuracy',1-misClasificError))

# ROC
# Because this data set is so small, it is possible that the test data set
# does not contain both 0 and 1 values.  If this happens the code will not
# run.  And since the test data set is so small the ROC is not useful here
# but the code is provided.

library(ROCR)
p <- predict(model, newdata=launch_test, type="response")
pr <- prediction(p, launch_test$distress_ct)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)

auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
auc



## Example: credit

credit <- read.csv("http://www.sci.csueastbay.edu/~esuess/classes/Statistics_6620/Presentations/ml7/credit.csv")

## Fix the default variable to be 0 or 1

credit$default <- as.numeric(credit$default)
credit$default <- credit$default - 1

# examine the launch data
str(credit)

# logisitic regression

# set up trainning and test data sets

indx <- sample(1:nrow(credit), as.integer(0.9*nrow(credit)))
indx

credit_train <- credit[indx,]
credit_test <- credit[-indx,]

credit_train_labels <- credit[indx,17]
credit_test_labels <- credit[-indx,17]   

# Check if there are any missing values

library(Amelia)
missmap(credit, main = "Missing values vs observed")

# number of missing values in each column

sapply(credit,function(x) sum(is.na(x)))

# number of unique values in each column

sapply(credit, function(x) length(unique(x)))

# fit the logistic regression model, with all predictor variables

model <- glm(default ~.,family=binomial(link='logit'),data=credit_train)
model

summary(model)

anova(model, test="Chisq")

# drop the insignificant predictors, alpha = 0.10

model <- glm(default ~ checking_balance + months_loan_duration + credit_history +  percent_of_income + age,family=binomial(link='logit'),data=credit_train)
model

summary(model)

anova(model, test="Chisq")

# check Accuracy

fitted.results <- predict(model,newdata=credit_test,type='response')
fitted.results <- ifelse(fitted.results > 0.5,1,0)

misClasificError <- mean(fitted.results != credit_test$default)
print(paste('Accuracy',1-misClasificError))

# ROC
# Because this data set is so small, it is possible that the test data set
# does not contain both 0 and 1 values.  If this happens the code will not
# run.  And since the test data set is so small the ROC is not useful here
# but the code is provided.

library(ROCR)
p <- predict(model, newdata=credit_test, type="response")
pr <- prediction(p, credit_test$default)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)

auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
auc

#### Part 4: Classification Trees ------------------

## Example: Estimating Wine Quality ----
## Step 2: Exploring and preparing the data ----

credit <- read.csv("http://www.sci.csueastbay.edu/~esuess/classes/Statistics_6620/Presentations/ml7/credit.csv")

# examine the credit data
str(credit)

# the distribution of defaults
plot(credit$default)

# summary statistics of the credit data
summary(credit)

## Step 3: Training a model on the data ----
# regression tree using rpart
library(rpart)
m.rpart <- rpart(default ~ ., data = credit_train)

# get basic information about the tree
m.rpart

# get more detailed information about the tree
summary(m.rpart)

# use the rpart.plot package to create a visualization
library(rpart.plot)

# a basic decision tree diagram
rpart.plot(m.rpart, digits = 3)

# a few adjustments to the diagram
rpart.plot(m.rpart, digits = 4, fallen.leaves = TRUE, type = 3, extra = 101)

## Step 4: Evaluate model performance ----

# generate predictions for the testing dataset
p.rpart <- predict(m.rpart, credit_test)

# compare the distribution of predicted values vs. actual values
summary(p.rpart)
summary(credit_test$default)

# compare the correlation
cor(p.rpart, as.numeric(credit_test$default))

# function to calculate the mean absolute error
MAE <- function(actual, predicted) {
  mean(abs(actual - predicted))  
}

# mean absolute error between predicted and actual values
MAE(p.rpart, as.numeric(credit_test$default))

# mean absolute error between actual values and mean value
mean(as.numeric(credit_train$default)) 
MAE(1.30, as.numeric(credit_train$default))
