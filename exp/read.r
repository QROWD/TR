# R code
# Luis P. F. Garcia 2018
# Read the time series and apply k-fold cross-validation

read <- function(files) {
  do.call("rbind", lapply(files, read.csv))
}

cfold <- function(data) {

  user = unique(data$user)

  tran = lapply(user, function(i) {
    subset(data, user %in% setdiff(user, i))
  })

  test = lapply(user, function(i) {
    subset(data, user %in% i)
  })

  tmp = list()
  tmp$user = user
  tmp$tran = tran
  tmp$test = test
  return(tmp)
}
