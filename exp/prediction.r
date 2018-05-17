# R code
# Luis P. F. Garcia 2018
# Predict the labels for new data

labels <- function(pred, wtype, size) {
  if(wtype == "slide") size = size/3;
  pred[rep(1:nrow(pred), each=size),]
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
  model = readRDS(model)

  if(nrow(data) < model$size)
    write.csv(NULL, "out.csv")

  test = window(data, model$wtype, model$ftype, model$size)
  pred = predict(model$model, test, type="prob", prob=TRUE)

  if(is.svm(model$model))
    pred = attr(pred, "probabilities")

  result = labels(pred, model$wtype, model$size)
  build(data, result)
  return(0)
}
