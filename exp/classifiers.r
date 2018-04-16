# R code
# Luis P. F. Garcia 2018
# Supervised Learning - Classifiers 

ANN <- function(train, test) {
  model = MLP(class ~ ., train)
  predict(model, test[,-ncol(test)], type="prob")
}

C4.5 <- function(train, test) {
  model = RWeka::J48(class ~ ., train)
  predict(model, test[,-ncol(test)], type="prob")
}

kNN <- function(train, test, k=5) {
  pred = kknn(class ~., train, test[,-ncol(test)], k=k)$prob
  rownames(pred) = rownames(test)
  return(pred)
}

NB <- function(train, test) {
  model = naiveBayes(class ~ ., train)
  pred = predict(model, test[,-ncol(test)], type="raw")
  rownames(pred) = rownames(test)
  return(pred)
}

RF <- function(train, test) {
  model = randomForest(class ~ ., train)
  predict(model, test[,-ncol(test)], type="prob")
}

SVM <- function(train, test) {
  model = svm(class ~ ., train, kernel="radial", probability=TRUE)
  pred = attr(predict(model, test[,-ncol(test)], probability=TRUE), "probabilities")
  pred = pred[,levels(train$class)]
}

multiclass.auc <- function(pred, class) {
  pred = apply(pred, 1, which.max)
  as.numeric(multiclass.roc(class, pred)$auc)
}

accuracy <- function(pred, class) {
  pred = factor(levels(class)[apply(pred, 1, which.max)], levels=levels(class))
  diag(table(class, pred))/colSums(table(class, pred))
}

performance <- function(pred, class) {
  c(multiclass.auc(pred, class), accuracy(pred, class))
}

classifiers <- function(train, test) {
  sapply(CLASSIFIERS, function(c) {
    pred = do.call(c, list(train, test))
    performance(pred, test$class)
  })
}
