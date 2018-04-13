# R code
# Luis P. F. Garcia 2018
# Config File 

# Packages
require(e1071)
require(kknn)
require(randomForest)
require(pROC)

# list of classifiers
CLASSIFIERS = c("ANN", "C4.5", "kNN", "LM", "NB", "RF", "SVM")

# datasets
files = list.files(path="datasets", full.names=TRUE, recursive=TRUE)

# folds to split the data
folds = combn(c(1, 2, 3), 2)

# mlp classifier
mlp = RWeka::make_Weka_classifier("weka/classifiers/functions/MultilayerPerceptron")
