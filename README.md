All the transformations on the data are carried out in the script "run_analysis.R"

The following transformations are applied to the data:
1.After loading X_trans.txt and X_test.txt, names of the columns are brought in from the file features.txt
2.These files are then combined with their respective Subject and y(activity information) files
3.The resulting dataset are then merged together to form a master dataset
4.Activity names are merged into the master dataset from activity labes file (activity_labels.txt) based on activity number
5.Only the columns with their names containing the words "mean()" or "std()" along with Subject, activity information are kept in the tidy dataset
6.Names of the tidy dataset are changed to more meaningful ones, description for these can be found in "CodeBook.md"
7.An independent dataset is formed by calculating the mean of each of the varaibles for each subject and activity in tidy dataset
8.The names of the variables are chosen in a manner of being descriptive without being too long
