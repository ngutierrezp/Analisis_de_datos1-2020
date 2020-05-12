
library(corrplot)

showCorplot <- function(df) {
  
  correlacion<-round(cor(df[1:(length(df)-1)], use="complete.obs"), 2)
  
  corrplot(correlacion, method="circle", type="lower")
  
}