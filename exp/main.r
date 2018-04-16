# R code
# Luis P. F. Garcia 2018
# Validate the models

oracle <- function(file, size) {
  test = window(read(file), size)
  train = window(read(setdiff(FILES, file)), size)
  classifiers(train, test)
}

main <- function(size) {

  result = lapply(FILES, function(file) {
    oracle(file, size)
  })

  print(result)
  model = extract(result, size)
  saveRDS(model, "model.rds")
}
