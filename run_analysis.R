library("dplyr")
library("reshape2")
# File reader functions
fileReader<-function(fileName,...)
{
  file.path(...,fileName) %>% read.table(header = FALSE)
}
#load feature and activity file
conditionFileLoader <- function(fileName,main_dir,fileType,...)
{
  fileReader(fileName,main_dir,fileType)
}
#give header to training and test datasets 
headerGiver<- function(dataFrame)
{
  colnames <- features_file$V2
  colnames <- gsub("-","_",colnames) #replace hypen with underscore
  colnames<-gsub("\\(\\)", "",colnames) #replace round parenthesis with nothing
  names(dataFrame) <- make.names(names = colnames, unique = TRUE, allow_ = TRUE) #Add column name
  return(dataFrame)
}

## Downloading Datasets, provided the above mention main directory name doesn't exist
dataToDownload<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  
fileNameToGive <- "week_4_assignment.zip"
  
download.file(dataToDownload,destfile=fileNameToGive)
  
## unzipping
unzip(fileNameToGive)

#Assigning main directory name
main_dir<-list.dirs(recursive=FALSE)

#Features file
features_file <- fileReader("features.txt", main_dir)
#Activity file
activity_file <- fileReader("activity_labels.txt", main_dir)



#Loading the training datasets
train_set <- fileReader("X_train.txt",main_dir,"train") %>% headerGiver

train_set_labels <- fileReader("y_train.txt",main_dir,"train")
names(train_set_labels) <- "Activity" 
train_set_labels$Activity <- factor(train_set_labels$Activity, levels = activity_file$V1, labels = activity_file$V2)

train_subjects <- fileReader("subject_train.txt",main_dir,"train") 
names(train_subjects) <- "subjects"


test_set <- fileReader("X_test.txt",main_dir,"test") %>% headerGiver

test_set_labels <- fileReader("y_test.txt",main_dir,"test")
names(test_set_labels)<- "Activity"
test_set_labels$Activity<- factor(test_set_labels$Activity, levels = activity_file$V1, labels = activity_file$V2)

test_subjects <- fileReader("subject_test.txt",main_dir,"test") 
names(test_subjects) <- "subjects"

#Merges the training and the test sets to create one data set.
merged_data <- rbind(
  cbind(train_set, train_set_labels, train_subjects),
  cbind(test_set, test_set_labels, test_subjects)
) %>%
  select(
    matches("mean|std"), 
    one_of("subjects", "Activity")
  )

#creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data <- melt(
  merged_data, 
  id = c("subjects","Activity"), 
  measure.vars = setdiff(colnames(merged_data), c("subjects","Activity"))
) %>%
  dcast(subjects + Activity ~ variable, mean)

write.table(tidy_data, file = "tidy_data.txt", sep = ",", row.names = FALSE)
