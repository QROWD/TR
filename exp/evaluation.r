# R code
# Luis P. F. Garcia 2018
# Induce, evaluate and export the model

save <- function(model, wtype, ftype, size) {
  aux = list(model=model, wtype=wtype, ftype=ftype, size=size)
  saveRDS(aux, "model.rds")
}

oracle <- function(tran, test, wtype, ftype, size) {
  test = window(test, wtype, ftype, size)
  tran = window(tran, wtype, ftype, size)
  classifiers(tran, test)
}

evaluation <- function(wtype, ftype, size) {

  data = kfold(read(FILES))

  result = mapply(function(tran, test) {
    oracle(tran, test, wtype, ftype, size)
  }, tran=data$tran, test=data$test, 
  SIMPLIFY=FALSE)

  model = extract(data, result, wtype, ftype, size)
  save(model, wtype, ftype, size)
  return(result)
}
