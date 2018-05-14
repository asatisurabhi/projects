library(leaflet)
m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=-122.08405749999997, 
             lat=37.4219999, popup="Hello from Google!")
m  # Print the map



library(leaflet)
m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=-122.417743, 
             lat=37.808, popup="Fisherman's wharf! :)")
m  # Print the map








## create a sequential palette for usage and show colors
mypalette<-brewer.pal(7,"Greens")
image(1:7,1,as.matrix(1:7),col=mypalette,xlab="Greens (sequential)",
      ylab="",xaxt="n",yaxt="n",bty="n")
## display a divergent palette
display.brewer.pal(7,"BrBG")
devAskNewPage(ask=TRUE)
## display a qualitative palette
display.brewer.pal(7,"Accent")
devAskNewPage(ask=TRUE)
## display a palettes simultanoeusly
display.brewer.all(n=10, exact.n=FALSE)
devAskNewPage(ask=TRUE)
display.brewer.all(n=10)
devAskNewPage(ask=TRUE)
display.brewer.all()
devAskNewPage(ask=TRUE)
display.brewer.all(type="div")
devAskNewPage(ask=TRUE)
display.brewer.all(type="seq")
devAskNewPage(ask=TRUE)
display.brewer.all(type="qual")
devAskNewPage(ask=TRUE)
display.brewer.all(n=5,type="div",exact.n=TRUE)
devAskNewPage(ask=TRUE)
display.brewer.all(colorblindFriendly=TRUE)
devAskNewPage(ask=TRUE)
brewer.pal.info
brewer.pal.info["Blues",]
brewer.pal.info["Blues",]$maxcolors



???Topic color
RColorBrewer, 1
brewer (RColorBrewer), 1
ColorBrewer (RColorBrewer), 1
colors (RColorBrewer), 1
display.brewer.all (RColorBrewer), 1
display.brewer.pal (RColorBrewer), 1
RColorBrewer, 1