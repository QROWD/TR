# R code
# Luis P. F. Garcia 2018
# Start the experiments

setup <- function() {
  aux = list.files("exp/", full.name=TRUE) 
  for(i in aux)
    source(i)
}

setup()
aux = commandArgs(TRUE)
do.call(aux[1], list(as.numeric(aux[2]), aux[3]))
