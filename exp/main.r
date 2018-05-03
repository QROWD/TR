# R code
# Luis P. F. Garcia 2018
# Validate and extract the models

save <- function(result, size) {
  model = extract(result, size)
  saveRDS(model, "model.rds")
}

oracle <- function(file, size) {
  test = window(read(file), size)
  tran = window(read(setdiff(FILES, file)), size)
  classifiers(tran, test)
}

evaluate <- function(size) {

  result = lapply(FILES, function(file) {
    oracle(file, size)
  })

  save(result, size)
  return(result)
}

execute <- function(file, size) {

  test = window(read(file), size)

  model = readRDS("model.rds")
  pred = predict(model, test, type="prob", prob=TRUE)

  label = colnames(pred)[apply(pred, 1, which.max)]
  prob = apply(pred, 1, max)

  result = data.frame(label=label, prob=prob)
  return(result)
}
