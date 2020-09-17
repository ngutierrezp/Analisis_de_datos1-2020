renormalize.data.frame <- function(df){
  
  df$trestbps  = rescale(df$trestbps )
  df$chol  = rescale(df$chol )
  df$thalach = rescale(df$thalach)
  df$oldpeakyca = rescale(df$oldpeakyca)
  df$exang = rescale(df$exang)
  df$cp = rescale(df$cp)
  
  return(df)
  
}

normalize.data.frame <- function(df){
  
  result <- apply(df[ , 1:ncol(df)], MARGIN = 2, scale)
  
  return(result)
  
}