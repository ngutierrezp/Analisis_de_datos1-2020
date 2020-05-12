
library(corrplot)

showCorplot <- function(df,numerical.vectors) {
  
  headers <- colnames(df)

  
  correlacion<-round(cor(df[numerical.vectors], use="complete.obs"), 2)
  
  corrplot(correlacion, method="circle", type="lower")
  
}