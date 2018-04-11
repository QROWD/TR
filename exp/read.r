# R code
# Luis P. F. Garcia 2018
# Read and split the data

split <- function() {

  train = apply(folds, 2, function(i) {
    files[grepl(i[1], files) | grepl(i[2], files)]
  })

  test = sapply(c(3,2,1), function(i) {
    files[grepl(i, files)]
  })

  list(train, test)
}

read <- function(files) {
  do.call("rbind", lapply(files, function(file) {
      read.csv(file)
  }))
}
