
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
names(tidy_dataset) <- c("subject", "activityname", "mean-tbodyacc-x","mean-tbodyacc-y","mean-tbodyacc-z", 
                      "stddev-tbodyacc-x", "stddev-tbodyacc-y", "stddev-tbodyacc-z", "mean-tgravityacc-x",
                      "mean-tgravityacc-y","mean-tgravityacc-z", "stddev-tgravityacc-x", "stddev-tgravityacc-y", 
                      "stddev-tgravityacc-z", "mean-tbodyaccjerk-x","mean-tbodyaccjerk-y","mean-tbodyaccjerk-z",
                      "stddev-tbodyaccjerk-x", "stddev-tbodyaccjerk-y","stddev-tbodyaccjerk-z", "mean-tbodygyro-x", 
                      "mean-tbodygyro-y", "mean-tbodygyro-z", "stddev-tbodygyro-x", "stddev-tbodygyro-y", "stddev-tbodygyro-z", 
                      "mean-tbodygyrojerk-x", "mean-tbodygyrojerk-y", "mean-tbodygyrojerk-z", "stddev-tbodygyrojerk-x", 
                      "stddev-tbodygyrojerk-y", "stddev-tbodygyrojerk-z", "mean-tbodyaccmag", "stddev-tbodyaccmag", "mean-tgravityaccmag", 
                      "stddev-tgravityaccmag", "mean-tbodyaccjerkmag", "stddev-tbodyaccjerkmag", "mean-tbodygyromag", "stddev-tbodygyromag",
                      "mean-tbodygyrojerkmag", "stddev-tbodygyrojerkmag", "mean-fbodyacc-x", "mean-fbodyacc-y", "mean-fbodyacc-z", "stddev-fbodyacc-x", 
                      "stddev-fbodyacc-y", "stddev-fbodyacc-z", "mean-fbodyaccjerk-x","mean-fbodyaccjerk-y", "mean-fbodyaccjerk-z", "stddev-fbodyaccjerk-x", 
                      "stddev-fbodyaccjerk-y", "stddev-fbodyaccjerk-z", "mean-fbodygyro-x", "mean-fbodygyro-y", "mean-fbodygyro-z", "stddev-fbodygyro-x", 
                      "stddev-fbodygyro-y", "stddev-fbodygyro-z", "mean-fbodyaccmag", "stddev-fbodyaccmag", "mean-fbodyaccjerkmag", "stddev-fbodyaccjerkmag", 
                      "mean-fbodygyromag", "stddev-fbodygyromag", "mean-fbodygyrojerkmag", "stddev-fbodygyrojerkmag" )

##Calulating avergae of each variable for each subject and activity to creade 
independent_tidy_set <- tidy_dataset %>% group_by(subject, activityname) %>% summarise_all(mean)

write.table(independent_tidy_set,file="independent_tidy_set.txt",row.name=FALSE,col.names = TRUE,quote=FALSE)
