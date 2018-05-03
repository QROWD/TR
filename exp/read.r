# R code
# Luis P. F. Garcia 2018
# Read the time series

aggregate <- function(data) {
  data.frame(x=sqrt(rowSums(data[,1:3]^2)), class=data$class)
}

read <- function(files) {
  aggregate(do.call("rbind", lapply(files, read.csv)))
}
