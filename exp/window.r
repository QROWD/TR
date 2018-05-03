# R code
# Luis P. F. Garcia 2018
# Split the time series as flat table

ff <- function(data) {
  aux = fft(data)/length(data)
  sapply(aux, function(i) {
    signif(Mod(i), 4)
  })
}

index <- function(i, s) {
  (((i-1)*s) + 1):(i*s)
}

window <- function(data, size) {

  step = 1:(nrow(data)/size)
  aux = t(sapply(step, function(i) {
    ff(data[index(i, size), 1])
  }))

  aux = data.frame(aux)
  aux$class = data[step*size, 2]
  return(aux)
}
