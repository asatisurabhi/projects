library(tm)
library(wordcloud)
wordcloud(c(letters, LETTERS, 0:9), seq(1, 1000, len = 62))
wordcloud("",
          ,random.order=FALSE)

library(dplyr)
library(gutenbergr)
library(tidytext)
moby <- gutenberg_download(2701)
dim(moby)
moby1 <- moby %>%
  unnest_tokens(word, text)
moby1
library(wordcloud)
moby1 %>%
  anti_join(stop_words) %>%
  count(word) %>%
  with(wordcloud(word, n, max.words = 100))
Joining , by = "word"

#install devtools if you have not installed 
install.packages('devtools')
library(devtools)

slam_url <- "https://cran.r-project.org/src/contrib/Archive/slam/slam_0.1-37.tar.gz"
install_url(slam_url)
R.version





library(maptools)
library(RColorBrewer)
library(classInt)
library(rgdal)
getwd()
setwd("/Users/surbhiasati/Data_Visualization")
getwd()
setwd("/Users/surbhiasati/Desktop/DataVisualization")

setwd(file.path("Users", "surbhiasati", "Desktop", "DataVisualization", "bayarea_zipcodes.shp"))

## set the working directory.  Windows
# setwd("C:\\Users\\Eric A. Suess\\Downloads\\bayarea_zipcodes\\")
## set the working directory.  Mac or Linux
setwd("~/classes/2016-2017/02 Winter 2017/Stat 6610/Activity/BayArea")
## load the shapefile
zip <- readOGR("bayarea_zipcodes.shp")

setwd("/Users/surbhiasati/Desktop/DataVisualization")
setwd("DataVisualization")
dir


# ggplot2 examples
library(ggplot2) 

# create factors with value labels 
mtcars$gear <- factor(mtcars$gear,levels=c(3,4,5),
                      labels=c("3gears","4gears","5gears")) 
mtcars$am <- factor(mtcars$am,levels=c(0,1),
                    labels=c("Automatic","Manual")) 
mtcars$cyl <- factor(mtcars$cyl,levels=c(4,6,8),
                     labels=c("4cyl","6cyl","8cyl")) 



# Kernel density plots for mpg
# grouped by number of gears 
# (indicated by color)
qplot(mpg, data=mtcars, geom="density", 
      fill=gear, alpha=I(.5), 
      main="Distribution of Gas Milage", xlab="Miles Per Gallon", 
      ylab="Density")
# Scatterplot of mpg vs. hp for each 
# combination of gears and cylinders
# in each facet, transmition type is 
# represented by shape and color
qplot(hp, mpg, data=mtcars, shape=am, 
      color=am, facets=gear~cyl, size=I(3),
      xlab="Horsepower", ylab="Miles per 
      Gallon") 
# Separate smoothers of mpg on weight for each number of cylinders
qplot(wt, mpg, data=mtcars, geom=c("point", 
                                   "smooth"), color=cyl, 
      main="Smoothers of MPG on Weight", 
      xlab="Weight", ylab="Miles per Gallon")

# Boxplots of mpg by number of gears 
# observations (points) are overlayed and jittered
qplot(gear, mpg, data=mtcars, 
      geom=c("boxplot", "jitter"), 
      fill=gear, main="Mileage by Gear Number",
      xlab="", ylab="Miles per Gallon")
