#set working directory to location where data files were downloaded


#1.  Merge the training and the test sets to create one data set.
#read data into R
X_test<-read.table("./test/X_test.txt")
Y_test<-read.table("./test/Y_test.txt")
sub_test<-read.table("./test/subject_test.txt")
X_train<-read.table("./train/X_train.txt")
Y_train<-read.table("./train/Y_train.txt")
sub_train<-read.table("./train/subject_train.txt")
#cbind subject and activity(Y) with test data(X)
test<-cbind(Y_test, X_test)
test<-cbind(sub_test, test)
#cbind subject and activity(Y) with train data(X)
train<-cbind(Y_train, X_train)
train<-cbind(sub_train, train)
#rbind to merge training data set to test data set
mergeddata<-rbind(test, train)

#2.  Extract only the measurements on the mean and standard deviation for each measurement.
#read features data into R
features<-read.table("features.txt")
#filter feature data to include only avg and std
#library(sqldf)
f_features <- sqldf("select * from features where (V2 like '%mean%' or V2 like '%std%') and V2 not like 'angle%' and V2 not like '%meanFreq%'")
#transpose features from column to row
t_features<-data.frame(t(f_features), stringsAsFactors = FALSE)
#create integer vector of feature row to use as index to extract required columns
f_columns<-as.integer(as.vector(t_features[1,]))
#add +2 to each element of vector to account for subject and activity columns
f_columns<-f_columns+2
#extract required columns
ex_data<-mergeddata[,c(1,2,f_columns)]

#3.  Use descriptive activity names to name the activities in the data set.
#read activity labels into R
activity_labels<-read.table("activity_labels.txt")
colnames(activity_labels)<-c("V1.1","Activity")
#replace activity IDs with activity labels in data set
#ex_data_archive<-ex_data #archive for comparision/testing purposes
merged_ex_data <- merge(ex_data, activity_labels,by="V1.1")
#reorder columns to prep data for adding variable names
f_data<-merged_ex_data[c(2,1,69,3:68)]

#4.  Appropriately label the data set with descriptive variable names.
labels<-as.character(as.vector(t_features[2,]))
colnames(f_data)<-c("Subject","Activity_Code", "Activity", labels)

#5.  From the dataset in step 4, create a second, independent tidy data set with the average of each
#    variable for each activity and each subject.
#    This will be the data set uploaded for the assignment.
attach(f_data)
agg_data<-aggregate(f_data, by=list(Group.Subject=Subject, Group.Activity=Activity), FUN=mean, na.rm=TRUE)
detach(f_data)
tidy_data<-agg_data[c(1,2,6:71)]
write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)

#Submitted on GitHub: 1. run_analysis.r script (this file); 2. ReadMe markdown doc; 3. Codebook markdown doc
#Submitted on Coursera: tidy data text file (from step 5 above)



