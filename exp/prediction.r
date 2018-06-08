# R code
# Luis P. F. Garcia 2018
# Predict the labels for new data

labels <- function(pred, wtype, size) {
  if(wtype == "slide") size = size/3;
  pred[rep(1:nrow(pred), each=size),]
}

build <- function(data, result, outputFile) {
  aux = nrow(data) - nrow(result)
  result = rbind(result, tail(result, aux))
  write.csv(result, outputFile, row.names=FALSE)
}

is.svm <- function(model) {
  any(class(model) == "svm")
}

# initialize the model given the path to the model file
init_model <- function (modelPath) {
  print("loading model...")
  model <<- readRDS(modelPath)
  print("done.")
}

# prediction call, will write output to 'out.csv'
prediction <- function(inputFile, outputFile="out.csv") {
  # read data from CSV file
  data = sampling(read(inputFile))

  test = window(data, model$wtype, model$ftype, model$size)
  pred = predict(model$model, test, type="prob", prob=TRUE)
  
  if(is.svm(model$model))
    pred = attr(pred, "probabilities")
  
  result = labels(pred, model$wtype, model$size)
  build(data, result, outputFile)
  return(0)
}
