All the transformations on the data are carried out in the script "run_analysis.R"

The following transformations are applied to the data:
*After loading X_trans.txt and X_test.txt, names of the columns are brought in from the file features.txt
*These files are then combined with their respective Subject and y(activity information) files
*The resulting dataset are then merged together to form a master dataset
*Activity names are merged into the master dataset from activity labes file (activity_labels.txt) based on activity number
*Only the columns with their names containing the words "mean()" or "std()" along with Subject, activity information are kept in the tidy dataset
*Names of the tidy dataset are changed to more meaningful ones, description for these can be found in "CodeBook.md"
*An independent dataset is formed by calculating the mean of each of the varaibles for each subject and activity in tidy dataset
*The names of the variables are chosen in a manner of being descriptive without being too long
