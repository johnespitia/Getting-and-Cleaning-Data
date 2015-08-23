
## read data into data tables

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <-read.table("./UCI HAR Dataset/test/y_test.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

## Add column name ID
names(subject_train) <- "ID"
names(subject_test) <- "ID"

# add column names for measurement
names(X_train) <- features$V2
names(X_test) <- features$V2

# add column name for label files
names(y_train) <- "activity"
names(y_test) <- "activity"

## 1. Merges the training and the test sets to create one data set

train <- cbind(subject_train, y_train, X_train)
test <- cbind(subject_test, y_test, X_test)
merge_set <- rbind(train, test)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement

measures <- grepl("mean\\(\\)", names(merge_set)) | grepl("std\\(\\)", names(merge_set))
measures[1:2] <- TRUE
merge_set <- merge_set[, measures]

## 3. Uses descriptive activity names to name the activities in the data set

labels_temp <- activity_labels["V2"]
# create a string with activities name
for(i in 1:sum(!is.na(labels_temp))) {
   if (i == 1) {
      activity_name <- toString(labels_temp[i,])
   } else {
        activity_name <- c(activity_name, toString(labels_temp[i,]))
   }
}
# convert the activity column from factor
merge_set$activity <- factor(merge_set$activity, labels=c(activity_name))

# load the reshape2 package
library('reshape2')

## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# create the tidy data set
melted <- melt(merge_set, id=c("ID","activity"))
tidy <- dcast(melted, ID+activity ~ variable, mean)

# write the tidy data set
write.csv(tidy, "tidy.csv", row.names=FALSE)
write.table(tidy, "tidy.txt", row.names=FALSE)




