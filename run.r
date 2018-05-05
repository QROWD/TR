# R code
# Luis P. F. Garcia 2018
# Start the experiments

setup <- function() {
  aux = list.files("exp/", full.name=TRUE) 
  for(i in aux)
    source(i)
}

setup()
foo = commandArgs(TRUE)
eval(call(foo[1], foo[2], foo[3]))
