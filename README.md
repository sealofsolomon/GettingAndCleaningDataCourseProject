Getting and Cleaning Data Course Project
========================================

Repository for Course Project for Getting and Cleaning Data on Coursera

The script called run_analysis.R does the following:

1. Merges the training and the test sets from the UCI HAR Dataset to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

The run_analysis.R script assumes that the UCI HAR Dataset is already extracted to your working directory and works like this:

* Imports the data.table package

* Determines if UCI HAR Dataset is already in the working directory

* Determines which features are means and standard deviations by first loading in the "features.txt" file and then using the grepl function to pattern match the features containing "mean" or "std" and saving their indexes

* Uses the indexes to normalise the feature names by removing function brackets and converting to lower-case and saving the results to featureNames

* Reads only the relevant variables from test and train datasets by:

  * First creating a numeric vector of null objects the same length as the relevant features and saving the results to columnClasses

  * Then using the defined readDataset function to read in the "test" and "train" datasets in table format, using specified column names and classes as defined in featureNames and columnClasses

* Merges the test and train datasets

* Appropriately labels the merged datasets with descriptive activity labels by replacing the activity ids with the appropriate activity names as defined in the "activity_labels.txt" file

* Computes the average of each variable for each activity and each subject into a new tidy dataset using the lapply and mean functions

* Outputs the new tidy dataset to the working directory in a file called "tidyHARdataset.txt"
