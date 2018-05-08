# R code
# Luis P. F. Garcia 2018
# Feature Selection based on PCA

pca <- function(data) {
  aux = prcomp(data)
  aux = which(summary(aux)$importance[3,] < 0.95)
  return(aux)
}

entropy <- function(data) {
  cfs(class ~ ., data)
}

selector <- function(data, type="entropy") {
  aux = eval(call(type, data))
  data = data.frame(data[,aux], class=data$class)
  return(data)
}
