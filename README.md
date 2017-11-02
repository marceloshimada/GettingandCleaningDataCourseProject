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

## How it works

#######################
### 0. Reading section
#######################


  Read the 561 names of the variables from features (561 rows, 2 columns)
```R
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("id", "label") )
```

  Convert from factor to character
```R
features <- c(as.character(features[,2]) )
```

  Read x_test data (25 Mb, 2947 lines, 561 columns) 
```R
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features)
```
  Replace the columns names to avoid "..." in the names.
```R
names(x_test) <- features
```

  Read x_train data (64 Mb, 7352 lines, 561 columns)
```R
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features)
```

  Replace columns names to avoid "..." in the names.
  
```R
names(x_train) <- features
```

  Get labels names from file (1 = walking, 2 = walking_upstairs, etc)
```R
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("id","activity") )
```
  Read y_test data (information about activity) 2947 lines
```R
y_test <- read.table('UCI HAR Dataset/test/y_test.txt', col.names="activity_id")
```

  Read y_train data (information about activity) 7352 lines
```R
y_train <- read.table('UCI HAR Dataset/train/y_train.txt', col.names="activity_id")
```

  Read subject_test data (information about subject) 2947 lines
```R
subject_test <- read.table('UCI HAR Dataset/test/subject_test.txt', col.names="subject_id")
```

  Read subject_train data (information about subject) 7352 lines
```R
subject_train <- read.table('UCI HAR Dataset/train/subject_train.txt', col.names="subject_id")
```

########################################################################
### 1. Merges the training and the test sets to create one data set.
########################################################################

  Bind the test data (2947 lines): adding columns -> cbind
  activity_id + subject_id + 561 columns = 563 columns
```R
test <- cbind(y_test, subject_test, x_test)
```

  Bind the train data (7352 lines): adding columns -> cbind
  activity_id + subject_id + 561 columns = 563 columns
```R
train <- cbind(y_train, subject_train, x_train)
```

  Bind the test and train data (563 columns): adding lines -> rbind
  2947 + 7352 = 10299 lines
```R
fulldata <- rbind(test, train)
```

################################################################################################
### 2. Extracts only the measurements on the mean and standard deviation for eachmeasurement.
################################################################################################

  Create a list of column names
```R
current_column_names = names(fulldata)
```

  Get the ids that have "mean()" or "std()": 66 ids
```R
filter <- grep("mean\\(\\)|std\\(\\)", current_column_names)
```

  Extract the data: activity_id, subject_id, 66 columsn (mean/std): 10299 lines, 68 columns
```R
extracted_data <- fulldata[c(1,2,filter) ]
```

###############################################################################
### 3. Uses descriptive activity names to name the activities in the data set
###############################################################################

  Instead of activity ids, use the label
```R
localTmp <- extracted_data$activity_id
```

  Replace the ids for labels
```R
localTmp <- gsub(activity_labels[1,1], activity_labels[1,2], localTmp)
localTmp <- gsub(activity_labels[2,1], activity_labels[2,2], localTmp)
localTmp <- gsub(activity_labels[3,1], activity_labels[3,2], localTmp)
localTmp <- gsub(activity_labels[4,1], activity_labels[4,2], localTmp)
localTmp <- gsub(activity_labels[5,1], activity_labels[5,2], localTmp)
localTmp <- gsub(activity_labels[6,1], activity_labels[6,2], localTmp)
```

  Put back in the column
```R
extracted_data$activity_id <- as.factor(localTmp)
```

  Rename column
```R
names(extracted_data)[1] <- "activity"
```

###############################################################################
### 4. Appropriately labels the data set with descriptive variable names.
###############################################################################

  In the "0. reading section", the columns names were already replaced by descriptive variable names from features

#################################################################################################
### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#################################################################################################

  Need library reshape2 from week3 lecture
```R
library(reshape2)
```
  Build a new data set. Main columns: activity and subject_id. Third column = name of variable being measured (for example tBodyAcc-mean()-X). Fourth column = value. Quantity of lines: 10299 lines from extracted_data * 66 columns (or variables) = 679734 values (lines)
```R
second <- melt(extracted_data, id=c("activity", "subject_id") ) 
```

  Quantity of lines: 30 subjects * 6 activity = 180 values (lines). Columns: subject_id; activity; 66 variables = 68 columns
```R
result <- dcast(second, formula = activity + subject_id ~ variable, fun = mean)
```

  When writing the file, disable the index for each line.
```R
write.table(result, "result.txt", row.names = FALSE)
```


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
