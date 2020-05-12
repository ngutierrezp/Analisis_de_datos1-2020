


showCorplot <- function(df) {
  
  correlacion<-round(cor(df[1:(length(df)-1)]), 1)
  
  corrplot(correlacion, method="number", type="lower")
  
  
}