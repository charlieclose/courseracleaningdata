run_analysis <- function(){
    
    ##Load Test Data, subset mean and standard deviation columns, and add colunm headers -> data_test_subset
    subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
    activity_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
    data_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
    
    #Attach the subject identifier to data_test. subject_test is a one-column data frame.
    data_test$subject <- subject_test[,1]

    #Translate activity numbers to corresponding codes and attach to data_test.
    #See activity_labels.txt for the number-to-code mapping.
    activity_test$activity <- sapply(activity_test[,1], FUN=translate_activity)
    data_test$activity <- activity_test$activity
    
    #Select out just the -mean() and -std() columns. The column numbers were
    #determined by inspecting features.txt
    data_test_subset <- select(data_test
                               ,subject
                               ,activity
                               ,V1,V2,V3,V4,V5,V6,V41,V42,V43,V44,V45,V46,V81
                               ,V82,V83,V84,V85,V86,V121,V122,V123,V124,V125
                               ,V126,V161,V162,V163,V164,V165,V166,V201,V202
                               ,V214,V215,V227,V228,V240,V241,V253,V254,V266
                               ,V267,V268,V269,V270,V271,V345,V346,V347,V348
                               ,V349,V350,V424,V425,V426,V427,V428,V429,V503
                               ,V504,V516,V517,V529,V530,V542,V543)
    
    # Apply the correct column headers.
    column_names <- c("subject" 
                      ,"activity"
                      ,"timeBodyAccMeanX","timeBodyAccMeanY","timeBodyAccMeanZ"
                      ,"timeBodyAccStdX","timeBodyAccStdY","timeBodyAccStdZ"
                      ,"timeGravityAccMeanX","timeGravityAccMeanY","timeGravityAccMeanZ"
                      ,"timeGravityAccStdX","timeGravityAccStdY","timeGravityAccStdZ"
                      ,"timeBodyAccJerkMeanX","timeBodyAccJerkMeanY","timeBodyAccJerkMeanZ"
                      ,"timeBodyAccJerkStdX","timeBodyAccJerkStdY","timeBodyAccJerkStdZ"
                      ,"timeBodyGyroMeanX","timeBodyGyroMeanY","timeBodyGyroMeanZ"
                      ,"timeBodyGyroStdX","timeBodyGyroStdY","timeBodyGyroStdZ"
                      ,"timeBodyGyroJerkMeanX","timeBodyGyroJerkMeanY","timeBodyGyroJerkMeanZ"
                      ,"timeBodyGyroJerkStdX","timeBodyGyroJerkStdY","timeBodyGyroJerkStdZ"
                      ,"timeBodyAccMagMean","timeBodyAccMagStd"
                      ,"timeGravityAccMagMean","timeGravityAccMagStd"
                      ,"timeBodyAccJerkMagMean","timeBodyAccJerkMagStd"
                      ,"timeBodyGyroMagMean","timeBodyGyroMagStd"
                      ,"timeBodyGyroJerkMagMean","timeBodyGyroJerkMagStd"
                      ,"freqBodyAccMeanX","freqBodyAccMeanY","freqBodyAccMeanZ"
                      ,"freqBodyAccStdX","freqBodyAccStdY","freqBodyAccStdZ"
                      ,"freqBodyAccJerkMeanX","freqBodyAccJerkMeanY","freqBodyAccJerkMeanZ"
                      ,"freqBodyAccJerkStdX","freqBodyAccJerkStdY","freqBodyAccJerkStdZ"
                      ,"freqBodyGyroMeanX","freqBodyGyroMeanY","freqBodyGyroMeanZ"
                      ,"freqBodyGyroStdX","freqBodyGyroStdY","freqBodyGyroStdZ"
                      ,"freqBodyAccMagMean","freqBodyAccMagStd"
                      ,"freqBodyBodyAccJerkMagMean","freqBodyBodyAccJerkMagStd"
                      ,"freqBodyBodyGyroMagMean","freqBodyBodyGyroMagStd"
                      ,"freqBodyBodyGyroJerkMagMean","freqBodyBodyGyroJerkMagStd")
    
    
    colnames(data_test_subset) <- column_names
    
    
    ##Load Train Data, subset mean and standard deviation columns, and add colunm headers -> data_train_subset
    subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    activity_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
    data_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
    
    #Attach the subject identifier to data_train. subject_train is a one-column data frame.
    data_train$subject <- subject_train[,1]

    #Translate activity numbers to corresponding codes 
    #See activity_labels.txt for the number-to-code mapping.
    activity_train$activity <- sapply(activity_train[,1], FUN=translate_activity)
    data_train$activity <- activity_train$activity
    
    #Select out just the -mean() and -std() columns. The column numbers were
    #determined by inspecting features.txt
    data_train_subset <- select(data_train
                                ,subject
                                ,activity
                                ,V1,V2,V3,V4,V5,V6,V41,V42,V43,V44,V45,V46,V81
                                ,V82,V83,V84,V85,V86,V121,V122,V123,V124,V125
                                ,V126,V161,V162,V163,V164,V165,V166,V201,V202
                                ,V214,V215,V227,V228,V240,V241,V253,V254,V266
                                ,V267,V268,V269,V270,V271,V345,V346,V347,V348
                                ,V349,V350,V424,V425,V426,V427,V428,V429,V503
                                ,V504,V516,V517,V529,V530,V542,V543)
    
    #Apply the correct column names.
    colnames(data_train_subset) <- column_names
    
    
    ## Combine the train and test data into a single data frame -> data_combined
    data_combined <- merge(data_test_subset, data_train_subset, all=TRUE)
    
    
    ## Group data_combined by subject and activity, then take the mean of all the measurements -> summarized
    grouped <- group_by(data_combined, activity, subject)
    
    summarized <- summarize(grouped
                            ,meanOfTimeBodyAccMeanX = mean(timeBodyAccMeanX)
                            ,meanOfTimeBodyAccMeanY = mean(timeBodyAccMeanY)
                            ,meanOfTimeBodyAccMeanZ = mean(timeBodyAccMeanZ)
                            ,meanOfTimeBodyAccStdX = mean(timeBodyAccStdX)
                            ,meanOfTimeBodyAccStdY = mean(timeBodyAccStdY)
                            ,meanOfTimeBodyAccStdZ = mean(timeBodyAccStdZ)
                            ,meanOfTimeGravityAccMeanX = mean(timeGravityAccMeanX)
                            ,meanOfTimeGravityAccMeanY = mean(timeGravityAccMeanY)
                            ,meanOfTimeGravityAccMeanZ = mean(timeGravityAccMeanZ)
                            ,meanOfTimeGravityAccStdX = mean(timeGravityAccStdX)
                            ,meanOfTimeGravityAccStdY = mean(timeGravityAccStdY)
                            ,meanOfTimeGravityAccStdZ = mean(timeGravityAccStdZ)
                            ,meanOfTimeBodyAccJerkMeanX = mean(timeBodyAccJerkMeanX)
                            ,meanOfTimeBodyAccJerkMeanY = mean(timeBodyAccJerkMeanY)
                            ,meanOfTimeBodyAccJerkMeanZ = mean(timeBodyAccJerkMeanZ)
                            ,meanOfTimeBodyAccJerkStdX = mean(timeBodyAccJerkStdX)
                            ,meanOfTimeBodyAccJerkStdY = mean(timeBodyAccJerkStdY)
                            ,meanOfTimeBodyAccJerkStdZ = mean(timeBodyAccJerkStdZ)
                            ,meanOfTimeBodyGyroMeanX = mean(timeBodyGyroMeanX)
                            ,meanOfTimeBodyGyroMeanY = mean(timeBodyGyroMeanY)
                            ,meanOfTimeBodyGyroMeanZ = mean(timeBodyGyroMeanZ)
                            ,meanOfTimeBodyGyroStdX = mean(timeBodyGyroStdX)
                            ,meanOfTimeBodyGyroStdY = mean(timeBodyGyroStdY)
                            ,meanOfTimeBodyGyroStdZ = mean(timeBodyGyroStdZ)
                            ,meanOfTimeBodyGyroJerkMeanX = mean(timeBodyGyroJerkMeanX)
                            ,meanOfTimeBodyGyroJerkMeanY = mean(timeBodyGyroJerkMeanY)
                            ,meanOfTimeBodyGyroJerkMeanZ = mean(timeBodyGyroJerkMeanZ)
                            ,meanOfTimeBodyGyroJerkStdX = mean(timeBodyGyroJerkStdX)
                            ,meanOfTimeBodyGyroJerkStdY = mean(timeBodyGyroJerkStdY)
                            ,meanOfTimeBodyGyroJerkStdZ = mean(timeBodyGyroJerkStdZ)
                            ,meanOfTimeBodyAccMagMean = mean(timeBodyAccMagMean)
                            ,meanOfTimeBodyAccMagStd = mean(timeBodyAccMagStd)
                            ,meanOfTimeGravityAccMagMean = mean(timeGravityAccMagMean)
                            ,meanOfTimeGravityAccMagStd = mean(timeGravityAccMagStd)
                            ,meanOfTimeBodyAccJerkMagMean = mean(timeBodyAccJerkMagMean)
                            ,meanOfTimeBodyAccJerkMagStd = mean(timeBodyAccJerkMagStd)
                            ,meanOfTimeBodyGyroMagMean = mean(timeBodyGyroMagMean)
                            ,meanOfTimeBodyGyroMagStd = mean(timeBodyGyroMagStd)
                            ,meanOfTimeBodyGyroJerkMagMean = mean(timeBodyGyroJerkMagMean)
                            ,meanOfTimeBodyGyroJerkMagStd = mean(timeBodyGyroJerkMagStd)
                            ,meanOfFreqBodyAccMeanX = mean(freqBodyAccMeanX)
                            ,meanOfFreqBodyAccMeanY = mean(freqBodyAccMeanY)
                            ,meanOfFreqBodyAccMeanZ = mean(freqBodyAccMeanZ)
                            ,meanOfFreqBodyAccStdX = mean(freqBodyAccStdX)
                            ,meanOfFreqBodyAccStdY = mean(freqBodyAccStdY)
                            ,meanOfFreqBodyAccStdZ = mean(freqBodyAccStdZ)
                            ,meanOfFreqBodyAccJerkMeanX = mean(freqBodyAccJerkMeanX)
                            ,meanOfFreqBodyAccJerkMeanY = mean(freqBodyAccJerkMeanY)
                            ,meanOfFreqBodyAccJerkMeanZ = mean(freqBodyAccJerkMeanZ)
                            ,meanOfFreqBodyAccJerkStdX = mean(freqBodyAccJerkStdX)
                            ,meanOfFreqBodyAccJerkStdY = mean(freqBodyAccJerkStdY)
                            ,meanOfFreqBodyAccJerkStdZ = mean(freqBodyAccJerkStdZ)
                            ,meanOfFreqBodyGyroMeanX = mean(freqBodyGyroMeanX)
                            ,meanOfFreqBodyGyroMeanY = mean(freqBodyGyroMeanY)
                            ,meanOfFreqBodyGyroMeanZ = mean(freqBodyGyroMeanZ)
                            ,meanOfFreqBodyGyroStdX = mean(freqBodyGyroStdX)
                            ,meanOfFreqBodyGyroStdY = mean(freqBodyGyroStdY)
                            ,meanOfFreqBodyGyroStdZ = mean(freqBodyGyroStdZ)
                            ,meanOfFreqBodyAccMagMean = mean(freqBodyAccMagMean)
                            ,meanOfFreqBodyAccMagStd = mean(freqBodyAccMagStd)
                            ,meanOfFreqBodyBodyAccJerkMagMean = mean(freqBodyBodyAccJerkMagMean)
                            ,meanOfFreqBodyBodyAccJerkMagStd = mean(freqBodyBodyAccJerkMagStd)
                            ,meanOfFreqBodyBodyGyroMagMean = mean(freqBodyBodyGyroMagMean)
                            ,meanOfFreqBodyBodyGyroMagStd = mean(freqBodyBodyGyroMagStd)
                            ,meanOfFreqBodyBodyGyroJerkMagMean = mean(freqBodyBodyGyroJerkMagMean)
                            ,meanOfFreqBodyBodyGyroJerkMagStd = mean(freqBodyBodyGyroJerkMagStd)
    )
    
    ## Output summarized. This is the implementation of Step 5.
    write.table(summarized, "./step5.txt", quote=FALSE, row.names=FALSE)
}

# Maps activityId values to the corresponding text value.
translate_activity <- function(activityId){
    
    if (activityId == 1){
        activity <- "WALKING"
    }else if (activityId == 2){
        activity <- "WALKING_UPSTAIRS"
    }else if (activityId == 3){
        activity <- "WALKING_DOWNSTAIRS"
    }else if (activityId == 4){
        activity <- "SITTING"
    }else if (activityId == 5){
        activity <- "STANDING"
    }else if (activityId == 6){
        activity <- "LAYING"
    }
    
    activity
}
