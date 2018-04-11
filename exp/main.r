# R code
# Luis P. F. Garcia 2018
# Validate the models

comute <- function(data) {
  data.frame(x=sqrt(rowSums(data[,1:3]^2)), class=data$class)
}


ffourier <- function(train, test, size=100) {

  train = comute(read(train))
  test = comute(read(test))

  lapply(1:(nrow(train)/size), function(i) {
    data

  })



}



main <- function() {

  aux = split()
  lapply(1:3, function(i) {
    oracle(aux$train[,i], aux$test[,i])
  })

}