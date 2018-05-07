# R code
# Luis P. F. Garcia 2018
# Predict the labels for new data

labels <- function(size, pred) {
  label = rep(colnames(pred)[apply(pred, 1, which.max)], each=size)
  prob = rep(apply(pred, 1, max), each=size)
  data.frame(label=label, probabilitie=prob)
}

build <- function(data, result) {
  aux = nrow(data) - nrow(result)
  result = rbind(result, tail(result, aux))
  write.csv(result, "prediction.csv", row.names=FALSE)
}

is.svm <- function(model) {
  any(class(model) == "svm")
}

prediction <- function(model, file) {

  model = readRDS(model)
  data = read(file)

  test = window(data, model$type, model$size)
  pred = predict(model$model, test, type="prob", prob=TRUE)

  if(is.svm(model$model))
    pred = attr(pred, "probabilities")

  result = labels(model$size, pred)
  build(data, result)
  return(0)
}
