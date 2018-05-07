# R code
# Luis P. F. Garcia 2018
# Split the time series as flat tables and apply fft

ff <- function(data) {
  aux = fft(data)/length(data)
  sapply(aux, function(i) {
    signif(Mod(i), 4)
  })
}

combine <- function(x, y, z) {
  sqrt(x^2 + y^2 + z^2)
}

static <- function(data, size) {
  aux = seq(1, nrow(data) - size, by=size)
  lapply(aux, function(i) {
    data[i:(i + size - 1),]
  })
}

slide <- function(data, size) {
  aux = seq(1, nrow(data) - size, by=size/3)
  lapply(aux, function(i) {
    data[i:(i + size - 1),]
  })
}

window <- function(data, type, size) {

  aux = eval(call(type, data, size))
  tmp = t(sapply(aux, function(i) {
    ff(combine(i$x, i$y, i$z))
  }))

  class = sapply(aux, "[", 1, "class")
  tmp = data.frame(tmp, class)
  return(tmp)
}
