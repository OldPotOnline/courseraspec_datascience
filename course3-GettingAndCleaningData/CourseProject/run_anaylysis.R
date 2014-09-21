#Data directory - ~/repos/github/data/ClearningData_Project/
dataDir <- "~/repos/github/data/ClearningData_Project/"

#1. Merges the training and the test sets to create one data set.
x_training <- read.csv( paste( dataDir, "UCI HAR Dataset/train/X_train.txt", sep = "" ), sep = "", header = FALSE )
y_training <- read.csv( paste( dataDir, "UCI HAR Dataset/train/y_train.txt", sep = "" ), sep = "", header = FALSE )
subject_train <- read.csv( paste( dataDir, "UCI HAR Dataset/train/subject_train.txt", sep = ""), sep = "", header = FALSE )

training <- cbind(x_training, y_training, subject_train)

x_test <- read.csv( paste( dataDir, "UCI HAR Dataset/test/X_test.txt", sep = "" ), sep = "", header = FALSE )
y_test <- read.csv( paste( dataDir, "UCI HAR Dataset/test/Y_test.txt", sep = "" ), sep = "", header = FALSE )
subject_test <- read.csv( paste( dataDir, "UCI HAR Dataset/test/subject_test.txt", sep = "" ), sep = "", header = FALSE )

testing <- cbind(x_test, y_test, subject_test)

allData = rbind(training, testing)

#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.csv( paste( dataDir, "UCI HAR Dataset/features.txt", sep = ""), sep = "", header = FALSE )
targetMeasureCols <- grep(".*-mean.*|.*-std.*", features[,2])
features <- features[targetMeasureCols,]
## Get data
dataCols <- c(targetMeasureCols, 562, 563) 
allData <- allData[, dataCols]
## Add columns
colnames(allData) <- c(features$V2, "Activity", "Subject")
colnames(allData) <- tolower(colnames(allData))


activity_labels <- read.csv( paste( dataDir, "UCI HAR Dataset/activity_labels.txt", sep = "" ), sep = "", header=FALSE )

currAct = 1
for (currActLbl in activity_labels$V2) {
    allData$activity <- gsub(currAct, currActLbl, allData$activity)
    currAct <- currAct + 1
}


allData$activity <- as.factor(allData$activity)
allData$subject <- as.factor(allData$subject)


tidy = aggregate(allData[1:7], by=list(activity = allData$activity, subject=allData$subject), mean)
# Remove the subject and activity column, since a mean of those has no use
tidy$activity = NULL
tidy$subject = NULL
write.table(tidy, "tidy.txt", sep="\t")