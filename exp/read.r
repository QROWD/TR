# R code
# Luis P. F. Garcia 2018
# Read the time series and apply the diretional transformation

aggregate <- function(data) {
  data.frame(x=sqrt(data$x^2 + data$y^2 + data$z^2), class=data$class)
}

read <- function(files) {
  aggregate(do.call("rbind", lapply(files, read.csv)))
}
