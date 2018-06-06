# R code
# Luis P. F. Garcia 2018
# Measures for the dsf

gMean <- function(x) {
  mean(x^(1/length(x)))
}

hMean <- function(x) {
  length(x)/sum(1/x)
}