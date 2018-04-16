# Mosaic Plot Example
library(vcd)
mosaic(HairEyeColor, shade=TRUE, legend=TRUE)


library(hexbin)
x <- rnorm(10000); y <- rnorm(10000)
bin <- hexbin(x, y, xbins=50) 
plot(bin, main="Hexagonal Binning")


library(portfolio)

posts <- read.csv("http://datasets.flowingdata.com/post-data.txt")

map.market(id=posts$id, area=posts$views, 
           group=posts$category, 
           color=posts$comments, 
           main="FlowingData Map")
