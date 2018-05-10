##### Chapter 7: Neural Networks and Support Vector Machines -------------------

#Question 1
##### ----- Support Vector Machines -------------------
## Example: Optical Character Recognition ----
```{r}
## Step 2: Exploring and preparing the data ----
# read in data and examine structure
letters <- read.csv("letterdata.csv")
str(letters)

# divide into training and test data
letters_train <- letters[1:16000, ]
letters_test  <- letters[16001:20000, ]

## Step 3: Training a model on the data ----
# begin by training a simple linear SVM
library(kernlab)
letter_classifier <- ksvm(letter ~ ., data = letters_train,
                          kernel = "vanilladot")

# look at basic information about the model
letter_classifier

## Step 4: Evaluating model performance ----
# predictions on testing dataset
letter_predictions <- predict(letter_classifier, letters_test)

head(letter_predictions)

table(letters_test$letter, letter_predictions)

# look only at agreement vs. non-agreement
# construct a vector of TRUE/FALSE indicating correct/incorrect predictions
agreement <- letter_predictions == letters_test$letter
table(agreement)
prop.table(table(agreement))

## Step 5: Improving model performance ----
set.seed(12345)
letter_classifier_rbf <- ksvm(letter ~ ., data = letters_train, kernel = "rbfdot")
letter_predictions_rbf <- predict(letter_classifier_rbf, letters_test)

table(letters_test$letter, letter_predictions_rbf)

agreement_rbf <- letter_predictions_rbf == letters_test$letter
table(agreement_rbf)
prop.table(table(agreement_rbf))
```

#Question 2

##### Chapter 9: Clustering with k-means -------------------

## Example: Finding Teen Market Segments ----

```{r}
## Step 2: Exploring and preparing the data ----
teens <- read.csv("http://www.sci.csueastbay.edu/~esuess/classes/Statistics_6620/Presentations/ml12/snsdata.csv")
str(teens)

# look at missing data for female variable
table(teens$gender)
table(teens$gender, useNA = "ifany")

# look at missing data for age variable
summary(teens$age)

# eliminate age outliers
teens$age <- ifelse(teens$age >= 13 & teens$age < 20,
                    teens$age, NA)

summary(teens$age)

# reassign missing gender values to "unknown"
teens$female <- ifelse(teens$gender == "F" &
                         !is.na(teens$gender), 1, 0)
teens$no_gender <- ifelse(is.na(teens$gender), 1, 0)

# check our recoding work
table(teens$gender, useNA = "ifany")
table(teens$female, useNA = "ifany")
table(teens$no_gender, useNA = "ifany")

# finding the mean age by cohort
mean(teens$age) # doesn't work
mean(teens$age, na.rm = TRUE) # works

# age by cohort
aggregate(data = teens, age ~ gradyear, mean, na.rm = TRUE)

# create a vector with the average age for each gradyear, repeated by person
ave_age <- ave(teens$age, teens$gradyear,
               FUN = function(x) mean(x, na.rm = TRUE))


teens$age <- ifelse(is.na(teens$age), ave_age, teens$age)

# check the summary results to ensure missing values are eliminated
summary(teens$age)

## Step 3: Training a model on the data ----
interests <- teens[5:40]
interests_z <- as.data.frame(lapply(interests, scale))

set.seed(2345)
teen_clusters <- kmeans(interests_z, 5)

## Step 4: Evaluating model performance ----
# look at the size of the clusters
teen_clusters$size

# look at the cluster centers
teen_clusters$centers

## Step 5: Improving model performance ----
# apply the cluster IDs to the original data frame
teens$cluster <- teen_clusters$cluster

# look at the first five records
teens[1:5, c("cluster", "gender", "age", "friends")]

# mean age by cluster
aggregate(data = teens, age ~ cluster, mean)

# proportion of females by cluster
aggregate(data = teens, female ~ cluster, mean)

# mean number of friends by cluster
aggregate(data = teens, friends ~ cluster, mean)

```



#Question 3

##### Chapter 8: Association Rules -------------------

```{r}
## Example: Identifying Frequently-Purchased Groceries ----

library(arules)
library(arulesViz)
library(DT)

## Step 2: Exploring and preparing the data ----

# load the grocery data into a sparse matrix
#fn in arulesviz to read transcation so read fn is diff.........................
groceries <- read.transactions("groceries.csv", sep = ",")
summary(groceries)

# look at the first five transactions
inspect(groceries[1:5])

# examine the frequency of items
itemFrequency(groceries[, 1:3])

# plot the frequency of items
itemFrequencyPlot(groceries, support = 0.1)
itemFrequencyPlot(groceries, topN = 20)

# a visualization of the sparse matrix for the first five transactions
image(groceries[1:5])

# visualization of a random sample of 100 transactions
image(sample(groceries, 100))

## Step 3: Training a model on the data ----

# default settings result in zero rules learned
apriori(groceries)
#default support is too high s=10%---huge, c=80%.............so change it 
# set better support and confidence levels to learn more rules
groceryrules <- apriori(groceries, parameter = list(support =
                                                      0.006, confidence = 0.25, minlen = 2))
groceryrules
#now there are 463 rules.........
## Step 4: Evaluating model performance ----
# summary of grocery association rules
summary(groceryrules)

# look at the first three rules
inspect(groceryrules[1:3])

# with a data.table

inspectDT(groceryrules)

# read about the arulesViz package  https://cran.r-project.org/web/packages/arulesViz/vignettes/arulesViz.pdf

plot(groceryrules)

head(quality(groceryrules))

plot(groceryrules, measure = c("support", "lift"), shading = "confidence")

plot(groceryrules, method = "two-key plot")

subrules <- groceryrules[quality(groceryrules)$confidence > 0.5]

plot(subrules, method = "matrix", measure = "lift")

plot(subrules, method = "matrix3D", measure = "lift")

plot(groceryrules, method = "grouped")

subrules2 <- head(groceryrules, n = 50, by = "lift")

plot(subrules2, method = "graph")

plot(subrules2, method = "paracoord")

oneRule <- sample(groceryrules, 1)

inspect(oneRule)

plot(oneRule, method = "doubledecker", data = groceries)


## Step 5: Improving model performance ----

# sorting grocery rules by lift
inspect(sort(groceryrules, by = "lift")[1:5])

# finding subsets of rules containing any berry items
berryrules <- subset(groceryrules, items %in% "berries")

inspect(berryrules)

plot(berryrules, method = "graph")

plot(berryrules, method = "paracoord")

# writing the rules to a CSV file
write(groceryrules, file = "groceryrules.csv",
      sep = ",", quote = TRUE, row.names = FALSE)

# converting the rule set to a data frame
groceryrules_df <- as(groceryrules, "data.frame")

str(groceryrules_df)

```

