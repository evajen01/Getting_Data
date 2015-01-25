#set working directory to location where data files were downloaded

Read each of three files from test and train sub-directories:
Y_test.txt
X_test.txt
subject_test.txt
Y_train.txt
X_train.txt
subject_train.txt

Use cbind() to combine the subject, X & Y files for both the test and train data
Use rbind() to merge the test and train data into data frame 'mergeddata'
mergeddata has 10299 observations of 563 variables; 561(X)+1(Y)+1(subject)
#At this point, step 1 of the assignment is complete

Read the features.txt file into data frame f_features

Use the sqldf package to run a select statement against the features data frame that filters the features to rows where the feature name includes the verbiage 'mean' or 'std'.  Furthermore, exclude rows where the feature name begins with 'angle' or includes 'meanFreq' (I decided to exclude these measures because they seemed inconsistent with the other 'mean' and 'std' measures)

transpose data frame f_features into data frame t_features

create an integer vector, f_columns, out of the first row of t_features, to use as an index of columns to extract from data set 'mergeddata'

add +2 to each element of vector to account for subject and activity columns

extract required columns from data frame 'mergeddata' into data frame 'ex_data'
ex_data has 10299 observations of 68 variables
#At this point, step 2 of the assignment is complete

Read the activity_lables.txt file into data frame activity_labels

Create column names on activity_labels data frame to facilitate merge operation

Use merge() to add activity labels to a new data fram 'merged_ex_data'
merged_ex_data has 10299 observations of 69 variables

Create a new data frame, f_data, that re-orders the columns from merged_ex_data into an order that preps for the adding of variable names
f_data has 10299 observations of 69 variables
#At this point, step 3 of the assignment is complete

Using the data frame t_features, create a character vector, labels, which hold the descriptive field names to be used as labels on f_data.
Assign the column names, including Subject, Activity and Activity_Code, to f_data.
#At this point, step 4 of the assignment is complete

Use the aggregate() function to group f_data by Subject and Activity, and return the mean for each of the measure columns.
Note that R produces a warning because the Activity variable cannot be averaged, so it returns NAs.  
Drop the redundant columns 3-5 from agg_data to create data set tidy_data

Use write.table to create text file tidy_data.txt.  This file is uploaded to through the assignment interfact on Coursera.
#At this point, step 5 of the assignment is complete

#Please refer to CodeBook for descriptions of all variables

