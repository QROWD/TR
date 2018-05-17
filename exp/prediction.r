# R code
# Luis P. F. Garcia 2018
# Predict the labels for new data

labels <- function(pred, wtype, size) {

  if(wtype == "slide") {
    size = size/3
  }

  pred = pred[rep(1:nrow(pred), each=size),]
  return(pred)
}

build <- function(data, result) {
  aux = nrow(data) - nrow(result)
  result = rbind(result, tail(result, aux))
  result = data.frame(data$timestamp, result)
  write.csv(result, "out.csv", row.names=FALSE)
}

is.svm <- function(model) {
  any(class(model) == "svm")
}

prediction <- function(model, file) {

  data = read(file)
  m = readRDS(model)

  if(nrow(data) < m$size) {
    file.create("out.csv")
    return(0)
  }

  test = window(data, m$wtype, m$ftype, m$size)
  pred = predict(m$model, test, type="prob", prob=TRUE)

  if(is.svm(m$model))
    pred = attr(pred, "probabilities")

  result = labels(pred, m$wtype, m$size)
  build(data, result)
  return(0)
}
