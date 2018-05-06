# R code
# Luis P. F. Garcia 2018
# Supervised learning classifiers 

ANN <- function(tran, test) {
  model = MLP(class ~ ., tran)
  pred = predict(model, test[,-ncol(test)], type="prob")
  list(model=model, pred=pred)
}

CART <- function(tran, test) {
  model = rpart(class ~ ., tran)
  pred = predict(model, test[,-ncol(test)], type="prob")
  list(model=model, pred=pred)
}

kNN <- function(tran, test, k=5) {
  model = kknn(class ~., tran, test[,-ncol(test)], k=k)
  pred = model$prob
  rownames(pred) = rownames(test)
  list(model=model, pred=pred)
}

RF <- function(tran, test) {
  model = randomForest(class ~ ., tran)
  pred = predict(model, test[,-ncol(test)], type="prob")
  list(model=model, pred=pred)
}

SVM <- function(tran, test) {
  model = svm(class ~ ., tran, kernel="radial", probability=TRUE)
  pred = attr(predict(model, test[,-ncol(test)], probability=TRUE), "probabilities")
  pred = pred[,levels(tran$class)]
  list(model=model, pred=pred)
}

accuracy <- function(pred, class) {
  class = factor(class, levels=colnames(pred))
  pred = factor(colnames(pred)[apply(pred, 1, which.max)], levels=colnames(pred))
  diag(table(class, pred))/rowSums(table(class, pred))
}

classifiers <- function(tran, test) {
  sapply(CLASSIFIERS, function(c) {
    pred = do.call(c, list(tran, test))
    accuracy(pred$pred, test$class)
  })
}
