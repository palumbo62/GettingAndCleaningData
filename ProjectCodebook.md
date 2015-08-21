Human-Activity-Recognition-Using-Smartphones Project Codebook
=============================================================

This codebook was created on 2015-08-21 17:52:51.  It is auto-generated at the 
end of each execution run of the run_analysis.R script.


Tidy Dataset Variable Names
---------------------------

Variable Name    | Description
-----------------|------------
SubjectID        | Numeric identifier of each test subject responsible for performing each observation sample. 
ActivityID       | Descriptive name of each performed/sampled activity. 
MeasurementID    | Identifier for each sample measurement that was recorded for each subject and activity performed.
MeanValue        | Calculated 'mean' value for each specific observation set per subject/activity/measurement.


Tidy Dataset Structure
----------------------

```r
str(tidyData)
```

```
## 'data.frame':	11880 obs. of  4 variables:
##  $ SubjectID    : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ ActivityID   : Factor w/ 6 levels "LAYING","SITTING",..: 1 1 1 1 1 1 1 1 1 1 ...
##  $ MeasurementID: Factor w/ 477 levels "angle(tBodyAccJerkMean),gravityMean)",..: 43 44 45 56 57 58 94 95 96 107 ...
##  $ MeanValue    : num  -0.939 -0.867 -0.883 -0.924 -0.834 ...
```

TidyData Class:
---------------

```r
class(tidyData)
```

```
## [1] "data.frame"
```

Tidy Dataset Head/Tail
----------------------

```r
head(tidyData)
```

```
##   SubjectID ActivityID     MeasurementID  MeanValue
## 1         1     LAYING fBodyAcc-mean()-X -0.9390991
## 2         1     LAYING fBodyAcc-mean()-Y -0.8670652
## 3         1     LAYING fBodyAcc-mean()-Z -0.8826669
## 4         1     LAYING  fBodyAcc-std()-X -0.9244374
## 5         1     LAYING  fBodyAcc-std()-Y -0.8336256
## 6         1     LAYING  fBodyAcc-std()-Z -0.8128916
```

```r
tail(tidyData)
```

```
##       SubjectID       ActivityID         MeasurementID   MeanValue
## 11875        30 WALKING_UPSTAIRS  tGravityAcc-mean()-Z -0.02214011
## 11876        30 WALKING_UPSTAIRS   tGravityAcc-std()-X -0.95403362
## 11877        30 WALKING_UPSTAIRS   tGravityAcc-std()-Y -0.91493394
## 11878        30 WALKING_UPSTAIRS   tGravityAcc-std()-Z -0.86240279
## 11879        30 WALKING_UPSTAIRS tGravityAccMag-mean() -0.13762786
## 11880        30 WALKING_UPSTAIRS  tGravityAccMag-std() -0.32741082
```

Tidy Dataset Summary
--------------------

```r
summary(tidyData)
```

```
##    SubjectID                 ActivityID             MeasurementID  
##  Min.   : 1.0   LAYING            :1980   fBodyAcc-mean()-X:  180  
##  1st Qu.: 8.0   SITTING           :1980   fBodyAcc-mean()-Y:  180  
##  Median :15.5   STANDING          :1980   fBodyAcc-mean()-Z:  180  
##  Mean   :15.5   WALKING           :1980   fBodyAcc-std()-X :  180  
##  3rd Qu.:23.0   WALKING_DOWNSTAIRS:1980   fBodyAcc-std()-Y :  180  
##  Max.   :30.0   WALKING_UPSTAIRS  :1980   fBodyAcc-std()-Z :  180  
##                                           (Other)          :10800  
##    MeanValue       
##  Min.   :-0.99767  
##  1st Qu.:-0.96205  
##  Median :-0.46989  
##  Mean   :-0.48436  
##  3rd Qu.:-0.07836  
##  Max.   : 0.97451  
## 
```

Export Data
-----------
Data is exported to text file ""HumanActivityRecognitionUsingSmartphonesTidyDataset.txt" located in the current working directory of the script.



```r
exportFname <- "HumanActivityRecognitionUsingSmartphonesTidyDataset.txt"
f <- file.path(dataFilePath, exportFname)
write.table(tidyData, f, quote=FALSE, row.names=FALSE)
```
