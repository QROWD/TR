# R code
# Luis P. F. Garcia 2018
# Supervised learning classifiers 

ANN <- function(tran, test) {
  model = MLP(class ~ ., tran)
  .jcache(model$classifier)
  pred = predict(model, test[,-ncol(test)], type="prob")
  list(model=model, pred=pred)
}

C4.5 <- function(tran, test) {
  model = J48(class ~ ., tran)
  .jcache(model$classifier)
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
  list(model=model, pred=model$prob)
}

RF <- function(tran, test) {
  model = randomForest(class ~ ., tran)
  pred = predict(model, test[,-ncol(test)], type="prob")
  list(model=model, pred=pred)
}

SVM <- function(tran, test) {
  model = svm(class ~ ., tran, kernel="radial", probability=TRUE)
  pred = attr(predict(model, test, probability=TRUE), "probabilities")
  pred = pred[,levels(tran$class)]
  list(model=model, pred=pred)
}

XGBoost <- function(tran, test) {

  tran.y = as.numeric(tran$class) -1
  model = xgboost(as.matrix(tran[,-ncol(tran)]), label=tran.y, nrounds=50, 
    num_class=max(tran.y) +1, objective="multi:softprob",
    eval_metric="mlogloss", verbose=0)

  pred = predict(model, as.matrix(test[,-ncol(test)]))
  pred = matrix(pred, nrow=nrow(test), ncol=max(tran.y) +1, byrow=TRUE)
  colnames(pred) = levels(tran$class)
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
