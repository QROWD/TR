# R code
# Luis P. F. Garcia 2018
# Supervised Learning - Classifiers 

ANN <- function(train, test) {

  model = mlp(class ~ ., train, control=RWeka::Weka_control(L=0.3, M=0.5))
  pred = predict(model, test[,-ncol(test)], type="prob")
  names(pred) = row.names(test)
  return(pred)
}

C4.5 <- function(train, test) {
  model = RWeka::J48(class ~ ., train)
  pred = predict(model, test[,-ncol(test)], type="prob")
  return(pred)
}

kNN <- function(train, test, k=5) {
  pred = kknn(class ~., train, test[,-ncol(test)], k=k)$prob
  rownames(pred) = rownames(test)
  return(pred)
}

LM <- function(train, test) {
  model = svm(class ~ ., train, kernel="linear",  probability=TRUE)
  pred = attr(predict(model, test[,-ncol(test)], probability=TRUE), "probabilities")
  pred = pred[,levels(train$class)]
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
  pred = predict(model, test[,-ncol(test)], type="prob")
   return(pred)
}

SVM <- function(train, test) {
  model = svm(class ~ ., train, kernel="radial", probability=TRUE)
  pred = attr(predict(model, test[,-ncol(test)], probability=TRUE), "probabilities")
  pred = pred[,levels(train$class)]
  return(pred)
}

multi.auc <- function(pred, class) {
  pred = pred[cbind(seq_along(class), class)]
  as.numeric(multiclass.roc(class, pred)$auc)
}

classifiers <- function(train, test) {
  sapply(CLASSIFIERS, function(c) {
    pred = do.call(c, list(train, test))
    multi.auc(pred, test$class)
  })
}
