# AR - Activity Recognition

The Activity Recognition (AR) project is the implementation of a system based on the accelerometer data to detect transportation modes. For this task, Data Mining (DM) and Machine Learning (ML) techniques were used in combination to pre-process the streaming data and provide confident labels for specific trips. In the pre-processing step, the accelerometer data was transformed using  Fast Fourier Transformation and in the ML step, standard techniques like Artificial Neural Networks, Decision Tree induction algorithms, k-Nearest Neighbour, Naive Bayes, Random Forest and Support Vector Machines were used. The result is a model able to predict the labels with high accuracy and confident level. 

## Technical Requirements

The system was develop in R version 3.4.4 -- "Someone to Lean On". To execute the code, the packages are required: e1071, kknn, randomForest, pROC, RWeka. The installation process is similar to other packages available on CRAN:

```r 
# install the packages
install.packages(c("e1071", "kknn", "randomForest", 
  "pROC", "RWeka"))
```

## Exemplo of use

```r
# load the code
setup()
# execute the evaluation
main(size=45)
```

## Developer notes

To submit bugs and feature requests, report at [project issues](https://github.com/QROWD/AR/issues).
