Getting and Cleaning Data Course Project - CodeBook
===================================================
This CodeBook describes the variables, the data, and any transformations or work that was performed to clean up the original UCI HAR Dataset

Original UCI HAR Dataset Overview
---------------------------------

### Human Activity Recognition Using Smartphones Dataset

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

Notes: 
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

### Feature Selection

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ<br />
tGravityAcc-XYZ<br />
tBodyAccJerk-XYZ<br />
tBodyGyro-XYZ<br />
tBodyGyroJerk-XYZ<br />
tBodyAccMag<br />
tGravityAccMag<br />
tBodyAccJerkMag<br />
tBodyGyroMag<br />
tBodyGyroJerkMag<br />
fBodyAcc-XYZ<br />
fBodyAccJerk-XYZ<br />
fBodyGyro-XYZ<br />
fBodyAccMag<br />
fBodyAccJerkMag<br />
fBodyGyroMag<br />
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value<br />
std(): Standard deviation<br />
mad(): Median absolute deviation <br />
max(): Largest value in array<br />
min(): Smallest value in array<br />
sma(): Signal magnitude area<br />
energy(): Energy measure. Sum of the squares divided by the number of values. <br />
iqr(): Interquartile range <br />
entropy(): Signal entropy<br />
arCoeff(): Autorregresion coefficients with Burg order equal to 4<br />
correlation(): correlation coefficient between two signals<br />
maxInds(): index of the frequency component with largest magnitude<br />
meanFreq(): Weighted average of the frequency components to obtain a mean frequency<br />
skewness(): skewness of the frequency domain signal <br />
kurtosis(): kurtosis of the frequency domain signal <br />
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.<br />
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean<br />
tBodyAccMean<br />
tBodyAccJerkMean<br />
tBodyGyroMean<br />
tBodyGyroJerkMean

### Source and further information

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Transformations and work performed to clean up the original UCI HAR Dataset into a new tidy dataset
---------------------------------------------------------------------------------------------------

The script called run_analysis.R was used to do the following transformations:

1. Merge the training and the test sets from the UCI HAR Dataset to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names. 
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

The run_analysis.R script assumes that the original UCI HAR Dataset is already extracted to your working directory and works like this:

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

Resulting set of variables for the new tidy dataset
---------------------------------------------------

### Features

subject<br />
activity<br />
tbodyacc-mean-x<br />
tbodyacc-mean-y<br />
tbodyacc-mean-z<br />
tbodyacc-std-x<br />
tbodyacc-std-y<br />
tbodyacc-std-z<br />
tgravityacc-mean-x<br />
tgravityacc-mean-y<br />
tgravityacc-mean-z<br />
tgravityacc-std-x<br />
tgravityacc-std-y<br />
tgravityacc-std-z<br />
tbodyaccjerk-mean-x<br />
tbodyaccjerk-mean-y<br />
tbodyaccjerk-mean-z<br />
tbodyaccjerk-std-x<br />
tbodyaccjerk-std-y<br />
tbodyaccjerk-std-z<br />
tbodygyro-mean-x<br />
tbodygyro-mean-y<br />
tbodygyro-mean-z<br />
tbodygyro-std-x<br />
tbodygyro-std-y<br />
tbodygyro-std-z<br />
tbodygyrojerk-mean-x<br />
tbodygyrojerk-mean-y<br />
tbodygyrojerk-mean-z<br />
tbodygyrojerk-std-x<br />
tbodygyrojerk-std-y<br />
tbodygyrojerk-std-z<br />
tbodyaccmag-mean<br />
tbodyaccmag-std<br />
tgravityaccmag-mean<br />
tgravityaccmag-std<br />
tbodyaccjerkmag-mean<br />
tbodyaccjerkmag-std<br />
tbodygyromag-mean<br />
tbodygyromag-std<br />
tbodygyrojerkmag-mean<br />
tbodygyrojerkmag-std<br />
fbodyacc-mean-x<br />
fbodyacc-mean-y<br />
fbodyacc-mean-z<br />
fbodyacc-std-x<br />
fbodyacc-std-y<br />
fbodyacc-std-z<br />
fbodyaccjerk-mean-x<br />
fbodyaccjerk-mean-y<br />
fbodyaccjerk-mean-z<br />
fbodyaccjerk-std-x<br />
fbodyaccjerk-std-y<br />
fbodyaccjerk-std-z<br />
fbodygyro-mean-x<br />
fbodygyro-mean-y<br />
fbodygyro-mean-z<br />
fbodygyro-std-x<br />
fbodygyro-std-y<br />
fbodygyro-std-z<br />
fbodyaccmag-mean<br />
fbodyaccmag-std<br />
fbodybodyaccjerkmag-mean<br />
fbodybodyaccjerkmag-std<br />
fbodybodygyromag-mean<br />
fbodybodygyromag-std<br />
fbodybodygyrojerkmag-mean<br />
fbodybodygyrojerkmag-std

### Activities

WALKING<br />
WALKING_UPSTAIRS<br />
WALKING_DOWNSTAIRS<br />
SITTING<br />
STANDING<br />
LAYING
