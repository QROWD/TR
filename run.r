# R code
# Luis P. F. Garcia 2018
# Execute the experiment

load <- function() {
  aux = list.files("exp", full.name=TRUE) 
  for(file in aux) source(file);
}

load()
foo = commandArgs(TRUE)

switch(foo[1],
  evaluation = {
    evaluation(foo[2], foo[3], as.numeric(foo[4]))
  }, prediction = {
    prediction(foo[2], foo[3])
  }
)
