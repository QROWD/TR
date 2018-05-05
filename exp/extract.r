# R code
# Luis P. F. Garcia 2018
# Extract the best model

best <- function(result) {
  clf = colMeans(Reduce('+', result)/length(result))
  names(which.max(clf))
}

generate <- function(clf, type, size) {
  data = window(type, size, read(FILES))
  eval(call(clf, data, data))
}

extract <- function(result, type, size) {

  clf = best(result)
  model = generate(clf, type, size)[[1]]
  return(model)
}
