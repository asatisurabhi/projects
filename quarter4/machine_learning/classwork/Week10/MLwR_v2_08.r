##### Chapter 8: Association Rules -------------------

## Example: Identifying Frequently-Purchased Groceries ----

library(arules)
library(arulesViz)
library(DT)

## Step 2: Exploring and preparing the data ----

# load the grocery data into a sparse matrix

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

# set better support and confidence levels to learn more rules
groceryrules <- apriori(groceries, parameter = list(support =
                          0.006, confidence = 0.25, minlen = 2))
groceryrules

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

