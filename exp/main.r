# R code
# Luis P. F. Garcia 2018
# Validate the models

oracle <- function(train, test) {

    train = windom(train)
    test = windom(test)
    classifiers(train, test)
}

main <- function() {

  aux = split()
  lapply(1:3, function(i) {
    oracle(aux[[1]][,i], aux[[2]][,i])
  })

}