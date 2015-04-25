# Cleaning Data Project

## Introduction
This is a writeup of the Coursera Cleaning Data Project. 

## Initial Data
The initial data was provided as part of the assignment, in the file
```getdata-projectfiles-UCI HAR Dataset.zip```

I used the data in the folder ```UCI HAR Dataset/test``` and ```UCI HAR Dataset/train```. 
I used the following files as inputs.


|Filename|Data Description|
|--------|----------------|
|subject\_test.txt|Subject ID's from the Test data set.|
|y\_test.txt|Activity ID's from the Test data set.|
|X\_test.txt|Measurements from the Test data set.|
|subject_train.txt|Subject ID's from the Train data set.|
|y\_train.txt|Activity ID's from the Train data set.|
|X\_train.txt|Measurements from the Train data set.|

I did NOT find it necessary to use any of the data in the ```Inertial Signals``` folders.

## Assignment
The assignment was to read the measurements in the test and training data sets, combine them, tidy them, and output the mean of the measurements grouped by activity and subject ID.

## Variables applied

The assignment called for selecting out the mean and standard deviation variables from the original data sets. There was some room for interpretation here since there were different kinds of mean variables.

I interpreted the requirement to mean all variables whose names were of the form *-mean() and *-std(). This included 33 mean columns and 33 standard deviation columns.

|Column Number|Original Variable Name|
|-------------|----------------------|
|1|tBodyAcc-mean()-X|
|2|tBodyAcc-mean()-Y|
|3|tBodyAcc-mean()-Z|
|4|tBodyAcc-std()-X|
|5|tBodyAcc-std()-Y|
|6|tBodyAcc-std()-Z|
|41|tGravityAcc-mean()-X|
|42|tGravityAcc-mean()-Y|
|43|tGravityAcc-mean()-Z|
|44|tGravityAcc-std()-X|
|45|tGravityAcc-std()-Y|
|46|tGravityAcc-std()-Z|
|81|tBodyAccJerk-mean()-X|
|82|tBodyAccJerk-mean()-Y|
|83|tBodyAccJerk-mean()-Z|
|84|tBodyAccJerk-std()-X|
|85|tBodyAccJerk-std()-Y|
|86|tBodyAccJerk-std()-Z|
|121|tBodyGyro-mean()-X|
|122|tBodyGyro-mean()-Y|
|123|tBodyGyro-mean()-Z|
|124|tBodyGyro-std()-X|
|125|tBodyGyro-std()-Y|
|126|tBodyGyro-std()-Z|
|161|tBodyGyroJerk-mean()-X|
|162|tBodyGyroJerk-mean()-Y|
|163|tBodyGyroJerk-mean()-Z|
|164|tBodyGyroJerk-std()-X|
|165|tBodyGyroJerk-std()-Y|
|166|tBodyGyroJerk-std()-Z|
|201|tBodyAccMag-mean()|
|202|tBodyAccMag-std()|
|214|tGravityAccMag-mean()|
|215|tGravityAccMag-std()|
|227|tBodyAccJerkMag-mean()|
|228|tBodyAccJerkMag-std()|
|240|tBodyGyroMag-mean()|
|241|tBodyGyroMag-std()|
|253|tBodyGyroJerkMag-mean()|
|254|tBodyGyroJerkMag-std()|
|266|fBodyAcc-mean()-X|
|267|fBodyAcc-mean()-Y|
|268|fBodyAcc-mean()-Z|
|269|fBodyAcc-std()-X|
|270|fBodyAcc-std()-Y|
|271|fBodyAcc-std()-Z|
|345|fBodyAccJerk-mean()-X|
|346|fBodyAccJerk-mean()-Y|
|347|fBodyAccJerk-mean()-Z|
|348|fBodyAccJerk-std()-X|
|349|fBodyAccJerk-std()-Y|
|350|fBodyAccJerk-std()-Z|
|424|fBodyGyro-mean()-X|
|425|fBodyGyro-mean()-Y|
|426|fBodyGyro-mean()-Z|
|427|fBodyGyro-std()-X|
|428|fBodyGyro-std()-Y|
|429|fBodyGyro-std()-Z|
|503|fBodyAccMag-mean()|
|504|fBodyAccMag-std()|
|516|fBodyBodyAccJerkMag-mean()|
|517|fBodyBodyAccJerkMag-std()|
|529|fBodyBodyGyroMag-mean()|
|530|fBodyBodyGyroMag-std()|
|542|fBodyBodyGyroJerkMag-mean()|
|543|fBodyBodyGyroJerkMag-std()|

## Tidy standards applied

I kept the data wide, similar to the way I found it in the original X\_test.txt and X\_train.txt files. I did not see any advantage to narrowing it. The data was already tidy in that each column was a single measurement for a single activity and subject.

I made modest changes to the column names. I believe the original names were fairly readable and that expanding them too much would make them less readable. Starting with the original variable names, I made the following changes to arrive at the Step 5 variable names.

Therefore I:

* Removed hyphens and parentheses.
* Kept camel case (camelCase), since making such long variables all lower case would have made them
less readable, not more readable.
* Expanded "t" to "time".
* Expanded "f" to "freq".
* Prepended "meanOf", since each output variable is the mean of values from the 
input variable.

For example:
* The original variable name ```fBodyGyro-std()-X``` was converted to 
```meanOfFreqBodyGyroStdX``` in the output
* The original variable name ```tGravityAcc-mean()-X``` was converted to 
```meanOfTimeGravityAccMeanX``` in the output.

## Units
The units of the output variables are the same as those of the original variables.

## Script Processing

The script ```run_analysis.R``` performs the transformation between the original data and the output data, using the following steps.

* Prepare Test data
  * Load Test data
  * Attach the subject identifier to the Test data.
  * Translate activity numbers to corresponding codes. See ```activity\_labels.txt``` for the number-to-code mapping.
  * Select out just the -mean() and -std() columns.
  * Apply the correct column headers.
    
* Prepare Train data
  * Load Train data
  * Attach the subject identifier to Train data.
  * Translate activity numbers to corresponding codes  See ```activity\_labels.txt``` for the number-to-code mapping.
  * Select out just the -mean() and -std() columns.
  * Apply the correct column names.
    
* Combine the train and test data into a single data frame
    
* Group the combined data by subject and activity, then take the mean of all the measurements.
    
* Output the summarized data frame.

## Output
The output of the script is called ```step5.txt``` and can be imported into R with the 
following command.

```
read.table("step5.txt", header=TRUE)
```

The variables in the output are the following.

|Variable|Description|
|--------|-----------|
|activity|The activity of the measurements, given as the text code.|
|subject|The Subject ID of the subject of the measurements.|
|meanOf...|Mean of the corresponding original variable, grouped by activity and subject. There are 66 such variables given in the same order as the original variables.|
