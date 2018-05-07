# R code
# Luis P. F. Garcia 2018
# Execute the experiment

setup <- function() {
  aux = list.files("exp", full.name=TRUE) 
  sapply(aux, source, .GlobalEnv)
}

setup()
foo = commandArgs(TRUE)

switch(foo[1],
  evaluation = {
    evaluation(foo[2], as.numeric(foo[3]))
  }, prediction = {
    prediction(foo[2], foo[3])
  }
)
