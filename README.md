### Collecting and Cleaning Human Activity Recognition (HAR) Using Smartphones

## Introduction
The run_activity.R file uses the data set found in the UCI HAR dataset directory 
to clean it and to create a tidy data set that contains the average of each variable
for each activity and for each subject. 

## Detailed Process
The run_activity.R script does the following:

Step 1: Merge the training and the test sets to create one data set.
The sub-steps for this step are as follows:

- Load the training set of features from the X_train.txt file and save as a list called X_train.
- Load the training set of activities from the y_train.txt file and save as a list called Y_train.
- Load the training set of subjects from the subject_train.txt file and save a list in a called subject_train.
- Load the test set of features from the X_test.txt file and save as a list called X_test.
- Load the test set of activities from the y_test.txt file and save as a list called Y_test.
- Load the test set of subjects from the subject_test.txt file and save a list called subject_test.
- Merge the training and test sets for the X files (features) by binding the X_train and
X_test sets.
- Merge the training and test sets for the Y files (activities) by binding the Y_train and
Y_test sets.
- Merge the training and test sets for the subject files (subjets) by binding the subject_train and subject_test sets.
- Merge the combined X, Y, and subject datasets together by binding the columns together into a list called dataset.

Step 2: Extract only the measurements on the mean and standard deviation for each 
measurement.  

- Load the features.txt file (which describes the list of features in the X file) and 
store in variable called features.
- Extract only the second row of features (the list of variables). The first row can 
be ignored, as it is the index. 
- Extract all the names of variables from the list of features that contain the words 
'mean()' and 'std()' (standard deviation).
- Change the X_train_set variable (which lists all of the features) to only include
the features which contain 'mean()' and 'std()'.
- Change the column names in the X_train_set variable to the list of features which
contain 'mean()' and 'std()' from the features variable.

Step 3: Use descriptive activity names to name the activities in the data set

- Load the activity labels from the activity.txt file and store in a data table called
activities. The first column of 'activities' will be the index number and the second column
describes the type of activity.
- Change the variable in the Y_train_test list from the number to the corresponding variable name based in the 'activities' variable.

Step 4: Appropriately label the data set with descriptive variable names.

- Change the column names of the X_train_test list to the names of the columns in the features variable that contain 'mean()' and 'std()'
- Change the columns names to lowercase.
- Make the column names more readable by changing 'std' to 'standarddeviation', 'tbody' to 'timebody', 'tgravity' to 'timegravity', 'acc' to 'acceleration', 'fbody' to 'frequencybody', and 'mag' to 'magnitude'.
- Change the name of the one column in Y_train_test to 'activity'.
- Change the name of the one column in Subject_train_test to 'subject'.

- Merge the X_train_test, Y_train_test, and subject_train_test lists again into one dataset. 

Step 5: From the data set in step 4, create a second, independent tidy data set
with the average of each variable for each activity and each subject.

- Splt the merged dataset from step 4 into two variables - 'activity' and 'subject' - and apply the mean of each of the X_train_set features to it.
- Store the resulting dataset in a file called tidy.txt. 