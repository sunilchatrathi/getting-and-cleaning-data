
library(dplyr)

##Feature names
features <- read.table("features.txt",header = FALSE, col.names=c("columnnumber","featurename"))

##Activity labels to activity description mapping
activity_labels <- read.table("activity_labels.txt",header = FALSE, col.names=c("activitynumber","activityname")) 

##Training Data
train_features <- read.table('train/X_train.txt', header = FALSE)
train_subjects <- read.table('train/subject_train.txt', header = FALSE, col.names=c("subject"))
train_labels <- read.table('train/y_train.txt', header = FALSE, col.names=c("activitynumber"))

##Assigning column names
names(train_features) <- features$featurename

##Merging subjects,activity labels with features
train_data <- cbind(train_subjects,train_labels,train_features)

##Test data
test_features <- read.table('test/X_test.txt', header = FALSE)
test_subjects <- read.table('test/subject_test.txt', header = FALSE, col.names=c("subject"))
test_labels <- read.table('test/y_test.txt', header = FALSE, col.names=c("activitynumber"))

##Assigning column names
names(test_features) <- features$featurename

##Merging subjects,activity labels with features
test_data <- cbind(test_subjects,test_labels,test_features)

##Appending Train and Test data
merged_data <- rbind(train_data,test_data)

##Merging in activity name based on activity number
merged_data <- merge(activity_labels,merged_data,by.x="activitynumber",by.y="activitynumber")

#Keeping only the measurements on the mean and standard deviation for each measurement
cols_to_keep <- c(c("subject", "activityname"),grep("mean\\()|std\\()",names(merged_data),value=TRUE))

tidy_dataset <- merged_data[,cols_to_keep]

##Changing names to be more descriptive
names(tidy_dataset)<-gsub("^f", "Frequency", names(tidy_dataset))
names(tidy_dataset)<-gsub("^t", "Time", names(tidy_dataset))
names(tidy_dataset)<-gsub("Acc", "Accelerometer", names(tidy_dataset))
names(tidy_dataset)<-gsub("BodyBody", "Body", names(tidy_dataset))
names(tidy_dataset)<-gsub("Gyro", "Gyroscope", names(tidy_dataset))
names(tidy_dataset)<-gsub("Mag", "Magnitude", names(tidy_dataset))
names(tidy_dataset)<-gsub("-mean\\()", "Mean", names(tidy_dataset), ignore.case = TRUE)
names(tidy_dataset)<-gsub("-std\\()", "STD", names(tidy_dataset), ignore.case = TRUE)
names(tidy_dataset)<-gsub("-freq", "Frequency", names(tidy_dataset), ignore.case = TRUE)


##Calulating avergae of each measurement variable for each subject and activity to creade 
independent_tidy_set <- tidy_dataset %>% group_by(subject, activityname) %>% summarise_all(mean)

##Outputting final data set to a text file
write.table(independent_tidy_set,file="independent_tidy_set.txt",row.name=FALSE,col.names = TRUE,quote=FALSE)
