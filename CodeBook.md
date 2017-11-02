## Introduction

This file should give information about the variables used by the script "run_analysis.R".

From the original source of the data used in this project:

"Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

...

Attribute Information:

For each record in the dataset it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment."

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Needed files

  The following files comes with the "getdata%2Fprojectfiles%2FUCI HAR Dataset.zip" and will be used by the script. If you would like to open the files, it is recommended to use software like notepad++.

- 'features.txt': List of all 561 features. It has 2 columns (id and label) and 561 lines.

- 'activity_labels.txt': Links the class labels with their activity name. It has 2 columns (id and label) and 6 lines. 

- 'train/X_train.txt': Training set. It has 561 values/features/columns and 7352 lines.

- 'train/y_train.txt': Training labels. It has just 1 column representing the activity (value between 1 and 6)

- 'test/X_test.txt': Test set. It has 561 values/features/columns and 2947 lines.

- 'test/y_test.txt': Test labels. It has just 1 column representing the activity (value between 1 and 6)

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30 and 7352 lines.

- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30 and 2947 lines. 

** Notes: 

- Features are normalized and bounded within [-1,1].

## Variables

#######################
### 0. Reading section
#######################


- features - from the 561 names of the variables from features.txt (561 rows, 2 columns)

- x_test - from x_test.txt data (25 Mb, 2947 lines, 561 columns) 

- x_train - from x_train.txt data (64 Mb, 7352 lines, 561 columns)

- activity_labels - labels names from file activity_labels.txt (1 = walking, 2 = walking_upstairs, etc)

- y_test - from y_test.txt data (information about activity) 2947 lines

- y_train - from y_train.txt data (information about activity) 7352 lines

- subject_test - from subject_test.txt data (information about subject) 2947 lines

- subject_train - from subject_train.txt data (information about subject) 7352 lines

########################################################################
### 1. Merges the training and the test sets to create one data set.
########################################################################

- test - Bind the test data: y_test + subject_test + x_test (2947 lines); adding columns -> cbind; activity_id + subject_id + 561 columns = 563 columns

- train - Bind the train data: y_train + subject_train + x_train (7352 lines); adding columns -> cbind; activity_id + subject_id + 561 columns = 563 columns

- fulldata -  Bind the test and train data (563 columns); adding lines -> rbind; 2947 + 7352 = 10299 lines

################################################################################################
### 2. Extracts only the measurements on the mean and standard deviation for eachmeasurement.
################################################################################################

- current_column_names  - list of column names from fulldata

- filter - ids that have "mean()" or "std()": 66 ids; from current_column_names

- extracted_data -  filtered data: activity_id, subject_id, 66 columsn (mean/std): 10299 lines, 68 columns

###############################################################################
### 3. Uses descriptive activity names to name the activities in the data set
###############################################################################

- localTmp - temporary variable to help replace from ids to label

###############################################################################
### 4. Appropriately labels the data set with descriptive variable names.
###############################################################################

- no new variable in this section

#################################################################################################
### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#################################################################################################

  
- second - temporary variable to help build a new data set. Main columns: activity and subject_id. Third column = name of variable being measured (for example tBodyAcc-mean()-X). Fourth column = value. Quantity of lines: 10299 lines from extracted_data * 66 columns (or variables) = 679734 values (lines)

- result - objective data set;  quantity of lines: 30 subjects * 6 activity = 180 values (lines). Columns: subject_id; activity; 66 variables = 68 columns


## Result

  The tidy data set "result" should have 68 columns and 180 lines (30 subjects  x 6 activities).

  2 columns to represent:

- activity: possible values: "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING" "STANDING" or "LAYING".
- subject_id: from 1 to 30.

  And 66 columns with the average of each variable for each activity and each subject.

- tBodyAcc-mean()-X
- tBodyAcc-mean()-Y
- tBodyAcc-mean()-Z
- tBodyAcc-std()-X
- tBodyAcc-std()-Y
- tBodyAcc-std()-Z
- tGravityAcc-mean()-X
- tGravityAcc-mean()-Y
- tGravityAcc-mean()-Z
- tGravityAcc-std()-X
- tGravityAcc-std()-Y
- tGravityAcc-std()-Z
- tBodyAccJerk-mean()-X
- tBodyAccJerk-mean()-Y
- tBodyAccJerk-mean()-Z
- tBodyAccJerk-std()-X
- tBodyAccJerk-std()-Y
- tBodyAccJerk-std()-Z
- tBodyGyro-mean()-X
- tBodyGyro-mean()-Y
- tBodyGyro-mean()-Z
- tBodyGyro-std()-X
- tBodyGyro-std()-Y
- tBodyGyro-std()-Z
- tBodyGyroJerk-mean()-X
- tBodyGyroJerk-mean()-Y
- tBodyGyroJerk-mean()-Z
- tBodyGyroJerk-std()-X
- tBodyGyroJerk-std()-Y
- tBodyGyroJerk-std()-Z
- tBodyAccMag-mean()
- tBodyAccMag-std()
- tGravityAccMag-mean()
- tGravityAccMag-std()
- tBodyAccJerkMag-mean()
- tBodyAccJerkMag-std()
- tBodyGyroMag-mean()
- tBodyGyroMag-std()
- tBodyGyroJerkMag-mean()
- tBodyGyroJerkMag-std()
- fBodyAcc-mean()-X
- fBodyAcc-mean()-Y
- fBodyAcc-mean()-Z
- fBodyAcc-std()-X
- fBodyAcc-std()-Y
- fBodyAcc-std()-Z
- fBodyAccJerk-mean()-X
- fBodyAccJerk-mean()-Y
- fBodyAccJerk-mean()-Z
- fBodyAccJerk-std()-X
- fBodyAccJerk-std()-Y
- fBodyAccJerk-std()-Z
- fBodyGyro-mean()-X
- fBodyGyro-mean()-Y
- fBodyGyro-mean()-Z
- fBodyGyro-std()-X
- fBodyGyro-std()-Y
- fBodyGyro-std()-Z
- fBodyAccMag-mean()
- fBodyAccMag-std()
- fBodyBodyAccJerkMag-mean()
- fBodyBodyAccJerkMag-std()
- fBodyBodyGyroMag-mean()
- fBodyBodyGyroMag-std()
- fBodyBodyGyroJerkMag-mean()
- fBodyBodyGyroJerkMag-std()
