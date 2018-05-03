##### Chapter 5: Classification using Decision Trees and Rules -------------------

#### Part 1: Decision Trees -------------------

## Understanding Decision Trees ----
# calculate entropy of a two-class segment
-0.60 * log2(0.60) - 0.40 * log2(0.40)

curve(-x * log2(x) - (1 - x) * log2(1 - x),
      col = "red", xlab = "x", ylab = "Entropy", lwd = 4)

## Example: Identifying Risky Bank Loans ----
## Step 1: Download the data ----

URL <- "http://www.sci.csueastbay.edu/~esuess/classes/Statistics_6620/Presentations/ml7/credit.csv"
download.file(URL, destfile = "credit.csv", method="curl")

## Step 2: Exploring and preparing the data ----
credit <- read.csv("credit.csv", stringsAsFactors = TRUE)
str(credit)

# look at two characteristics of the applicant
table(credit$checking_balance)
table(credit$savings_balance)

# look at two characteristics of the loan
summary(credit$months_loan_duration)
summary(credit$amount)

# look at the class variable
table(credit$default)

# create a random sample for training and test data
# use set.seed to use the same random number sequence as the tutorial
set.seed(123)
train_sample <- sample(1000, 900)

str(train_sample)

# split the data frames
credit_train <- credit[train_sample, ]
credit_test  <- credit[-train_sample, ]

# check the proportion of class variable
prop.table(table(credit_train$default))
prop.table(table(credit_test$default))

## Step 3: Training a model on the data ----
# build the simplest decision tree
library(C50)
credit_model <- C5.0(credit_train[-17], credit_train$default)

# display simple facts about the tree
credit_model

# display detailed information about the tree
summary(credit_model)

## Step 4: Evaluating model performance ----
# create a factor vector of predictions on test data
credit_pred <- predict(credit_model, credit_test)

# cross tabulation of predicted versus actual classes
library(gmodels)
CrossTable(credit_test$default, credit_pred,
           prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,
           dnn = c('actual default', 'predicted default'))

## Step 5: Improving model performance ----

## Boosting the accuracy of decision trees
# boosted decision tree with 10 trials
credit_boost10 <- C5.0(credit_train[-17], credit_train$default,
                       trials = 10)
credit_boost10
summary(credit_boost10)

credit_boost_pred10 <- predict(credit_boost10, credit_test)
CrossTable(credit_test$default, credit_boost_pred10,
           prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,
           dnn = c('actual default', 'predicted default'))

## Making some mistakes more costly than others

# create dimensions for a cost matrix
matrix_dimensions <- list(c("no", "yes"), c("no", "yes"))
names(matrix_dimensions) <- c("predicted", "actual")
matrix_dimensions

# build the matrix
error_cost <- matrix(c(0, 1, 4, 0), nrow = 2, dimnames = matrix_dimensions)
error_cost

# apply the cost matrix to the tree
credit_cost <- C5.0(credit_train[-17], credit_train$default,
                    costs = error_cost)
credit_cost_pred <- predict(credit_cost, credit_test)

CrossTable(credit_test$default, credit_cost_pred,
           prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,
           dnn = c('actual default', 'predicted default'))

#### Part 2: Rule Learners -------------------

## Example: Identifying Poisonous Mushrooms ----
## Step 1: Download the data ----

URL <- "http://www.sci.csueastbay.edu/~esuess/classes/Statistics_6620/Presentations/ml8/mushrooms.csv"
download.file(URL, destfile = "mushrooms.csv", method="curl")

## Step 2: Exploring and preparing the data ---- 
mushrooms <- read.csv("mushrooms.csv", stringsAsFactors = TRUE)

# examine the structure of the data frame
str(mushrooms)

# drop the veil_type feature
mushrooms$veil_type <- NULL

# examine the class distribution
table(mushrooms$type)


set.seed(123)
train_sample <- sample(8124, 7000)

str(train_sample)

# split the data frames
mushrooms_train <- mushrooms[train_sample, ]
mushrooms_test  <- mushrooms[-train_sample, ]


## Step 3: Training a model on the data ----
library(RWeka)

# train OneR() on the data
mushroom_1R <- OneR(type ~ ., data = mushrooms_train)

## Step 4: Evaluating model performance ----
mushroom_1R
summary(mushroom_1R)


mushroom_pred <- predict(mushroom_1R, mushrooms_test)

# cross tabulation of predicted versus actual classes
library(gmodels)
CrossTable(mushrooms_test$type, mushroom_pred,
           prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,
           dnn = c('actual default', 'predicted default'))


## Step 5: Improving model performance ----
mushroom_JRip <- JRip(type ~ ., data = mushrooms_train)
mushroom_JRip
summary(mushroom_JRip)


mushroom_pred <- predict(mushroom_JRip, mushrooms_test)

# cross tabulation of predicted versus actual classes
library(gmodels)
CrossTable(mushrooms_test$type, mushroom_pred,
           prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,
           dnn = c('actual default', 'predicted default'))


# Rule Learner Using C5.0 Decision Trees (not in text)
library(C50)
mushroom_c5rules <- C5.0(type ~ odor + gill_size, data = mushrooms_train, rules = TRUE)
mushroom_c5rules
summary(mushroom_c5rules)


mushroom_pred <- predict(mushroom_c5rules, mushrooms_test)

# cross tabulation of predicted versus actual classes
library(gmodels)
CrossTable(mushrooms_test$type, mushroom_pred,
           prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,
           dnn = c('actual default', 'predicted default'))
