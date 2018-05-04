# R code
# Luis P. F. Garcia 2018
# Validate and extract the models

save <- function(result, type, size) {
  model = extract(result, type, size)
  saveRDS(model, "model.rds")
}

oracle <- function(type, size, file) {
  test = window(type, size, read(file))
  tran = window(type, size, read(setdiff(FILES, file)))
  classifiers(tran, test)
}

induce <- function(type, size, ...) {

  result = lapply(FILES, function(file) {
    oracle(type, size, file)
  })

  save(result, type, size)
  return(result)
}

evaluate <- function(type, size, file) {

  test = window(type, size, read(file))

  model = readRDS("model.rds")
  pred = predict(model, test, type="prob", prob=TRUE)
  label = colnames(pred)[apply(pred, 1, which.max)]
  prob = apply(pred, 1, max)

  result = data.frame(label=label, prob=prob)
  write.csv(result, "prediction.csv", row.names=FALSE)
  return(result)
}
