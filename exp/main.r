# R code
# Luis P. F. Garcia 2018
# Validate the models

oracle <- function(test, size) {

  train = window(read(setdiff(files, test)), size)
  test = window(read(test), size)
  classifiers(train, test)
}

main <- function(size) {

  test = split()
  aux = lapply(1:3, function(i) {
    oracle(test[,i], size)
  })

  rowMeans(aux)
}


#lapply(seq(10, 100, by=10), main)