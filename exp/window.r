# R code
# Luis P. F. Garcia 2018
# Split the time series as flat tables and apply fft

dst <- function(data) {
  c(summary(data), kurtosis(data), skewness(data), gMean(data), 
    hMean(data), IQR(data))
}

dwt <- function(data) {
  aux = wavelets::dwt(data, filter="haar")
  return(aux@W$W1)
}

dft <- function(data) {
  aux = fft(data)#/length(data)
  sapply(aux, function(i) {
    signif(Mod(i), 4)
  })
}

magnitude <- function(x, y, z) {
  sqrt(x^2 + y^2 + z^2)
}

label <- function(data) {
  names(which.max(summary(data$class)))
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

window <- function(data, wtype, ftype, size) {

  aux = eval(call(wtype, data, size))
  tmp = t(sapply(aux, function(i) {
     eval(call(ftype, magnitude(i$x, i$y, i$z)))
  }))

  if(!is.null(data$class)) {
    class = sapply(aux, label)
    tmp = data.frame(tmp, class)
  }

  tmp = data.frame(tmp)
  return(tmp)
}
