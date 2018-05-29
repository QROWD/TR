# TR

The Transportation Recognition (TR) is the implementation of a system based on Machine Learning techniques to detect transportation modes using the accelerometer data of iLog users in QROWD project. The ML techniques were used in combination with Data Mining strategies to pre-process the streaming data and evaluate the models to provide confident labels for specific trips like bike, bus, car, train and walk. The result is a model able to predict new data  with high accuracy and high confident level.

## Technical requirements

The system was develop in R version 3.4.4 -- "Someone to Lean On" [3]. To execute the code, the packages `e1071`,  `kknn`, `randomForest`, `rJava`, `rpart`, `RWeka`, `xgboost` and `wavelets` are required. The installation process is similar to other packages available on CRAN:

```r 
# install the packages
install.packages(c("e1071", "kknn", "randomForest", "rJava", "rpart", 
  "RWeka", "xgboost", "wavelets", "optparse"))
```

## Exemplo of use

The Data Mining techniques used include Time Window operations and Signal Processing methods [1] to preprocess the data. In the ML level, classifiers like Adaboost, ANN, C4.5, CART, k-NN, Random Forest, SVM and XGBoost [2] are used. The simplest way to generate and evaluate the models with the datasets available is calling the `evaluation` function. The parameters are the window type (`static` or `slide`), the discrete transformation (`dft` or `dwt`) and the window `size`:

```r
# induce and export the best model 
Rscript --vanilla run.r evaluation static dft 450
```

The output is the average performance of the models by user and the best model exported. The average performance is a matrix where the columns represent the classifiers available and the lines represent the evaluation measures. The output is similar to that:

```r
       Adaboost       ANN      C4.5      CART       kNN        RF       SVM   XGBoost
acc   0.7888889 0.3944444 0.6888889 0.6722222 0.7111111 0.9222222 0.8500000 0.7500000
kappa 0.7452609 0.2950054 0.6258630 0.6053218 0.6519023 0.9060087 0.8180457 0.6983240
f1    0.7702942       NaN 0.6681776 0.6377189 0.6854913 0.9138142 0.8371931 0.7276259
```

The best model will be exported in the main folder with the name `model.rds`. To evaluate a new data, you can call the `prediction` function with the `model` and `file` path:

```r
# use the exported model to predict the new data
Rscript --vanilla run.r prediction model.rds test.txt
```

The output is a table called `out.csv` with the label and associated probability column.

## Add more data or labels

The datasets used in this project is a combination of public available accelerometer data [4]. and iLog data. You can add more data (from other users) including a new file in the subfolder datasets. The file needs to be a csv separated by comma with the user id, accelerometer (x, y, and z) and the label columns. To add more labels, is important to guarantee that at least 2 users have the same label to avoid errors in the evaluation process.

## Developer notes

To submit bugs and feature requests, report at [project issues](https://github.com/QROWD/TR/issues).

## References

[1] Martin Vetterli, Jelena Kovačević and Vivek K. Goyal. (2014). Foundations of Signal Processing, 1ed, Cambridge University Press.

[2] Thomas M. Mitchell. (1997). Machine Learning, 1ed, McGraw-Hill.

[3] R Core Team. (2018). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. URL https://www.R-project.org/.

[4] Romit R. Choudhury. (2014). CS-199: Big Data Course. URL http://web.engr.illinois.edu/~croy/big-data-spring14/BigData-course.html.

