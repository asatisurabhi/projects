##### Chapter 11: Improving Model Performance -------------------

# load the credit dataset
credit <- read.csv("http://www.sci.csueastbay.edu/~esuess/classes/Statistics_6620/Presentations/ml10/credit.csv")

# No Test data are used in these examples.  So the out of sample accuracy is not computed. 

# Here is the link to the caret documentation.
# http://topepo.github.io/caret/index.html

library(caret)
library(tictoc)  # A nice package for measuring run times in R.

## Creating a simple tuned model ----
# automated parameter tuning of C5.0 decision tree 
set.seed(300)
m <- train(default ~ ., data = credit, method = "C5.0")

# summary of tuning results
m

# apply the best C5.0 candidate model to make predictions
p <- predict(m, credit)
confusionMatrix(data=p, credit$default)

# obtain predicted classes
head(predict(m, credit, type = "raw"))

# obtain predicted probabilities
head(predict(m, credit, type = "prob"))

## Customizing the tuning process ----
# use trainControl() to alter resampling strategy
ctrl <- trainControl(method = "repeatedcv", number = 10, repeats = 10,
                     selectionFunction = "oneSE", returnResamp="all")

# use expand.grid() to create grid of tuning parameters
grid <- expand.grid(.model = "tree",
                    .trials = c(1, 5, 10, 15, 20, 25, 30, 35),
                    .winnow = c(TRUE,FALSE))

# look at the result of expand.grid()
grid

# customize train() with the control list and grid of parameters 
tic()
set.seed(300)
m <- train(default ~ ., data = credit, method = "C5.0",
           metric = "Kappa",
           trControl = ctrl,
           tuneGrid = grid,
           verbose=FALSE)
toc()

m

# visualize the resample distributions
xyplot(m,type = c("g", "p", "smooth"))

# run in parallel, the doMC package runs on mac and linux
library(doMC)
registerDoMC(cores = 8)

# run in parallel, the doMC package runs on Windows
library(doParallel)
registerDoParallel(cores = 8)

## All subsequent models are then run in parallel
tic()
set.seed(300)
m <- train(default ~ ., data = credit, method = "C5.0",
           metric = "Kappa",
           trControl = ctrl,
           tuneGrid = grid,
           verbose=FALSE)
toc()

m

# visualize the resample distributions
xyplot(m,type = c("g", "p", "smooth"))

## Bagging ----
# Using the ipred bagged decision trees
library(ipred)

tic()
set.seed(300)
mybag <- bagging(default ~ ., data = credit, nbagg = 25)
toc()

credit_pred <- predict(mybag, credit)
confusionMatrix(data=credit_pred, credit$default)

 # estimate performance of ipred bagged trees

tic()
set.seed(300)
ctrl <- trainControl(method = "cv", number = 10)

mybag_treebag <- train(default ~ ., data = credit, method ="treebag",
      trControl = ctrl)
toc()

credit_pred <- predict(mybag_treebag, credit)
confusionMatrix(data=credit_pred, credit$default)

## Boosting ----

## Using C5.0 Decision Tree (not shown in book)
library(C50)

tic()
m_c50_bst <- C5.0(default ~ ., data = credit, trials = 100)
toc()

credit_pred <- predict(m_c50_bst, credit)
confusionMatrix(data=credit_pred, credit$default)

## Using AdaBoost.M1
library(adabag)

# create a Adaboost.M1 model
tic()
set.seed(300)
m_adaboost <- boosting(default ~ ., data = credit)
toc()

p_adaboost <- predict(m_adaboost, credit)
head(p_adaboost$class)
p_adaboost$confusion

# create and evaluate an Adaboost.M1 model using 10-fold-CV
tic()
set.seed(300)
adaboost_cv <- boosting.cv(default ~ ., data = credit)
toc()

adaboost_cv$confusion

# calculate kappa
library(vcd)
Kappa(adaboost_cv$confusion)

## Random Forests ----
# random forest with default settings
library(randomForest)

tic()
set.seed(300)
rf <- randomForest(default ~ ., data = credit)
toc()

rf

credit_pred <- predict(rf, credit)
confusionMatrix(data=credit_pred, credit$default)

library(caret)
ctrl <- trainControl(method = "repeatedcv",
                     number = 10, repeats = 10)

# auto-tune a random forest
grid_rf <- expand.grid(.mtry = c(2, 4, 8, 16))

tic()
set.seed(300)
m_rf <- train(default ~ ., data = credit, method = "rf",
              metric = "Kappa", trControl = ctrl,
              tuneGrid = grid_rf)
toc()

m_rf

credit_pred <- predict(m_rf, credit)
confusionMatrix(data=credit_pred, credit$default)

# auto-tune a boosted C5.0 decision tree
grid_c50 <- expand.grid(.model = "tree",
                        .trials = c(10, 20, 30, 40),
                        .winnow = "FALSE")

tic()
set.seed(300)
m_c50 <- train(default ~ ., data = credit, method = "C5.0",
                metric = "Kappa", trControl = ctrl,
               tuneGrid = grid_c50)
toc()

m_c50

credit_pred <- predict(m_c50, credit)
confusionMatrix(data=credit_pred, credit$default)

###########################################################################
## Random Forests ----
library(ranger)

tic()
set.seed(300)
m_rf_ranger <- ranger(default ~ ., data = credit, num.threads = 8)
toc()

m_rf_ranger

m_rf_ranger$confusion.matrix

###########################################################################

# Example of running RandomForest on a larger dataset.
# The ranger package can be used in parallel.

# The dataset used is the Bank Marketing Data Set dataset from the UCI ML Library.
# https://archive.ics.uci.edu/ml/datasets/Bank+Marketing

tic()
bank <- read.csv("bank-additional-full-2.csv", header = TRUE)
toc()

tic()
set.seed(300)
m_rf_ranger <- ranger(y ~ ., data = bank, num.threads = 8)
toc()

m_rf_ranger

m_rf_ranger$prediction.error  

m_rf_ranger$confusion.matrix

# OR use the data.table package and the fread function.

library(data.table)

tic()
bank <- fread("bank-additional-full-2.csv", header = TRUE)
toc()

tic()
set.seed(300)
m_rf_ranger <- ranger(y ~ ., data = bank, num.threads = 8)
toc()

m_rf_ranger

m_rf_ranger$prediction.error  

m_rf_ranger$confusion.matrix

###########################################################################

# Example of running RandomForest on a larger dataset.
# The target variable is numeric, so there is not confussion matrix.
# The ranger package can be used in parallel.

# The dataset used is the Online New Populatity dataset from the UCI ML Library.
# https://archive.ics.uci.edu/ml/datasets/Online+News+Popularity

tic()
populatity <- fread("OnlineNewsPopularity.csv", header = TRUE)
toc()

dim(populatity)

popularity <- populatity[,c(1,2)]

dim(populatity)

# remove first to columns, not predictors

tic()
set.seed(300)
m_rf_ranger <- ranger(shares ~ ., data = populatity[,-c(1,2)], num.threads = 8)
toc()

m_rf_ranger

cor(m_rf_ranger$predictions, populatity$shares)

plot(m_rf_ranger$predictions, populatity$shares)

m_rf_ranger$prediction.error  # very large error.







