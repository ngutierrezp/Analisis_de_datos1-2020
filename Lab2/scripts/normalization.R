normalize.data.frame <- function(df){
  
  df$trestbps  = rescale(df$trestbps )
  df$chol  = rescale(df$chol )
  df$thalach = rescale(df$thalach)
  df$oldpeakyca = rescale(df$oldpeakyca)
  
  return(df)
  
}