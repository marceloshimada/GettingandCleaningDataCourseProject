## Introduction

The script "run_analysis.R" should read data (already downloaded and unzipped) and follow the requirements described below. 

## Required library

"Reshape2" is needed.

## Needed data

The data used by the script comes from "Human Activity Recognition Using Smartphones Data Set":

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data is available for download here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip   

## Instructions

Download the data zip file. Unzip it in the working directory. (in R, you can check the working directory using: getwd() ).

After unzipping the data files, the expected directory structure should be:

UCI HAR Dataset

UCI HAR Dataset/test

UCI HAR Dataset/train

"Inertial Signals" directories will not be used by the script.

Put the "run_analysis.R" script in the working directory.

In the command line of R, write: source("run_analysis.R")

A new file "result.txt" should be available in the working directory.

## Expected results

The script should create data sets that follow the requirement below:

1. Merges the training and the test sets to create one data set.

To check the merged data set: View(fulldata)

2. Extracts only the measurements on the mean and standard deviation for each measurement.

To check the extracted data set: View(extracted_data)

3. Uses descriptive activity names to name the activities in the data set

The extracted_data set should display, in the column activity (first one), "WALKING" "WALKING_UPSTAIRS" "WALKING_DOWNSTAIRS" "SITTING" "STANDING" "LAYING" instead of numbers.

4. Appropriately labels the data set with descriptive variable names.

The extracted data set should display the columns names like "tBodyAcc-mean()-X", "tBodyAcc-std()-X", etc.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

To check the resulted data set: View(result)
