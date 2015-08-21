##############################################################################
##  Robert Palumbo
##  Coursera - Data Scientist Track
##  Getting and Cleaning Data (getdata-031) 
## 
##  Script: run_analysis.r
##    Execute within RStudio.  Requires internet access to download dataset
##
##  August 20, 2015
##
##  Project Requirements:
##
##    The purpose of this project is to demonstrate your ability to collect, 
##    work with, and clean a data set. The goal is to prepare tidy data that can 
##    be used for later analysis. You will be graded by your peers on a series 
##    of yes/no questions related to the project. 
##
##    You will be required to submit:
##      1) a tidy data set as described below,
##      2) a link to a Github repository with your script for performing the
##         analysis
##      3) a code book that describes the variables, the data, and any 
##         transformations or work that you performed to clean up the data 
##         called CodeBook.md. You should also include a README.md in the repo
##         with your scripts. This repo explains how all of the scripts work and
##         how they are connected.  
##
##    One of the most exciting areas in all of data science right now is 
##    wearable computing - see for example this article . Companies like Fitbit,
##    Nike, and Jawbone Up are racing to develop the most advanced algorithms to
##    attract new users. The data linked to from the course website represent 
##    data collected from the accelerometers from the Samsung Galaxy S 
##    smartphone. A full description is available at the site where the data 
##    was obtained: 
##  
##    http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
##
##    Here are the data for the project: 
##
##    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
##
##    You should create one R script called run_analysis.R that does the 
##    following. 
##      1. Merges the training and the test sets to create one data set.
##      2. Extracts only the measurements on the mean and standard deviation 
##         for each measurement. 
##      3. Uses descriptive activity names to name activities in the data set
##      4. Appropriately labels the data set with descriptive variable names. 
##      5. From the data set in step 4, creates a second, independent tidy data
##         set with the average of each variable for each activity and subject.
## 
##   NOTES:
##      1. You MUST load the following library packages BEFORE running
##         this script
##            data.table  dplyr reshape2
##      2. Final tidy data ouput is written to the following file
##         in the current working directory:
##
##            "HumanActivityRecognitionUsingSmartphonesTidyDataset.txt"
##
##   Project Execution Steps
##
##      1. Download the R script 'run_analysis.R'.
##      2. Start the RStudio IDE.
##      3. Load the dplyr, data.table, reshape2 packages (install if needed).
##      4. Ensure you have an internet connection as the script will 
##         automatically download the initial dataset.
##      5. Source the script into R studio and run as required.
##      6. On first run, if the dataset does not exist in the current working
##         directory it will be automatically downloaded. Subsequent runs will
##         use the existing dataset. If you delete it, a new download will take 
##         place.
##      7. The script will clean the data according to the project requirements.
##      8. Ouput messages are displayed on the console to provide insight into
##         the cleaning process.
##      9. Script has completed when you see the message 'DONE PROCESSING'
##         displayed on the console.
##
##    Script Output
##
##      The final 'tidy' dataset will be written to the current working directory. The name of the output file is:
##
##          "HumanActivityRecognitionUsingSmartphonesTidyDataset.txt"
##
##      This is just a simple text file written with 'write.table()' as required.
##
##############################################################################

## Sets up the environment
setupEnv <- function() {
  message("Setting up environment")
  
  packages <- c("data.table", "dplyr", "knitr", "reshape2")
  sapply(packages, require, character.only=TRUE, 
         warn.conflicts = TRUE, quietly=TRUE)

  localDataPath = getwd()
  dataFilename <<- "Dataset.zip"
  dataFilePath <<- localDataPath
  dataFile <<- file.path(dataFilePath, dataFilename)
  print(dataFile)
  dataUrl <<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
}

# Function to download and extract the dataset
downloadDataSet <- function(dsUrl, dsPath) {
  ##  The dataset is to be downloaded and placed in the current working 
  ##  directory.  As it is in the form of a 'zip' archive it will be unzipped
  ##  and accessed in place.
  message("Checking dataset status: ", dsPath)
  
  ##  Only download the dataset if it hasn't already been done
  if (!file.exists(dsPath)) {
    #print(dataSet)
    message("Downloading dataset from url", dsUrl)
    
    download.file(dsUrl, dsPath)
    
    ## If the download was successful unzip the archive else stop
    if (file.exists(dsPath)) {
      message("Unzipping ", dsPath)   
      unzip(dsPath, overwrite = TRUE)
    } else {
      stop("failed to unzip dataset archive!")
    }
  } else {
    message("Local dataset already exists")
  }
}

# Function that reads in the data
importDataSet <- function(dsPath, dFname, colName) {
  read.table(file.path(dsPath, dFname), col.names = colName)
}
  
############################################################
#            Start actual processing here                  #
############################################################

