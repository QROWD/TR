# R code
# Luis P. F. Garcia 2018
# Read and split the data as a time series

aggregate <- function(data) {
  data.frame(x=sqrt(rowSums(data[,1:3]^2)), class=data$class)
}

ff <- function(data) {
  aux = fft(data)/length(data)
  sapply(aux, function(i) { 
    signif(Mod(i), 4)
  })
}

split <- function() {
  sapply(c(3,2,1), function(i) {
    files[grepl(i, files)]
  })
}

read <- function(files) {
  aggregate(do.call("rbind", lapply(files, read.csv)))
}

window <- function(data, size=100) {

  step = 1:(nrow(data)/size)
  aux = t(sapply(step, function(i) {
    ff(data[(((i-1)*size) + 1):(i*size),1])
  }))

  data.frame(aux, class=data[step*size, 2])
}
