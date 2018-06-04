attach(mtcars)
summary(mtcars$mpg)
plot(wt, mpg) 
abline(lm(mpg~wt))
title("Regression of MPG on Weight")

# Simple Histogram
hist(mtcars$mpg)

# Kernel Density Plot
d <- density(mtcars$mpg) # returns the density data 
plot(d) # plots the results


# Simple Dotplot
dotchart(mtcars$mpg,labels=row.names(mtcars),cex=.7,
         main="Gas Milage for Car Models", 
         xlab="Miles Per Gallon")
# Dotplot: Grouped Sorted and Colored
# Sort by mpg, group and color by cylinder 
x <- mtcars[order(mtcars$mpg),] # sort by mpg
x$cyl <- factor(x$cyl) # it must be a factor
x$color[x$cyl==4] <- "red"
x$color[x$cyl==6] <- "blue"
x$color[x$cyl==8] <- "darkgreen"	
dotchart(x$mpg,labels=row.names(x),cex=.7,groups= x$cyl,
         main="Gas Milage for Car Models\ngrouped by cylinder",
         xlab="Miles Per Gallon", gcolor="black", color=x$color)


# Simple Bar Plot 
counts <- table(mtcars$gear)
barplot(counts, main="Car Distribution", 
        xlab="Number of Gears")


# Grouped Bar Plot
counts <- table(mtcars$vs, mtcars$gear)
barplot(counts, main="Car Distribution by Gears and VS",
        xlab="Number of Gears", col=c("darkblue","red"),
        legend = rownames(counts), beside=TRUE)

# Simple line chart
x <- c(1:5); y <- x # create some data 
par(pch=22, col="red") # plotting symbol and color 
par(mfrow=c(2,4)) # all plots on one page 
opts = c("p","l","o","b","c","s","S","h") 
for(i in 1:length(opts)){ 
  heading = paste("type=",opts[i]) 
  plot(x, y, type="n", main=heading) 
  lines(x, y, type=opts[i]) 
}

mtcars$mpg
summary(mtcars$mpg)


# Simple Pie Chart
library(plotrix)
slices <- c(mtcars$mpg)
lbls <- c("very Low mpg", "low mpg", "moderate mpg", "good mpg", "High mpg")
pie3D(slices, labels = lbls,explode=0.1, main="Mile per Gallon")


# Pie Chart from data frame with Appended Sample Sizes
mytable <- table(mtcars$mpg)
lbls <- paste(names(mytable))
pie3D(mytable, labels = lbls,explode=0.2,
    main="Pie Chart of miles per gallon\n (with sample sizes)")


# Notched Boxplot of Tooth Growth Against 2 Crossed Factors
# boxes colored for ease of interpretation 

boxplot(mpg~cyl,data=mtcars, notch=FALSE, 
        col=(c("gold","darkgreen")), main="Car Milage Data", 
        xlab="Number of Cylinders", ylab="Miles Per Gallon")


# Simple Scatterplot
attach(mtcars)
plot(wt, mpg, main="Scatterplot Example", 
     xlab="Car Weight ", ylab="Miles Per Gallon ", pch=19)


# Add fit lines
abline(lm(mpg~wt), col="red") # regression line (y~x) 
lines(lowess(wt,mpg), col="blue") # lowess line (x,y)

# Enhanced Scatterplot of MPG vs. Weight 
# by Number of Car Cylinders 
library(car) 
scatterplot(mpg ~ wt | cyl, data=mtcars, 
            xlab="Weight of Car", ylab="Miles Per Gallon", 
            main="Enhanced Scatter Plot", 
            labels=row.names(mtcars))

# Basic Scatterplot Matrix
pairs(~mpg+disp+drat+wt,data=mtcars, 
      main="Simple Scatterplot Matrix")


# Create Line Chart

# convert factor to numeric for convenience 
mtcars$mpg <- as.numeric(mtcars$mpg) 
ncars <- max(mtcars$mpg)

# get the range for the x and y axis 
xrange <- range(mtcars$mpg) 
yrange <- range(mtcars$qsec) 

# set up the plot 
plot(xrange, yrange, type="l", xlab="MPG",
     ylab="quarter mile time" ) 

lineplotfun <- function(feature){
  ggplot(aes(x = 1:length(feature), y = feature), data = mtcars) +
    geom_line()
}

lineplotfun(mtcars$mpg)



# Lines and points together
ggplot(mtcars, aes(x = mtcars$mpg, y = mtcars$qsec)) + geom_line() + geom_point()

