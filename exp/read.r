# R code
# Luis P. F. Garcia 2018
# Read and split the data

split <- function() {

  train = apply(FOLDS, 2, function(i) {
    FILES[grepl(i[1], FILES) | grepl(i[2], FILES)]
  })

  test = sapply(c(3,2,1), function(i) {
    FILES[grepl(i, FILES)]
  })

  aux = list()
  aux$train = train
  aux$test = test
  aux
}

read <- function(files) {
  do.call("rbind", 
    lapply(files, function(file) {
      read.csv(file)
    })
  )
}
