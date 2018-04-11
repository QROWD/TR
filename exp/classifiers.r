# R code
# Luis P. F. Garcia 2018
# Supervised Learning - Classifiers 

ANN <- function(tran, test) {

  model = MLP(class ~ ., tran, control=Weka_control(L=0.3, M=0.5))
  pred = predict(model, test[,-ncol(test)], type="class")
  names(pred) = row.names(test)
  return(pred)
} 

C4.5 <- function(tran, test) {

  model = RWeka::J48(class ~., tran)
  pred = predict(model, test[,-ncol(test)], type="class")
  names(pred) = rownames(test)
  return(pred)
}

kNN <- function(tran, test) {

  pred = kknn(class ~., tran, test[,-ncol(test)], k=3)$fitted.values
  names(pred) = rownames(test)
  return(pred)
}

SVM <- function(tran, test) {

  model = svm(class ~., tran, kernel="radial")
  pred = predict(model, test[,-ncol(test)])
  return(pred)
}

accuracy <- function(pred, test) {
  sum(diag(table(test$class, pred)))/sum(table(test$class, pred))
}

classifiers <- function(tran, test) {
  sapply(CLASSIFIERS, function(c) {
    accuracy(do.call(c, list(tran, test)), test)
  })
}