# R code
# Luis P. F. Garcia 2018
# Supervised Learning - Classifiers 

ANN <- function(tran, test) {
  model = MLP(class ~ ., tran)
  pred = predict(model, test[,-ncol(test)], type="prob")
  list(model, pred)
}

C4.5 <- function(tran, test) {
  model = RWeka::J48(class ~ ., tran)
  pred = predict(model, test[,-ncol(test)], type="prob")
  list(model, pred)
}

kNN <- function(tran, test, k=5) {
  pred = kknn(class ~., tran, test[,-ncol(test)], k=k)$prob
  rownames(pred) = rownames(test)
  list(NULL, pred)
}

NB <- function(tran, test) {
  model = naiveBayes(class ~ ., tran)
  pred = predict(model, test[,-ncol(test)], type="raw")
  rownames(pred) = rownames(test)
  list(model, pred)
}

RF <- function(tran, test) {
  model = randomForest(class ~ ., tran)
  pred = predict(model, test[,-ncol(test)], type="prob")
  list(model, pred)
}

SVM <- function(tran, test) {
  model = svm(class ~ ., tran, kernel="radial", probability=TRUE)
  pred = attr(predict(model, test[,-ncol(test)], probability=TRUE), "probabilities")
  pred = pred[,levels(tran$class)]
  list(model, pred)
}

accuracy <- function(pred, class) {
  class = factor(class, levels=colnames(pred))
  pred = factor(colnames(pred)[apply(pred, 1, which.max)], levels=colnames(pred))
  diag(table(class, pred))/rowSums(table(class, pred))
}

classifiers <- function(tran, test) {
  sapply(CLASSIFIERS, function(c) {
    pred = do.call(c, list(tran, test))[[2]]
    accuracy(pred, test$class)
  })
}
