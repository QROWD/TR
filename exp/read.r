# R code
# Luis P. F. Garcia 2018
# Read the time series and apply k-fold cross-validation

read <- function(files) {
  data = data.frame(do.call("rbind", lapply(files, read.csv)))
  data$timestamp = as.POSIXct(data$timestamp, format="%Y-%m-%d %H:%M:%OS")
  return(data)
}

sampling <- function(data, hz=15, cores=10) {

  aux = names(table(data$timestamp))

  foo = mclapply(aux, mc.cores=cores, function(i) {
    tmp = subset(data, as.character(timestamp) %in% i)
    vet = seq(1, nrow(tmp), length.out=hz)
    tmp[vet,]
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
