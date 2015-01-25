

The file run_analysis.R contains a series of commands that can be run in R. 

The script is made to analyse data from the UCI HAR Dataset, which must be saved in your Working Directory.To use the script, you need to enter every single line of commands in the console, either all at once, or one by one. 

UCI HAR Dataset actually contains two datasets: "train" and "test". Both of these contains measurements of 561 variables (x_train and x_test), a vector indicated which subject corresponds to which measurement (subject_train and subject_test), and a vector indicating which activity was performed during each measurement ( y_test and y_train). The script starts by associating each measurement to its associated subject and activity, and merges "test" and "train" into one dataframe.

During that process, the script also takes the names of the measurement variables (called features in this case) from the file "features.txt", and associates each measurement with the correct feature. 

The script then selects only variables referring to the mean and standard deviation of these measurements (86 variables), as well as the associated subject and activity.

Finally, the script returns the mean of each of these 86 variables for each subject and each activity. So we end up with means of means and means of SD for 30 subjects, each performing 6 activities. 

The file Code Book.md contains a brief description of the different variables.