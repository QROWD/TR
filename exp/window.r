# R code
# Luis P. F. Garcia 2018
# Split the time series as flat tables

ff <- function(data) {
  aux = fft(data)/length(data)
  sapply(aux, function(i) {
    signif(Mod(i), 4)
  })
}

static <- function(size, data) {
  aux = 1:(nrow(data)/size)
  lapply(aux, function(i) {
    data[(((i-1)*size) + 1):(i*size),]
  })
}

slide <- function(size, data) {
  aux = seq(1, nrow(data) - size, by=size/3)
  lapply(aux, function(i) {
    data[i:(size + i -1),]
  })
}

window <- function(type, size, data) {

  aux = eval(call(type, size, data))
  tmp = t(sapply(aux, function(i) {
    ff(i$x)
  }))

  class = sapply(aux, "[", 1, "class")
  tmp = data.frame(tmp, class)
  return(tmp)
}
