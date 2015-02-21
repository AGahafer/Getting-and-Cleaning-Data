#These bring in the data and then combine into proper form. First bind by rows, then by columns.
X_test <- read.table("C:/Users/C16Allison.Gahafer/Desktop/C2CYear/Spring2015/Math378/UCI HAR Dataset/test/X_test.txt", quote="\"")
X_train <- read.table("C:/Users/C16Allison.Gahafer/Desktop/C2CYear/Spring2015/Math378/UCI HAR Dataset/train/X_train.txt", quote="\"")

y_test <- read.table("C:/Users/C16Allison.Gahafer/Desktop/C2CYear/Spring2015/Math378/UCI HAR Dataset/test/y_test.txt", quote="\"")
y_train <- read.table("C:/Users/C16Allison.Gahafer/Desktop/C2CYear/Spring2015/Math378/UCI HAR Dataset/train/y_train.txt", quote="\"")

combo.x<-rbind(X_train,X_test)
combo.y<-rbind(y_train,y_test)

activity_labels <- read.table("C:/Users/C16Allison.Gahafer/Desktop/C2CYear/Spring2015/Math378/UCI HAR Dataset/activity_labels.txt", quote="\"")

subject_test <- read.table("C:/Users/C16Allison.Gahafer/Desktop/C2CYear/Spring2015/Math378/UCI HAR Dataset/test/subject_test.txt", quote="\"")
subject_train <- read.table("C:/Users/C16Allison.Gahafer/Desktop/C2CYear/Spring2015/Math378/UCI HAR Dataset/train/subject_train.txt", quote="\"")
subject_total=rbind(subject_test,subject_train)

#This tests the length of the y sets, which are the activity sets, for the for loop
ytestlength<-nrow(y_test)
ytrainlength<-nrow(y_train)
totalylength<-ytestlength+ytrainlength

#This for loop replaces the spots in the Activity column with the proper activity
for(i in 1:totalylength){
  if (combo.y[i,1]==1){
    combo.y[i,1]<-"WALKING"
  }
  if (combo.y[i,1]==2){
    combo.y[i,1]<-"WALKING_UPSTAIRS"
  }
  if (combo.y[i,1]==3){
    combo.y[i,1]<-"WALKING_DOWNSTAIRS"
  }
  if (combo.y[i,1]==4){
    combo.y[i,1]<-"SITTING"
  }
  if (combo.y[i,1]==5){
    combo.y[i,1]<-"STANDING"
  }
  if (combo.y[i,1]==6){
    combo.y[i,1]<-"LAYING"
  }
}

#This adds all the data into the combo data frame. This is what is maipulated the rest of the project.
combo<-cbind(subject_total,combo.x,combo.y)

#This pulls in the column names and then assigns them to their columns in order
features <- read.table("C:/Users/C16Allison.Gahafer/Desktop/C2CYear/Spring2015/Math378/UCI HAR Dataset/features.txt", quote="\"")
features2<-t(features)
features2=cbind("Subject",features2)

colnames(combo)<-features2[2,]

colnames(combo)[colnames(combo)=="NA"] <- "Activity"

#This is the vector for the 30 subjects
subjects=c(1:30)

#the grep command finds the columns that have either mean or sd() in the names and then puts the columns numbers in a vector
require(base)
meancols<-grep("mean()",colnames(combo))
stdcols<-grep("std()",colnames(combo))

#this puts all the columns with mean or sd into one data set, then takes away the one with frquency, leaving 68 cols. 
newdata<-cbind(subject_total,combo.y,combo[,meancols],combo[,stdcols])
meanFreq<-grep("meanFreq()",colnames(newdata))
newdata<-newdata[,-meanFreq]

colnames(newdata)[colnames(newdata)=="V1"]<-"Subject"
colnames(newdata)[colnames(newdata)=="V1.1"]<-"Activity"

colsofmean<-combo[,meancols]
colsofstd<-combo[,stdcols]

#This renames the columns
names(combo)<-gsub("^t","Time ",names(combo))
names(combo)<-gsub("Acc","Accelerometer",names(combo))
names(combo)<-gsub("^f","Frequency ",names(combo))
names(combo)<-gsub("Gyro","Gyroscope",names(combo))
names(combo)<-gsub("Mag","Magnitute",names(combo))
names(combo)<-gsub("BodyBody","Body",names(combo))
View(combo)


TidyData=c()
#This is where the tidy data set is made, with only the means for each variable.
for(i in  1:30){
  for (j in 1:6){
    fakevector=subset(newdata,Subject==subjects[i]& Activity==activity_labels[j,2])
    anothervector=apply(fakevector[,3:68],2,mean)
    vector1=cbind(subjects[i],activity_labels[j,2],t(anothervector))
    TidyData=rbind(TidyData,vector1)
  }
}
colnames(TidyData)[colnames(TidyData)=="V1"]<-"Subject"
colnames(TidyData)[colnames(TidyData)=="V1.1"]<-"Activity"
