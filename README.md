README

The file run_analysis.R acts on the Human Activity Recognition data set which may be downloaded here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

For this code to function correctly, the R working directory should be the top-level folder extracted from the above zip file: the folder "UCI HAR Dataset".

The HAR dataset consists of a set of feature variables based on gyroscopic and acceleration signals from a smartphone worn by a person. For more information on the context of the data, see CodeBook.md, and also the official documentation here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

This script summarizes the data by providing the average of each feature variable for each of the 30 test subjects, and also for each of the 6 activities.