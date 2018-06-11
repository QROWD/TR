# R code
# Luis P. F. Garcia 2018
# Predict the labels for new data

labels <- function(pred, df, wtype, size) {

  if(wtype == "slide") {
    size = size/3;
  }

  aux = table(df$timestamp)
  sec = size/15

  result = lapply(1:(length(aux)/sec), function(i) {
    tmp = names(aux[((i-1)*sec + 1):(i*sec)])
    vet = subset(df, as.character(df$timestamp) %in% tmp)
    pred[rep(i, nrow(vet)),]
  })

  do.call("rbind", result)
}

build <- function(data, result, output) {
  aux = nrow(data) - nrow(result)
  result = rbind(result, tail(result, aux))
  write.csv(result, output, row.names=FALSE)
}

is.svm <- function(model) {
  any(class(model) == "svm")
}

init_model <- function (modelPath) {
  print("loading model...")
  model <<- readRDS(modelPath)
  print("done.")
}

prediction <- function(input, output="out.csv") {

  df = read(input)

  data = sampling(df)
  test = window(data, model$wtype, model$ftype, model$size)
  pred = predict(model$model, test, type="prob", prob=TRUE)

  if(is.svm(model$model))
    pred = attr(pred, "probabilities")


  
  result = labels(pred, df, model$wtype, model$size)
  build(df, result, output)
  return(0)
}
