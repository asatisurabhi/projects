# install.packages("quantmod", dependencies = TRUE)
library(quantmod)
# To output to a .pdf file.
# pdf("stocks00.pdf")

portfolio = c("GOOG","DOW","FB","MSFT","DTO")
#portfolio = c("GOOG","DOW","FB","GM","MSFT")

getSymbols("FB", src="yahoo",from="2000-01-01")
tail(FB)
chartSeries(FB)
barChart(FB,theme='white.mono',bar.type='hlc')
candleChart(FB,multi.col=TRUE,theme='white')
candleChart(FB,subset='2007-12::2008')
lineChart(FB,line.type='h',TA=NULL)
chartSeries(FB,theme="white",TA="addVo();addBBands();addCCI()")
chartSeries(FB,TA="addVo();addBBands();addCCI();addDEMA();addZLEMA()")

chartSeries(FB,theme="white") #draw the chart
chartSeries(FB)
addBBands() #add Bollinger Bands
addCCI() #add Commodity Channel Index

# close the file
# dev.off()
#################################


# last 2 years = 366*5 days of data

d = Sys.Date() - 366*2
d

portfolio = c("GOOG","DOW","FB","MSFT","DTO")
#portfolio = c("GOOG","DOW","FB","GM","MSFT")

# To output to a .pdf file.
# pdf("stocks01.pdf")

getSymbols("FB", src="yahoo", from=d)

tail(FB)
chartSeries(FB)
addBBands() #add Bollinger Bands

tail(FB)
chartSeries(FB)
addBBands() #add Bollinger Bands

tail(FB)
chartSeries(FB)
addBBands() #add Bollinger Bands

tail(FB)
chartSeries(FB)
addBBands() #add Bollinger Bands

tail(FB)
chartSeries(FB)
addBBands() #add Bollinger Bands

########################################################################
# last 30 days of data

d = Sys.Date() - 30
d

getSymbols("FB", from=d)

tail(GOOG)
chartSeries(GOOG,theme="white")

tail(FB)
chartSeries(FB,theme="white")

tail(F)
chartSeries(F,theme="white")

tail(MSFT)
chartSeries(MSFT,theme="white")

tail(DTO)
chartSeries(DTO,theme="white")

# close the file
# dev.off()
