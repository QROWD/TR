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

switch(foo[1],
  evaluate = {
    evaluation(foo[2], as.numeric(foo[3]))
  }, praedicere = {
    praediction(foo[2], foo[3])
  }
)
