This code book is for my tidydata.txt. 

The variables in this data set are subjects (1 to 30) and activities (1 to 6). 

In my work, I only used the data for the means and standard deviation. In order to do this I used the grep command, 
and did not use the other columns that did not include mean or standard dev. The remaining columns are listed below. 


These signals were used to estimate variables of the feature vector for each pattern:
‘-XYZ’ is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The average of both the means and standard deviations for multiple trials for each of these trials where reported in each row for all combinations of subject and activity type.
