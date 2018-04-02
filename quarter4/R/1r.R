### synthetic data

# Consider book price (y) by number of pages (x)

z = c("hardcover","hardcover",
      "hardcover","hardcover",
      "paperback", "paperback","paperback", 
      "paperback")

x1 = c( 150, 225, 342, 185)
y1 = c( 27.43, 48.76, 50.25, 32.01 )

x2 = c( 475, 834, 1020, 790)
y2 = c( 10.00, 15.73, 20.00, 17.89 )

x = c(x1, x2)
y = c(y1, y2)

plot(x,y)


lm(y ~ x)
lm(y1~x1)
lm(y2~x2)


cor(x,y)
cor(x1,y1)
cor(x2,y2)
lm(y ~ x + z)
