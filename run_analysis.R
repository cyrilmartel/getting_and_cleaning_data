## As explained in the assignment, it is assumed that the folder "UCI HAR Dataset" containing the Samsung data is in your Working Directory. 


##loading the package dplyr
library(dplyr)

##STEP 1: MERGING TRAIN AND TEST DATASETS
## reading the actvities corresponding to the measurements of x_train, and naming this column "Activity".
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "Activity")

## reading to which subjects correspond the measurements of x_train, and naming this column "Subject".
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")

## reading the features file, which contains the variable names of x_train, and turning these variable names into a vector.
features <- read.table("./UCI HAR Dataset/features.txt")
features_id <- unlist(features[,2])

##reading the x_train data (actual measurements), assigning the variable names from features.txt
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features_id)

##binding x_train, y_train, and subject_train. The measurements are now associated to an activity and a subject, and variables are all named explicitly.
train <- cbind(x_train, y_train, subject_train)


##test data set: same steps as above.
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "Activity")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features_id)
test <- cbind(x_test, y_test, subject_test)


## merge test and train datasets.
data1 <- rbind(test,train)


##STEP 2: extract mean and SD measurements. Using select(), only the column containing "mean" or "std" are selected, as well as Activity and Subject.
data2 <- select(data1, contains("mean"), contains("std"), Activity, Subject)


##STEP 3: assign explicit activity names
##coerce values in the column activity into factors, with levels 1 to 6
data2$Activity <- as.factor(data2$Activity)

##read the text file activity_labels.txt, containing explicit activity names
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

##assign the explicit activity names from activity_labels to the factor levels of Activity column.
levels(data2$Activity)<- activity_labels[,2]

##STEP 4
##STEP 4 was already done at step 1, when explicit variable names from "features.txt" were assigned to x_train and x_test.

##STEP 5: tidy dataset with avg of each variable by activity and subject.
##grouping the data by activity and by subject
data3 <- group_by(data2, Activity, Subject)
##Averaging the data for each variable, for each activity and each subject.
data4 <- summarise_each(data3, funs(mean))

##creating a .txt file containing the final tidy dataset.
write.table(data4, "project.txt", row.name=FALSE)