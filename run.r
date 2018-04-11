# R code
# Luis P. F. Garcia 2018
# Start the experiments

setup <- function() {
  aux = list.files("exp/", full.name=TRUE) 
  for(i in aux)
    source(i)
}

setup()
main()
