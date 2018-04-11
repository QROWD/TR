# R code
# Luis P. F. Garcia 2018
# Split the data as ts using fft 

comute <- function(data) {
  data.frame(x=sqrt(rowSums(data[,1:3]^2)), class=data$class)
}

ffourier <- function(data) {
  sapply(fft(data)/length(data), function(i) signif(Mod(i), 4))
}


window <- function(data, size=100) {

  data = comute(read(data))

  lapply(1:(nrow(data)/size), function(i) {
   ffourier(data[(((i-1)*size) + 1):(i*size),1])
  })


}