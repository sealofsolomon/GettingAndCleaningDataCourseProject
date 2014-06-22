## Getting and Cleaning Data - Course Project
##
## An R script that:
##
## 1) Imports the Human Activity Recognition Using Smartphones Dataset.
## 2) Merges the training and the test sets to create one data set.
## 3) Extracts only the measurements on the mean and standard deviation for each
##    measurement.
## 4) Uses descriptive activity names to name the activities in the data set.
## 5) Appropriately labels the data set with descriptive variable names.
## 6) Creates a second, independent tidy data set with the average of each 
##    variable for each activity and each subject.
##
## Script assumes that the UCI HAR Dataset is already extracted to your
## working directory

## Import data.table package
library(data.table)

## readDataset reads in a specified dataset from the UCI HAR Dataset in table 
## format and creates a data frame from it, using specified column names and 
## classes.
## Usage example: data <- readDataset("train", columnNames, columnClasses)

readDataset <- function(dataset, columnNames, columnClasses) {
        # Reads in specified dataset from the UCI HAR Dataset in table format 
        # and creates a data frame frame from it, using specified column names 
        # and classes.
        #
        # Args:
        # dataset: The specified UCI HAR Dataset to read in
        # columnNames: A vector of column names for the variables
        # columnClasses: A vector of classes to be assumed for the columns
        #
        # Returns:
        # A data table of the specified UCI HAR Dataset
        directory <- paste0("./UCI HAR Dataset/", dataset)
        dataTable <- data.table(read.table(paste0(directory, "/X_", dataset, 
                                                  ".txt"), 
                                           colClasses=columnClasses))
        setnames(dataTable, columnNames)
        dataTable[, activity := read.table(paste0(directory, "/y_", dataset,
                                                  ".txt"))]
        dataTable[, subject := read.table(paste0(directory, "/subject_", 
                                                 dataset, ".txt"))]
}

## Determine if UCI HAR Dataset is already in working directory
if (!file.exists("UCI HAR Dataset")) {
        cat("Please download and extract the UCI HAR Dataset 
            to your working directory.")
}

## Determine which features are means and standard deviations
features <- read.table("./UCI HAR Dataset/features.txt")
index <- features[grepl("-(mean|std)\\(\\)", features$V2, features),]$V1

## Normalise names by removing function brackets and converting to lower-case
featureNames <- gsub("[()]", "", tolower(features[index,]$V2))

## Read only relevant variables from test and train datasets
columnClasses <- rep("NULL", length(features$V1))
columnClasses[index] <- "numeric"
testData <- readDataset("test", featureNames, columnClasses)
trainData <- readDataset("train", featureNames, columnClasses)

## Merge test and train datasets
dataTable <- rbindlist(list(testData, trainData))

## Appropriately label the data set with descriptive activity labels
activityName <- read.table("./UCI HAR Dataset/activity_labels.txt")
dataTable[, activity := as.factor(activityName[activity,]$V2) ]

## Compute the average of each variable for each activity and each subject
## into a new tidy dataset
tidyDataset <- dataTable[,lapply(.SD,mean), by=list(subject, activity)]

## Sort the tidy dataset by subject and activity
tidyDataset <- as.data.frame(tidyDataset)
tidyDataset[,1] <- as.numeric(as.character(tidyDataset[,1]))
tidyDataset[,2] <- as.character(tidyDataset[,2])
tidyDataset <- tidyDataset[order(tidyDataset[,1], tidyDataset[,2]), ]

## Output the new tidy dataset to the working directory
write.table(tidyDataset, "tidyHARdataset.txt", row.names=FALSE)