setupEnv()
downloadDataSet(dataUrl, dataFile)

## Import the required datasets
message("Importing datasets")

if (!exists("subjectTrain")) {
  subjectTrain <- importDataSet("UCI HAR Dataset/train", "subject_train.txt")
}
if (!exists("subjectTrainAcivity")) {
  subjectTrainAcivity <- importDataSet("UCI HAR Dataset/train", "y_train.txt")
}
if (!exists("subjectTestData")) {
  subjectTrainData <- importDataSet("UCI HAR Dataset/train", "X_train.txt")
}
if (!exists("subjectTest")) {
  subjectTest <- importDataSet("UCI HAR Dataset/test", "subject_test.txt")
}
if (!exists("subjectTestAcivity")) {
  subjectTestActivity <- importDataSet("UCI HAR Dataset/test", "y_test.txt")
}
if (!exists("subjectTestData")) {
  subjectTestData <- importDataSet("UCI HAR Dataset/test", "X_test.txt")
}
if (!exists("featureType")) {
  featureType <- importDataSet("UCI HAR Dataset", "features.txt")
  setnames(featureType, names(featureType), c("FeatureNum", "FeatureName"))
}
if (!exists("activityName")) {
  activityNames <- importDataSet("UCI HAR Dataset", "activity_labels.txt")
  setnames(activityNames, names(activityNames), c("ActivityID", "ActivityName"))
}


###
# Merge each data sets into one data frame for each of the above
###
message("Merge common data")

# Combine the subjects
if (!exists("subjectMerged")) {
  subjectMerged <- rbind(subjectTrain, subjectTest)
  colnames(subjectMerged) <- c("Subject")
}

# Combine the activities
if (!exists("subjectActivityMerged")) {
  subjectActivityMerged <- rbind(subjectTrainAcivity, subjectTestActivity)
  colnames(subjectActivityMerged) <- c("ActivityID")
}

# Combine the datasets
if (!exists("subjectDataMerged")) {
  subjectDataMerged <- rbind(subjectTrainData, subjectTestData)
}

###
# From here create a data frame that consisting of:
#   Subject   Actvity   Data
###
if (!exists("subjectData")) {
  subjectData <- cbind(subjectMerged, subjectActivityMerged) %>% 
      cbind(subjectDataMerged)
}

# create a key to to the new data to allow quick lookup access
# but convert the data to a data.table first
dt <- data.table(subjectData, key = c("Subject", "ActivityID"))

###
# create a list of all mean/std-deviation observation types 
###
 message("Subset mean() & std() features")
 
 ms <- data.table(filter(featureType, 
                         grepl("mean\\(\\)|std\\(\\)", FeatureName)) %>%
                  mutate(FeatureID = paste0("V", FeatureNum)))
 dt <- dt[, c(key(dt), ms$FeatureID), with=FALSE]

###
# Now merge the main dataset with the Activity Names so you can correlate them
# and then reshape the table by grouping together like activities based on 
# subject
###
message("Creating first tidy data set to execute on")
  
dt <- merge(dt, activityNames, by="ActivityID", all.x = TRUE) 
setkey(dt, Subject, ActivityID, ActivityName)
dt <- data.table(melt(dt, key(dt), variable.name="FeatureID"))

# Add in the actual measurement code to know who to compute avgs etc.
dt <- merge(dt, ms[, list(FeatureNum, FeatureName, FeatureID)], 
            by="FeatureID", all.x=TRUE)
###
# At this point we have a table that is in a tidy format that can be used
# to complete the rest of the assignment.  From here we filter out specific
# subject/activity observations, compute the average for each mean/stddev and
# write the output to a tidy datafile.
###
message("Reorder the initial tidy dataset by Subject, Activity, & Feature")

allSubjects <- select(dt, Subject, ActivityName, 
                      FeatureNum, FeatureName, value)  

# Aggregate the data to capture all the final results
message("Create the final tidy dataset result")
  
tidyData <-aggregate(allSubjects$value, by=list(allSubjects$FeatureName, 
                                                allSubjects$ActivityName, 
                                                allSubjects$Subject), 
                                                FUN=mean, na.rm=TRUE)
# Final tidying up
colnames(tidyData) <- c("MeasurementID", "ActivityID",
                        "SubjectID", "MeanValue")
tidyData <- select(tidyData, SubjectID, ActivityID, MeasurementID, MeanValue)

# Auto-generate the codebook and html markdown for convenience
message("Generating project codebook")

knit("createProjectCodebook.Rmd", output="ProjectCodebook.md", 
     encoding="ISO8859-1", quiet=TRUE)
markdownToHTML("ProjectCodebook.md", "ProjectCodebook.html")

# Script is complete!
message("Done Processing!!")


  
