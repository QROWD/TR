# R code
# Luis P. F. Garcia 2018
# Predict the labels for new data

labels <- function(model, pred) {
  label = rep(colnames(pred)[apply(pred, 1, which.max)], each=model$size)
  prob = rep(apply(pred, 1, max), each=model$size)
  data.frame(label=label, prob=prob)
}

prediction <- function(model, file) {

  model = readRDS(model)
  data = window(model$type, model$size, read(file))
  pred = predict(model$model, data, type="prob", prob=TRUE)

  if(any(class(model$model) == "svm"))
    pred = attr(pred, "probabilities")

  result = labels(model, pred)
  write.csv(result, "prediction.csv", row.names=FALSE)
  return(result)
}
