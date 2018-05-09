# R code
# Luis P. F. Garcia 2018
# Evaluation measures

kappa <- function(true, pred) {

  aux = table(pred, true)
  pc = sum(apply(aux, 1, sum)/sum(aux) * apply(aux, 2, sum)/sum(aux))

  if(pc == 1 | is.nan(pc)) pc = 0;
  aux = (sum(diag(aux))/sum(aux) - pc)/(1 - pc)
  return(aux)
}

accuracy <- function(true, pred) {
  sum(diag(table(true, pred)))/sum(table(true, pred))
}

auc <- function(true, prob) {
  as.numeric(multiclass.roc(true, apply(prob, 1, max))$auc)
}

performance <- function(true, prob) {

  clas = colnames(prob)
  true = factor(true, levels=clas)
  pred = factor(clas[apply(prob, 1, which.max)], levels=clas)

  c(kappa=kappa(true, pred), acc=accuracy(true, pred),
    auc=auc(true, prob))
}
