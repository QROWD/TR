# R code
# Luis P. F. Garcia 2018
# Validate the models

oracle <- function(file, size) {

  test = window(read(file), size)
  train = window(read(setdiff(FILES, file)), size)
  classifiers(train, test)
}

main <- function(size) {

  aux = lapply(FILES, function(file) {
    oracle(file, size)
  })

  Reduce('+', aux)/length(aux)
}
