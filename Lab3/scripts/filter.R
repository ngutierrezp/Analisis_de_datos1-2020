



filterItemSet <- function(itemset,top=20,itemsVector=NULL,itemsetSize=1,absolute=FALSE){
  
  
  # itemset = objeto itemset
  # top = cuantos reultados ordenanados se requiere
  # itemsVector = vector de caracteres c("...", "...", ...)
  # itemsetSize = largo de cada item set (mayor a itemsetSize )
  # absolute = TRUE Todos los elementos de itemsVector estan en el filtro.
  # absolute = FALSE Cualquiera de los elementos puede estar en el filtro.
  
  if (is.null(itemsVector)) {
    return(inspect(sort(itemsets[size(itemsets) >= itemsetSize], decreasing = TRUE)[1:top]))
    
  }
  else{
    
    if (absolute & is.vector(itemsVector) & is.character(itemsVector)) {
      itemsets_filtrado <- arules::subset(itemsets,
                                          subset = items %ain% itemsVector )
      
      return(inspect(sort(itemsets_filtrado[size(itemsets_filtrado) >= itemsetSize], decreasing = TRUE)[1:top]))
      
    }
    else if (!absolute & is.vector(itemsVector) & is.character(itemsVector) ) {
      itemsets_filtrado <- arules::subset(itemsets,
                                          subset = items %in% itemsVector )
      
      return(inspect(sort(itemsets_filtrado[size(itemsets_filtrado) >= itemsetSize], decreasing = TRUE)[1:top]))
      
    }
    else{
      message("ERROR: itemsVector debe ser un vector de caracteres validos")
    }
  }
  
}


filterRules <- function(rules,top=20,sortType="confidence",filterVector=NULL,absolute=FALSE, consequence = FALSE){
  # rules = objeto reglas
  # top= numero de elementos a mostrar
  # sortType= tipo de ordenamiento . puede ser por "confidence", "lift" , "count", "coverage"
  # filterVector= vector de elementos a filtrar
  # absolute= TRUE -> Todos los elementos de filterVector estan en el filtro.
  #           FALSE -> Cualquier elemento de filterVector estan en el filtro.
  # consequence = False -> filtro por antecedente
  #             = TRUE -> filtro por consecuente  
  
  if(is.null(filterVector)){
  
    return(inspect(sort(x = rules, decreasing = TRUE, by = sortType)[1:top]))
  }
  else if(absolute & is.vector(filterVector) & is.character(filterVector)){
  
    
    if ( consequence ){
      filtered.rules <- arules::subset(rules,
                                       subset = rhs %ain% filterVector )
      return(inspect(filtered.rules[1:top]))
    }
    else{
      filtered.rules <- arules::subset(rules,
                                       subset = lhs %ain% filterVector )
      return(inspect(filtered.rules[1:top]))
      
    }
    
  }
  else if (!absolute & is.vector(filterVector) & is.character(filterVector)) {
 
    if ( consequence ){
      filtered.rules <- arules::subset(rules,
                                       subset = rhs %in% filterVector )
      return(inspect(filtered.rules[1:top]))
    }
    else{
      filtered.rules <- arules::subset(rules,
                                       subset = lhs %in% filterVector )
      return(inspect(filtered.rules[1:top]))
      
    }
  }
  else{
    message("ERROR: filterVector debe ser un vector de caracteres validos")
  }
}