# Load Libraries
library(qdap)
library(plyr)

# 1. Merge the training and the test sets to create one data set.

#save the data as tables
X_train <- read.table('./UCI HAR Dataset/train/X_train.txt')
Y_train <- read.table('./UCI HAR Dataset/train/y_train.txt')
subject_train <- read.table('./UCI HAR Dataset/train/subject_train.txt')
X_test <- read.table('./UCI HAR Dataset/test/X_test.txt')
Y_test <- read.table('./UCI HAR Dataset/test/y_test.txt')
subject_test <- read.table('./UCI HAR Dataset/test/subject_test.txt')

#merge the training and test sets
X_train_test <- rbind(X_train, X_test) #features
Y_train_test <- rbind(Y_train, Y_test) #activities
Subject_train_test <- rbind(subject_train, subject_test) #subjects

# merge into one dataset. We will merge again later once we clean each part of
# the dataset.
dataset <- cbind(X_train_test, Y_train_test, Subject_train_test)

# 2. Extract only the measurements on the mean and standard deviation for each 
# measurement.    
    
features <- read.table('./UCI HAR Dataset/features.txt')
features <- features[, 2]
meannames <- grepl('mean\\(\\)', features)
stdnames <- grepl('std\\(\\)', features)
X_train_test <- X_train_test[, (meannames | stdnames)]
colnames(X_train_test) <- features[(meannames | stdnames)]

# 3. Use descriptive activity names to name the activities in the data set 
activities <- read.table('./UCI HAR Dataset/activity_labels.txt')

# Use the lookup function in the qdap library to match the activity number
# to the description
Y_train_test <- apply(Y_train_test, 2, lookup, activities)

# 4. Appropriately label the data set with descriptive variable names.
colnames(X_train_test) <- features[(meannames | stdnames)]
colnames(X_train_test) <- tolower(colnames(X_train_test))

colnames(X_train_test) <- gsub("-", "", colnames(X_train_test))
colnames(X_train_test) <- gsub("\\(", "", colnames(X_train_test))
colnames(X_train_test) <- gsub("\\)", "", colnames(X_train_test))

colnames(X_train_test) <- gsub("std", "standarddeviation", colnames(X_train_test)) 
colnames(X_train_test) <- gsub("tbody", "timebody", colnames(X_train_test))
colnames(X_train_test) <- gsub("tgravity", "timegravity", colnames(X_train_test)) 
colnames(X_train_test) <- gsub("acc", "acceleration", colnames(X_train_test)) 
colnames(X_train_test) <- gsub("fbody", "frequencybody", colnames(X_train_test)) 
colnames(X_train_test) <- gsub("mag", "magnitude", colnames(X_train_test)) 
colnames(Y_train_test) <- 'activity'
colnames(Subject_train_test) <- 'subject'

# bind the columns again to make one dataset
dataset <- cbind(X_train_test, Y_train_test, Subject_train_test)

# 5. From the data set in step 4, create a second, independent tidy data set
# with the average of each variable for each activity and each subject.
tidy <- ddply(dataset, .(activity, subject), function(x) colMeans(x[,3:66]))
    
# Save tidy dataset in tidy.txt
write.table(tidy, file='tidy.txt', row.names = FALSE)