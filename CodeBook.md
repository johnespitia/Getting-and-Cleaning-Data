## Code Book

This code book will describe the data used in this project and the processing steps


# Files

 1. `subject_train.txt:` Each row identifies the subject who performed the activity for each window sample.
 2. `X_train.txt:` Training set.
 3. `y_train.txt:` Training labels.
 4. `subject_test.txt:` Each row identifies the subject who performed the activity for each window sample.
 5. `X_test.txt:` Test set.
 6. `y_test.txt:` Test labels.
 7. `features.txt:` List of all features.
 8. `activity_labels.txt:` Links the class labels with their activity name.
 
Aditional information is available in `README.txt`

# Processing steps

1. Files were read into data frames
2. Column headers were added
3. Subjet Training and Subject Test sets were merged into a single data set(`merge_set`).
4. Columns were removed that did not contain the exact string "mean()" or "std()"
5. `activity_name` variable was created with activity_labels file.
5. The activity column was converted from a integer to a factor, using `activity_name` variable.
6.  `reshape2` package was loaded
6. Tidy data set was created with the average of each variable for each activity and each subject.
7. `Tidy.txt` file was created with write.table() function. 
