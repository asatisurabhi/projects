##### Homework 2: Classification using Nearest Neighbors --------------------

## Example: Classify Radar returns from the ionosphere ----
## Step 1: Exploring and preparing the data ---- 

# import the CSV file
ion <- read.csv("ionosphere.csv", stringsAsFactors = FALSE)

# examine the structure of the ion data frame
str(ion)

# table of Class
table(ion$Class)

# recode Class as a factor
ion$Class <- factor(ion$Class, levels = c("b", "g"),
                         labels = c("Bad", "Good"))

# table or proportions with more informative labels
round(prop.table(table(ion$Class)) * 100, digits = 1)

# summarize three numeric features
summary(ion[c("Attribute9", "Attribute11", "Attribute22")])

# create training and test data
ion_train <- ion[1:251,1:34 ]

ion_test <- ion[252:351,1:34 ]

# create labels for training and test data

ion_train_labels <- ion[1:251, 35]
#ion_train_labels
ion_test_labels <- ion[252:351, 35]
#ion_test_labels

# visualize the data using labels

plot(ion$Attribute9,ion$Attribute11, 
     main = 'Scatterplot',
     xlab = 'Attribute 9',
     ylab = 'Attribute 11')

pairs(~Attribute9+Attribute11+Attribute22+Attribute27+Attribute33, 
      data = ion,
      main = 'Scaterplot of many variables')

library(car)

scatterplot(Attribute9 ~ Attribute11 | Class, data = ion,
            main = 'Scatterplot',
            xlab = 'Attribute9',
            ylab = 'Attribute11')


scatterplotMatrix(~Attribute9+Attribute11+Attribute22+Attribute27+Attribute33 | Class, data=ion)

## Step 2: Training a model on the data ----

# load the "class" library
library(class)

ion_test_pred <- knn(train = ion_train, test = ion_test,
                      cl = ion_train_labels, k = 21)

head(ion_test)
head(ion_test_pred)

## Step 3: Evaluating model performance ----

# load the "gmodels" library
library(gmodels)

# Create the cross tabulation of predicted vs. actual.......what's chisq for ....
CrossTable(x = ion_test_labels, y = ion_test_pred,
           prop.chisq = FALSE)

## Step 4: Improving model performance ----

#start time
strt<-Sys.time()

ion_test_pred <- knn(train = ion_train, test = ion_test, cl = ion_train_labels, k=1)
CrossTable(x = ion_test_labels, y = ion_test_pred, prop.chisq=FALSE)

ion_test_pred <- knn(train = ion_train, test = ion_test, cl = ion_train_labels, k=5)
CrossTable(x = ion_test_labels, y = ion_test_pred, prop.chisq=FALSE)

ion_test_pred <- knn(train = ion_train, test = ion_test, cl = ion_train_labels, k=11)
CrossTable(x = ion_test_labels, y = ion_test_pred, prop.chisq=FALSE)

ion_test_pred <- knn(train = ion_train, test = ion_test, cl = ion_train_labels, k=15)
CrossTable(x = ion_test_labels, y = ion_test_pred, prop.chisq=FALSE)

ion_test_pred <- knn(train = ion_train, test = ion_test, cl = ion_train_labels, k=21)
CrossTable(x = ion_test_labels, y = ion_test_pred, prop.chisq=FALSE)

ion_test_pred <- knn(train = ion_train, test = ion_test, cl = ion_train_labels, k=27)
CrossTable(x = ion_test_labels, y = ion_test_pred, prop.chisq=FALSE)

#end time
print(Sys.time()-strt)

