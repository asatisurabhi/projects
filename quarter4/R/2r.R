# Examples from ggplot2 by Hadley Wickham

library(ggplot2)

summary(diamonds)

# qplot is quick plot in ggplot2

# Scatterplots

qplot(carat, price, data=diamonds)

qplot(log(carat), log(price), data=diamonds)

# aesthetic attributes

qplot(carat, price, data=diamonds, colour=I("red"))

qplot(carat, price, data=diamonds, size = I(1))

qplot(carat, price, data=diamonds, alpha=I(1/10))
qplot(carat, price, data=diamonds, alpha=I(1/100))
qplot(carat, price, data=diamonds, alpha=I(1/200))

# geometric objects - smooth is loess

qplot(carat, price, data=diamonds, geom=c("point","smooth"))

# Histogram

qplot(carat, data=diamonds, geom="histogram")

qplot(carat, data=diamonds, geom="histogram", binwidth=1, xlim=c(0,3))
qplot(carat, data=diamonds, geom="histogram", binwidth=0.1, xlim=c(0,3))
qplot(carat, data=diamonds, geom="histogram", binwidth=0.01, xlim=c(0,3))

qplot(carat, data=diamonds, geom="histogram", fill=color)

# Density

qplot(carat, data=diamonds, geom="density")

qplot(carat, data=diamonds, geom="density", colour=color)

qplot(carat, data=diamonds, geom="density", fill=color)

# Bar charts

qplot(color, data=diamonds, geom="bar")

qplot(color, data=diamonds, geom="bar", weight=carat)

qplot(color, data=diamonds, geom="bar", weight=carat) + scale_y_continuous("carat")

# Faceting

qplot(carat, data=diamonds, facets = color ~ .,
      geom="histogram", binwidth=0.1, xlim=c(0,3)) + scale_y_continuous("carat")

qplot(carat, ..density.., data=diamonds, facets = color ~ .,
      geom="histogram", binwidth=0.1, xlim=c(0,3)) 

# Scatterplots

summary(mpg)

qplot(displ, hwy, data=mpg)

qplot(displ, hwy, data=mpg) + geom_smooth(method="lm")

# by year

qplot(displ, hwy, data=mpg, facets = . ~ year) + geom_smooth(method="lm")

qplot(displ, hwy, data=mpg, facets = . ~ year) + geom_smooth()

# by cylinders

qplot(displ, hwy, data=mpg, colour=factor(cyl))

qplot(displ, hwy, data=mpg, colour=factor(cyl)) + geom_smooth(method="lm")

qplot(displ, hwy, data=mpg, colour=factor(cyl)) + geom_smooth()

qplot(displ, hwy, data=mpg, facets = . ~ year, colour=factor(cyl)) + geom_smooth()










