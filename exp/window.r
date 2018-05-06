# R code
# Luis P. F. Garcia 2018
# Split the time series as flat tables and apply fft

ff <- function(data) {
  aux = fft(data)/length(data)
  sapply(aux, function(i) {
    signif(Mod(i), 4)
  })
}

static <- function(size, data) {
  aux = seq(1, nrow(data) - size, by=size)
  lapply(aux, function(i) {
    data[i:(i + size - 1),]
  })
}

slide <- function(size, data) {
  aux = seq(1, nrow(data) - size, by=size/3)
  lapply(aux, function(i) {
    data[i:(i + size - 1),]
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
