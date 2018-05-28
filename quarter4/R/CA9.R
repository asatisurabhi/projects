# install.packages("quantmod", dependencies = TRUE)
library(quantmod)
# To output to a .pdf file.
# pdf("stocks00.pdf")

portfolio = c("BTC-USD","BTC-USD","BTC-USD","MSFT","DTO")
#portfolio = c("BTC-USD","DOW","`BTC-USD`","GM","MSFT")

getSymbols("BTC-USD", src="yahoo",from="2000-01-01")
tail(`BTC-USD`)
chartSeries(`BTC-USD`)
barChart(`BTC-USD`,theme='white.mono',bar.type='hlc')
candleChart(`BTC-USD`,multi.col=TRUE,theme='white')
candleChart(`BTC-USD`,subset='2007-12::2008')
lineChart(`BTC-USD`,line.type='h',TA=NULL)
chartSeries(`BTC-USD`,theme="white",TA="addVo();addBBands();addCCI()")
chartSeries(`BTC-USD`,TA="addVo();addBBands();addCCI();addDEMA();addZLEMA()")

chartSeries(`BTC-USD`,theme="white") #draw the chart
chartSeries(`BTC-USD`)
addBBands() #add Bollinger Bands
addCCI() #add Commodity Channel Index

# close the file
# dev.off()
#################################


# last 2 years = 366*5 days of data

d = Sys.Date() - 366*2
d

portfolio = c("`BTC-USD`","DOW","`BTC-USD`","MSFT","DTO")
#portfolio = c("`BTC-USD`","DOW","`BTC-USD`","GM","MSFT")

# To output to a .pdf file.
# pdf("stocks01.pdf")

getSymbols("`BTC-USD`", src="yahoo", from=d)

tail(`BTC-USD`)
chartSeries(`BTC-USD`)
addBBands() #add Bollinger Bands

tail(`BTC-USD`)
chartSeries(`BTC-USD`)
addBBands() #add Bollinger Bands

tail(`BTC-USD`)
chartSeries(`BTC-USD`)
addBBands() #add Bollinger Bands

tail(`BTC-USD`)
chartSeries(`BTC-USD`)
addBBands() #add Bollinger Bands

tail(`BTC-USD`)
chartSeries(`BTC-USD`)
addBBands() #add Bollinger Bands

########################################################################
# last 30 days of data

d = Sys.Date() - 30
d

getSymbols("BTC-USD", from=d)

tail(`BTC-USD`)
chartSeries(`BTC-USD`,theme="white")

tail(`BTC-USD`)
chartSeries(`BTC-USD`,theme="white")

tail(F)
chartSeries(F,theme="white")

tail(MSFT)
chartSeries(MSFT,theme="white")

tail(DTO)
chartSeries(DTO,theme="white")

# close the file
# dev.off()