## Multiple lines in a plot
plot(mtcars$qsec, mtcars$mpg, type = "l")
points(mtcars$qsec, mtcars$mpg)

lines(mtcars$qsec, mtcars$mpg/2, col = "yellow")
points(mtcars$qsec, mtcars$mpg/2, col = "red")





# Example of labeling points
attach(mtcars)
plot(wt, mpg, main="Milage vs. Car Weight", 
     xlab="Weight", ylab="Mileage", pch=18, 
     col="blue")
text(wt, mpg, row.names(mtcars), cex=0.6, 
     pos=4, col="red")


# 4 figures arranged in 2 rows and 2 columns
attach(mtcars)
par(mfrow=c(2,2))
plot(wt,mpg, main="Scatterplot of wt vs. mpg")
plot(wt,disp, main="Scatterplot of wt 
     vs disp")
hist(wt, main="Histogram of wt")
boxplot(wt, main="Boxplot of wt")

# Lattice Examples 
library(lattice) 
attach(mtcars)

# create factors with value labels 
gear.f<-factor(gear,levels=c(3,4,5),
               labels=c("3gears","4gears","5gears")) 
cyl.f <-factor(cyl,levels=c(4,6,8),
               labels=c("4cyl","6cyl","8cyl")) 

# kernel density plot 
densityplot(~mpg, 
            main="Density Plot", 
            xlab="Miles per Gallon")

# kernel density plots by factor level 
densityplot(~mpg|cyl.f, 
            main="Density Plot by Number of Cylinders",
            xlab="Miles per Gallon")

# kernel density plots by factor level (alternate layout) 
densityplot(~mpg|cyl.f, 
            main="Density Plot by Numer of Cylinders",
            xlab="Miles per Gallon", 
            layout=c(1,3))

# boxplots for each combination of two factors 
bwplot(cyl.f~mpg|gear.f,
       ylab="Cylinders" xlab="Miles per Gallon", 
       main="Mileage by Cylinders and Gears", 
       layout=(c(1,3))
       
       # scatterplots for each combination of two factors 
       xyplot(mpg~wt|cyl.f*gear.f, 
              main="Scatterplots by Cylinders and Gears", 
              ylab="Miles per Gallon", xlab="Car Weight")
       
       # 3d scatterplot by factor level 
       cloud(mpg~wt*qsec|cyl.f, 
             main="3D Scatterplot by Cylinders") 
       
       # dotplot for each combination of two factors 
       dotplot(cyl.f~mpg|gear.f, 
               main="Dotplot Plot by Number of Gears and Cylinders",
               xlab="Miles Per Gallon")
       
       # scatterplot matrix 
       splom(mtcars[c(1,3,4,5,6)], 
             main="MTCARS Data")


       # Lattice Examples 
       library(lattice) 
       attach(mtcars)
       # Display the Student's t distributions with various
       # degrees of freedom and compare to the normal distribution
       
       x <- seq(-4, 4, length=100)
       hx <- dnorm(x)
       
       degf <- c(1, 3, 8, 30)
       colors <- c("red", "blue", "darkgreen", "gold", "black")
       labels <- c("df=1", "df=3", "df=8", "df=30", "normal")
       
       plot(x, hx, type="l", lty=2, xlab="x value",
            ylab="Density", main="Comparison of t Distributions")
       
       for (i in 1:4){
         lines(x, dt(x,degf[i]), lwd=2, col=colors[i])
       }
       
       legend("topright", inset=.05, title="Distributions",
              labels, lwd=2, lty=c(1, 1, 1, 1, 2), col=colors)
       
       # create factors with value labels 
       gear.f<-factor(gear,levels=c(3,4,5),
                      labels=c("3gears","4gears","5gears")) 
       cyl.f <-factor(cyl,levels=c(4,6,8),
                      labels=c("4cyl","6cyl","8cyl")) 
       
       # kernel density plot 
       densityplot(~mpg, 
                   main="Density Plot", 
                   xlab="Miles per Gallon")
       # scatterplot matrix 
       splom(mtcars[c(1,3,4,5,6)], 
             main="MTCARS Data")
       
       
       # Children's IQ scores are normally distributed with a
       # mean of 100 and a standard deviation of 15. What
       # proportion of children are expected to have an IQ between
       # 80 and 120?
       
mean=100; sd=15
       lb=80; ub=120
       
       x <- seq(-4,4,length=100)*sd + mean
       hx <- dnorm(x,mean,sd)
       
       plot(x, hx, type="n", xlab="IQ Values", ylab="",
            main="Normal Distribution", axes=FALSE)
       
       i <- x >= lb & x <= ub
       lines(x, hx)
       polygon(c(lb,x[i],ub), c(0,hx[i],0), col="red") 
       
       area <- pnorm(ub, mean, sd) - pnorm(lb, mean, sd)
       result <- paste("P(",lb,"< IQ <",ub,") =",
                       signif(area, digits=3))
       mtext(result,3)
       axis(1, at=seq(40, 160, 20), pos=0)
       # Q-Q plots
       par(mfrow=c(1,2))
       
       # create sample data 
       x <- rt(100, df=3)
       
       # normal fit 
       qqnorm(x); qqline(x)
       
       # t(3Df) fit 
       qqplot(rt(1000,df=3), x, main="t(3) Q-Q Plot", 
              ylab="Sample Quantiles")
       abline(0,1)
       
       
       # Mosaic Plot Example
       library(vcd)
       mosaic(HairEyeColor, shade=TRUE, legend=TRUE)
       # Association Plot Example
       library(vcd)
       assoc(HairEyeColor, shade=TRUE)
       
       
       
       
       # First Correlogram Example
       library(corrgram)
       corrgram(mtcars, order=TRUE, lower.panel=panel.shade,
                upper.panel=panel.pie, text.panel=panel.txt,
                main="Car Milage Data in PC2/PC1 Order")
       
       
       # Second Correlogram Example
       library(corrgram)
       corrgram(mtcars, order=TRUE, lower.panel=panel.ellipse,
                upper.panel=panel.pts, text.panel=panel.txt,
                diag.panel=panel.minmax, 
                main="Car Mileage Data in PC2/PC1 Order")
       # Third Correlogram Example
       library(corrgram)
       corrgram(mtcars, order=NULL, lower.panel=panel.shade,
                upper.panel=NULL, text.panel=panel.txt,
                main="Car Milage Data (unsorted)")
       
       # Changing Colors in a Correlogram
       library(corrgram) 
       col.corrgram <- function(ncol){   
         colorRampPalette(c("darkgoldenrod4", "burlywood1",
                            "darkkhaki", "darkgreen"))(ncol)} 
       corrgram(mtcars, order=TRUE, lower.panel=panel.shade, 
                upper.panel=panel.pie, text.panel=panel.txt, 
                main="Correlogram of Car Mileage Data (PC2/PC1 Order)")

       
       # Type family examples - creating new mappings 
       plot(1:10,1:10,type="n")
       windowsFonts(
         A=macFont("Arial Black"),
         B=windowsFont("Bookman Old Style"),
         C=windowsFont("Comic Sans MS"),
         D=windowsFont("Symbol")
       )
       text(3,3,"Hello World Default")
       text(4,4,family="A","Hello World from Arial Black")
       text(5,5,family="B","Hello World from Bookman Old Style")
       text(6,6,family="C","Hello World from Comic Sans MS")
       text(7,7,family="D", "Hello World from Symbol")
       
       # Set a graphical parameter using par()
       
       par()              # view current settings
       opar <- par()      # make a copy of current settings
       par(col.lab="red") # red x and y labels 
       hist(mtcars$mpg)   # create a plot with these new settings 
       par(opar)          # restore original settings
       
       # Specify axis options within plot() 
       plot(x, y, main="title", sub="subtitle",
            xlab="X-axis label", ylab="y-axix label",
            xlim=c(xmin, xmax), ylim=c(ymin, ymax))
       Add a red title and a blue subtitle. Make x and y 
       # labels 25% smaller than the default and green. 
       title(main="My Title", col.main="red", 
             sub="My Sub-title", col.sub="blue", 
             xlab="My X label", ylab="My Y label",
             col.lab="green", cex.lab=0.75)
       
       # Example of labeling points
       attach(mtcars)
       plot(wt, mpg, main="Milage vs. Car Weight", 
            xlab="Weight", ylab="Mileage", pch=18, col="blue")
       text(wt, mpg, row.names(mtcars), cex=0.6, pos=4, col="red")
       
       
       # 4 figures arranged in 2 rows and 2 columns
       attach(mtcars)
       par(mfrow=c(2,2))
       plot(wt,mpg, main="Scatterplot of wt vs. mpg")
       plot(wt,disp, main="Scatterplot of wt vs disp")
       hist(wt, main="Histogram of wt")
       boxplot(wt, main="Boxplot of wt")
       
       