# [Getting And Cleaning Data @Coursera](https://class.coursera.org/getdata-030)
##Code Book
The purpose of this project is to demonstrate ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

### Dataset Description

The project taps into an exciting area of wearable computing, where a number of big brands compete to develop clever algorithms. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

### Functions created inside the scripts
1. fileReader: This function will reads the .txt files. It takes two arguments the path to main directory of the project and the file name.
2. conditionFileLoader: This function will read the train or test data. It takes the path to main directory of the project, the file name and the string of either "train" or "test".
3. headerGiver: This will add headers from the features into the traning or test matrix

### transformations done
To aviod conflicts with R variable name convention, All hyphens have been converted to underscore and all perenthesis have been removed.
