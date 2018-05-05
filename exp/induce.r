# R code
# Luis P. F. Garcia 2018
# Induce and export the models

save <- function(model, type, size) {
  aux = list(model=model, type=type, size=size)
  saveRDS(aux, "model.rds")
}

oracle <- function(type, size, file) {
  test = window(type, size, read(file))
  tran = window(type, size, read(setdiff(FILES, file)))
  classifiers(tran, test)
}

induce <- function(type, size) {

  size = as.numeric(size)
  result = lapply(FILES, function(file) {
    oracle(type, size, file)
  })

  model = extract(result, type, size)
  save(model, type, size)
  return(result)
}
