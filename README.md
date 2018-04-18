# AR - Activity Recognition

The Activity Recognition (AR) project is the implementation of a system based on Machine Learning techniques to detect transportation modes using the accelerometer data of iLog users. The ML techniques were used in combination with Data Mining strategies to pre-process the streaming data and evaluate the models to provide confident labels for specific trips. The techniques used include FFT [1] to transform the data and classifiers like ANN, k-NN, Random Forest and SVM [2]. The result is a model able to predict the labels with high accuracy and confident level. 

## Technical requirements

The system was develop in R version 3.4.4 -- "Someone to Lean On" [3]. To execute the code, the packages `e1071`, `kknn`, `randomForest`, `pROC` and `RWeka` are required. The installation process is similar to other packages available on CRAN:

```r 
# install the packages
install.packages(c("e1071", "kknn", "randomForest", 
  "pROC", "RWeka"))
```

## Exemplo of use

The simplest way to execute the code is load the `run.r` file. To generate and evaluate the models with the datasets available and export the model with highest performance, you need to call the `main` function. To change parameters like the size of the windows, you can use the `size` parameter:     

```r
# load the code
source("run.r")

# execute the code with window size like 45
main(size=45)
```

The output is the average performance of the models and the best model exported. The average performance is a matrix where the columns represent the classifiers available and the lines represent the evaluation measures. We used two measures in the evaluation step: AUC and the accuracy for each label. The output is similar to that:

```
              ANN      C4.5       kNN        NB        RF       SVM
auc     0.8525507 0.9065861 0.9345537 0.8502743 0.9371712 0.9575692
cycling 0.9924528 0.9646018 0.9961686 0.9904762 0.9959514 1.0000000
driving 0.5916667 0.7788018 0.7594937 0.9928571 0.9246231 0.9430052
run     0.9742268 0.9219512 0.9947368 0.9219512 0.9742268 0.9742268
still   0.7958333 0.8478747 0.8484108 0.7925311 0.8712644 0.8656036
walking 0.9823789 0.9292605 0.9935275 0.8319783 0.9456193 0.9968454

```

The best model will be exported in the main folder with the name `model.rds` and can be loaded with `readRDS` function. 

## Add more data or labels

The datasets used in this project is a combination of public available accelerometer data [4]. and iLog data. You can add more data (from other users) including a new file in the subfolder datasets. The file needs to be a csv separated by comma with the accelerometer (x, y, and z) columns and the label column. The scale of the accelerometer data needs to respect the range [-32, 32]. To add more labels, is important to guarantee that at least 2 users have the same label to avoid errors in the evaluation process.

## Developer notes

To submit bugs and feature requests, report at [project issues](https://github.com/QROWD/AR/issues).

## References

[1] Cooley, James W., and Tukey, John W. (1965). An algorithm for the machine calculation of complex Fourier series, Mathematics of Computation, 19(90), 297-301.

[2] Mitchell, Thomas M. (1997). Machine Learning (1ed.), McGraw-Hill, Inc., New York, NY, USA.

[3] R Core Team (2018). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. URL https://www.R-project.org/.

[4] Choudhury, Romit R. (2014).  CS-199: Big Data Course. URL http://web.engr.illinois.edu/~croy/big-data-spring14/BigData-course.html.

