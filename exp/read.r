# R code
# Luis P. F. Garcia 2018
# Read the time series and apply k-fold cross-validation

read <- function(files) {
  data.frame(do.call("rbind", lapply(files, read.csv)))
}

sampling <- function(data, hz=15) {

  data$timestamp = as.POSIXct(data$timestamp, format="%Y-%m-%dT%H:%M:%OS")
  aux = names(table(data$timestamp))

  foo = lapply(aux, function(i) {
    tmp = data[as.character(data$timestamp) == i,]
    tmp[seq(1, nrow(tmp), by=nrow(tmp)/hz),]
  })

  do.call("rbind", foo)
}

kfold <- function(data) {

  user = unique(data$user)

  tran = lapply(user, function(i) {
    subset(data, user %in% setdiff(user, i))
  })

  test = lapply(user, function(i) {
    subset(data, user %in% i)
  })

  tmp = list()
  tmp$tran = tran
  tmp$test = test
  return(tmp)
}
