# R code
# Luis P. F. Garcia 2018
# Validate the models

oracle <- function(test) {

  train = window(read(setdiff(files, test)))
  test = window(read(test))
  classifiers(train, test)
}

main <- function() {

  test = split()
  sapply(1:3, function(i) {
      oracle(test[,i])
  })

}