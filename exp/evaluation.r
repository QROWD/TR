# R code
# Luis P. F. Garcia 2018
# Induce, evaluate and export the model

save <- function(model, type, size) {
  aux = list(model=model, type=type, size=size)
  saveRDS(aux, "model.rds")
}

oracle <- function(tran, test, type, size) {
  test = window(test, type, size)
  tran = window(tran, type, size)
  classifiers(tran, test)
}

evaluation <- function(type, size) {

  data = cfold(read(FILES))

  result = lapply(data$user, function(i) {
    oracle(data$tran[[i]], data$test[[i]], type, size)
  })

  model = extract(result, type, size)
  save(model, type, size)
  return(result)
}
