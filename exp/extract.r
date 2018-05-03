# R code
# Luis P. F. Garcia 2018
# Extract the best model

best <- function(result) {
  clf = Reduce('+', result)/length(result)
  names(which.max(colMeans(clf)))
}

generate <- function(clf, size) {
  data = window(read(FILES), size)
  do.call(clf, list(data, data))
}

extract <- function(result, size) {

  clf = best(result)
  model = generate(clf, size)[[1]]
  return(model)
}
