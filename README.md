# AR - Activity Recognition

The Activity Recognition (AR) is the implementation of a system based on Machine Learning techniques to detect transportation modes using the accelerometer data of iLog users in QROWD project. The ML techniques were used in combination with Data Mining strategies to pre-process the streaming data and evaluate the models to provide confident labels for specific trips. The system is current available to predict the labels: bus, cycling, driving, walking and still. The techniques used include time windows and Fast Fourier Transformation (FFT) [1] to preprocess the data. In the ML level, classifiers like ANN, k-NN, Random Forest and SVM [2]. The result is a model able to predict the labels with high accuracy and confident level.  

## Technical requirements

The system was develop in R version 3.4.4 -- "Someone to Lean On" [3]. To execute the code, the packages `e1071`, `foreign`,  `kknn`, `randomForest` and `RWeka` are required. The installation process is similar to other packages available on CRAN:

```r 
# install the packages
install.packages(c("e1071", "foreign", "kknn", 
  "randomForest", "RWeka"))
```

## Exemplo of use

The simplest way to execute the code is load the `run.r` file. To generate and evaluate the models with the datasets available and export the model with highest performance, you need to call the `main` function. To change parameters like the size of the windows, you can use the `size` parameter:     

```r
# load the code
source("run.r")

# execute the code with window size like 45
main(size=450)
```

The output is the average performance of the models and the best model exported. The average performance is a matrix where the columns represent the classifiers available and the lines represent the accuracy for each label. The output is similar to that:

```r
              ANN      C4.5       kNN        NB        RF       SVM
bus     0.9172932 0.8421053 0.8872180 0.7067669 0.8646617 0.8571429
cycling 0.9347079 0.9072165 0.9072165 0.9175258 0.9621993 0.9518900
driving 0.9316406 0.7773438 0.9375000 0.8066406 0.9062500 0.8515625
still   0.7728707 0.6845426 0.7192429 0.9684543 0.7697161 0.9652997
walking 0.9965753 0.5513699 0.9931507 1.0000000 0.9828767 1.0000000
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

