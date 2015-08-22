# GettingAndCleaningData

Coursera DataScientist Track
Getting and Cleaning Data (getdata-031)
Course Project - README.md
Author: Robert Palumbo
GitHub: https://github.com/palumbo62/GettingAndCleaningData/


Project Requirements
===========================

> The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.
>
> One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
>
> http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
>
> Here are the data for the project:
>
>https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
>
>You should create one R script called run_analysis.R that does the following.
>
> 1. Merges the training and the test sets to create one data set.
> 2. Extracts only the measurements on the mean and standard deviation for each measurement.
> 3. Uses descriptive activity names to name the activities in the data set.
> 4. Appropriately labels the data set with descriptive activity names.
> 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
>
>Good luck!
>

Project Execution Steps
-----------------------

1. Download the R script 'run_analysis.R'.
2. Start the RStudio IDE.
3. Load the dplyr, data.table, reshape2 packages (install if needed).
4. Ensure you have an internet connection as the script will automatically download the initial dataset.
4. Source the script into R studio and run as required.
5. On first run, if the dataset does not exist in the current working directory it will be automatically downloaded. Subsequent runs will use the existing dataset. If you delete it, a new download will take place.
6. Dataset is automatically extracted from the archive file. The root directory of the data files is 'UCI HAR Dataset' located in the current working directory.
6. The script will clean the data according to the project requirements.
7. Ouput messages are displayed on the console to provide insight into the cleaning process.
8. Script has completed processing when you see the message 'DONE PROCESSING' displayed.

Script Output
-------------

The final 'tidy' dataset will be written to the current working directory.  The name of the output file is:

  "HumanActivityRecognitionUsingSmartphonesTidyDataset.txt"
  
This is just a simple text file written with 'write.table()' as required.
