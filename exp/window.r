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

slide <- function(size, data, step=150) {
  aux = seq(1, nrow(data) - size, by=step)
  lapply(aux, function(i) {
    data[i:(size + i -1),]
  })
}

window <- function(type, size, data) {

  aux = eval(call(type, size, data))
  tmp = t(sapply(aux, function(i) {
    ff(i$x)
  }))

  tmp = data.frame(tmp)
  tmp$class = sapply(aux, "[", 1, "class")
  return(tmp)
}
