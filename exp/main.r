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

main <- function(size) {

  result = lapply(FILES, function(file) {
    oracle(file, size)
  })

  save(result, size)
  return(result)
}
