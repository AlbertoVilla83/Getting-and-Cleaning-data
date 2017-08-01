# clear all variable in the workspace
rm(list = ls())
library(dplyr)

#--------------------------------------------------
# Download and unzip the file
#--------------------------------------------------
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,
              destfile='samsung_acc.zip',
              method="auto", # for OSX / Linux 
              mode="wb") # "wb" means "write binary," and is used for binary files
unzip(zipfile = "samsung_acc.zip") # unpack the files into subdirectories 


#--------------------------------------------------
#  TASK 1: Create a unique data set from train and test set
#--------------------------------------------------

# list of files that need to be merged
x_train_folder       <- "UCI HAR Dataset/train/X_train.txt"
y_train_folder       <- "UCI HAR Dataset/train/Y_train.txt"
subject_train_folder <- "UCI HAR Dataset/train/subject_train.txt"

x_test_folder       <- "UCI HAR Dataset/test/X_test.txt"
y_test_folder       <- "UCI HAR Dataset/test/y_test.txt"
subject_test_folder <- "UCI HAR Dataset/test/subject_test.txt"

# reading all files
x_train <- read.table(x_train_folder)
x_test  <- read.table(x_test_folder)

y_train <- read.table(y_train_folder)
y_test  <- read.table(y_test_folder)

subject_train <- read.table(subject_train_folder)
subject_test  <- read.table(subject_test_folder)

# Merging files
x_merged       <- rbind(x_train,x_test)
y_merged       <- rbind(y_train,y_test)
subject_merged <- rbind(subject_train,subject_test)

#--------------------------------------------------
#  TASK 2: Extracts only the measurements on the mean and standard deviation
#--------------------------------------------------

# Get feature file
feature_file <- "UCI HAR Dataset/features.txt"
features     <- read.table(feature_file)

# As I understood the task #2, there is the need to extract from the merged data
# previously created only the measurements corresponding to a column containing means
# or standard deviation. 

# Extract colums with mean or standard deviation and merge them 
mean_col     <- features[grepl("mean",features[,2]),1]
std_col      <- features[grepl("std",features[,2]),1]
mean_std_col <- c(mean_col,std_col)

x_mean_std_observations <- x_merged[,mean_std_col]

#--------------------------------------------------
#  TASK 3: Uses descriptive activity names to name the activities in the data set
#--------------------------------------------------

# Get the list of activities and give descrive names to the new activities variable
# y_merged_descriptive
activity_file <- "UCI HAR Dataset/activity_labels.txt"
activity_list <- read.table(activity_file)

n_observations <- dim(y_merged)[[1]]
y_merged_descriptive <- rep(0, n_observations)
for (i in 1:n_observations) {
        y_merged_descriptive[i] <- toString(activity_list[y_merged[i,],2])
}

#--------------------------------------------------
#  TASK 4: Appropriately labels the data set with descriptive variable names.
#--------------------------------------------------

features_file <- "UCI HAR Dataset/features.txt"
features_list <- read.table(features_file)
features_list_clean <- features_list[c(mean_col,std_col),2]

features_list_clean <- sub("Freq","Frequency ", features_list_clean)
features_list_clean <- sub("^t","Time ", features_list_clean)
features_list_clean <- sub("^f","Frequency ", features_list_clean)
features_list_clean <- sub("Acc"," Acceleration ", features_list_clean)
features_list_clean <- sub("Body","Body ", features_list_clean)
features_list_clean <- sub("Gyro","Gyroscope ", features_list_clean)
features_list_clean <- sub("Mag","Magnitude ", features_list_clean)
features_list_clean <- sub("\\()","", features_list_clean)
features_list_clean <- sub("std"," standard deviation ", features_list_clean)
features_list_clean <- sub("mean"," mean ", features_list_clean)

colnames(x_mean_std_observations) <- features_list_clean


#--------------------------------------------------
#  TASK 5: From the data set in step 4, creates a second, 
#  independent tidy data set with the average of each variable for 
#  each activity and each subject
#--------------------------------------------------

# Given the possible ambiguity of the assignment, my decision was to 
# have, for each subject, a mean value for all the different tasks.
# This leads to 180 means per variable (30 subjects x 6 tasks)  

tidy_data <- cbind(subject_merged,y_merged_descriptive,x_mean_std_observations)
colnames(tidy_data)[1] <- "Subject"
colnames(tidy_data)[2] <- "Task"

means_tidy_data <- tidy_data %>% group_by(Task,Subject) %>%
  summarize_all(mean, na.rm = TRUE)
  
write.table(means_tidy_data, file = "tidy_data_set.txt", row.name=FALSE)