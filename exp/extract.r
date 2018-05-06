# R code
# Luis P. F. Garcia 2018
# Export the best model based on the average accuracy

best <- function(result) {
  clf = colMeans(Reduce('+', result)/length(result))
  names(which.max(clf))
}

generate <- function(clf, type, size) {
  data = window(type, size, read(FILES))
  eval(call(clf, data, data))$model
}

extract <- function(result, type, size) {

  clf = best(result)
  model = generate(clf, type, size)
  return(model)
}
