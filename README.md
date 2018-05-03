# AR - Activity Recognition

The Activity Recognition (AR) is the implementation of a system based on Machine Learning techniques to detect transportation modes using the accelerometer data of iLog users in QROWD project. The ML techniques were used in combination with Data Mining strategies to pre-process the streaming data and evaluate the models to provide confident labels for specific trips. The system is current available to predict the labels: bike, bus, car, still, train and walk. The techniques used include time windows and Fast Fourier Transformation (FFT) [1] to preprocess the data. In the ML level, classifiers like ANN, C4.5, k-NN, Random Forest and SVM [2] are used. The result is a model able to predict the labels with high accuracy and confident level.  

## Technical requirements

The system was develop in R version 3.4.4 -- "Someone to Lean On" [3]. To execute the code, the packages `e1071`,  `kknn`, `randomForest` and `RWeka` are required. The installation process is similar to other packages available on CRAN:

```r 
# install the packages
install.packages(c("e1071", "kknn", 
  "randomForest", "RWeka"))
```

## Exemplo of use

The simplest way to execute the code is load the `run.r` file. To generate and evaluate the models with the datasets available and export the model with highest performance, you need to call the `main` function. To change parameters like the size of the windows, you can use the `size` parameter:     

```r
# load the code
source("run.r")

# evalaute all the classifiers with window size as 450
evaluate(size=450)
```

The output is the average performance of the models and the best model exported. The average performance is a matrix where the columns represent the classifiers available and the lines represent the accuracy for each label. The output is similar to that:

```r
             ANN      C4.5       kNN        NB        RF       SVM
bike  0.72413793 0.8620690 0.3448276 1.0000000 0.9310345 0.7241379
bus   0.88461538 0.6153846 0.8461538 0.5384615 0.7307692 0.6923077
car   0.03846154 0.1346154 0.8846154 0.8461538 0.8653846 0.8461538
still 0.00000000 0.5806452 0.7419355 0.5483871 0.8709677 0.9032258
train 0.06451613 0.9354839 0.9677419 0.9677419 0.9677419 0.9677419
walk  0.75862069 0.4827586 0.5862069 1.0000000 1.0000000 1.0000000
```

The best model will be exported in the main folder with the name `model.rds`. To evaluate a new data, you can call the `execute` function with the file path and window size:

```r

# use the exported model to predict the new data with window size as 450
execute(file="test.csv", size=450)
```

The output is a table with the label and associated probability column.

## Add more data or labels

The datasets used in this project is a combination of public available accelerometer data [4]. and iLog data. You can add more data (from other users) including a new file in the subfolder datasets. The file needs to be a csv separated by comma with the accelerometer (x, y, and z) columns and the label column. The scale of the accelerometer data needs to respect the range [-32, 32]. To add more labels, is important to guarantee that at least 2 users have the same label to avoid errors in the evaluation process.

## Developer notes

To submit bugs and feature requests, report at [project issues](https://github.com/QROWD/AR/issues).

## References

[1] Cooley, James W., and Tukey, John W. (1965). An algorithm for the machine calculation of complex Fourier series, Mathematics of Computation, 19(90), 297-301.

[2] Mitchell, Thomas M. (1997). Machine Learning (1ed.), McGraw-Hill, Inc., New York, NY, USA.

[3] R Core Team (2018). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. URL https://www.R-project.org/.

[4] Choudhury, Romit R. (2014).  CS-199: Big Data Course. URL http://web.engr.illinois.edu/~croy/big-data-spring14/BigData-course.html.

