# this r file should combine 2 data (train and set), filter and remove some columns
# and then create and save a new data


#######################
### 0. Reading section
#######################

# the train and test datas have 561 columns.
# these 561 columns should have a descriptive variable name

# read the 561 names of the variables from features.txt (561 rows, 2 columns)
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("id", "label") )

# convert from factor to character
features <- c(as.character(features[,2]) )

# read x_test data (25 Mb, 2947 lines, 561 columns) 
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features)

# replacing columns names to avoid "..."
names(x_test) <- features

# read x_train data (64 Mb, 7352 lines, 561 columns)
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features)

# replacing columns names to avoid "..."
names(x_train) <- features

# get labels names from file (1 = walking, 2 = walking_upstairs, etc)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("id","activity") )

# read y_test data (information about activity) 2947 lines
y_test <- read.table('UCI HAR Dataset/test/y_test.txt', col.names="activity_id")

# read y_train data (information about activity) 7352 lines
y_train <- read.table('UCI HAR Dataset/train/y_train.txt', col.names="activity_id")

# read subject_test data (information about subject) 2947 lines
subject_test <- read.table('UCI HAR Dataset/test/subject_test.txt', col.names="subject_id")

# read subject_train data (information about subject) 7352 lines
subject_train <- read.table('UCI HAR Dataset/train/subject_train.txt', col.names="subject_id")




########################################################################
### 1. Merges the training and the test sets to create one data set.
########################################################################


# binding the test data (2947 lines): adding columns -> cbind
# activity_id + subject_id + 561 columns = 563 columns
test <- cbind(y_test, subject_test, x_test)

# binding the train data (7352 lines): adding columns -> cbind
# activity_id + subject_id + 561 columns = 563 columns
train <- cbind(y_train, subject_train, x_train)

# binding the test and train data (563 columns): adding lines -> rbind
# 2947 + 7352 = 10299 lines
fulldata <- rbind(test, train)

################################################################################################
### 2. Extracts only the measurements on the mean and standard deviation for eachmeasurement.
################################################################################################

# create a list of column names
current_column_names = names(fulldata)

# get the ids that have "mean()" or "std()": 66 ids
filter <- grep("mean\\(\\)|std\\(\\)", current_column_names)

# extract the data: activity_id, subject_id, 66 columsn (mean/std): 10299 lines, 68 columns
extracted_data <- fulldata[c(1,2,filter) ]

###############################################################################
### 3. Uses descriptive activity names to name the activities in the data set
###############################################################################

# instead of activity ids, use the label
localTmp <- extracted_data$activity_id
# replace the ids for labels
localTmp <- gsub(activity_labels[1,1], activity_labels[1,2], localTmp)
localTmp <- gsub(activity_labels[2,1], activity_labels[2,2], localTmp)
localTmp <- gsub(activity_labels[3,1], activity_labels[3,2], localTmp)
localTmp <- gsub(activity_labels[4,1], activity_labels[4,2], localTmp)
localTmp <- gsub(activity_labels[5,1], activity_labels[5,2], localTmp)
localTmp <- gsub(activity_labels[6,1], activity_labels[6,2], localTmp)
# put back in the column
extracted_data$activity_id <- as.factor(localTmp)

#rename column
names(extracted_data)[1] <- "activity"

###############################################################################
### 4. Appropriately labels the data set with descriptive variable names.
###############################################################################

# in the "0. reading section", the columns names were already replaced by descriptive variable names
# from features

#################################################################################################
### 5. From the data set in step 4, creates a second, independent tidy data set with the average
### of each variable for each activity and each subject.
#################################################################################################

# need library reshape2 from week3 lecture
library(reshape2)

# main columns: activity and subject_id
# third column = name of variable being measured (for example tBodyAcc.mean...x)
# fourth column = value
# qty of lines: 10299 lines from extracted_data * 66 columns (or variables) = 679734 values (lines)
second <- melt(extracted_data, id=c("activity", "subject_id") ) 

# quantity of lines: 30 subjects * 6 activity = 180 values (lines)
# columns: subject_id; activity; 66 variables = 68 columns
result <- dcast(second, formula = activity + subject_id ~ variable, fun = mean)

# when writing the file, disabled the index for each line
write.table(result, "result.txt", row.names = FALSE)
