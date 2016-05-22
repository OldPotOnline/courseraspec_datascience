library(caret)
library(rpart)
library(rpart.plot)
library(randomForest)
library(corrplot)
library(rattle)


# 

# trainUrl <-"https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
# testUrl <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"
# trainFile <- "./data/pml-training.csv"
# testFile  <- "./data/pml-testing.csv"
# if (!file.exists("./data")) {
#   dir.create("./data")
# }
# if (!file.exists(trainFile)) {
#   download.file(trainUrl, destfile=trainFile, method="curl")
# }
# if (!file.exists(testFile)) {
#   download.file(testUrl, destfile=testFile, method="curl")
# }
# 



trainRaw <- read.csv("./data/pml-training.csv", na.strings=c("", "NA", "NULL"))
testRaw <- read.csv("./data/pml-testing.csv", na.strings=c("", "NA", "NULL"))
dim(trainRaw)
dim(testRaw)

# data clean
tr.notnan<- trainRaw[ , colSums(is.na(trainRaw)) == 0]
remove = c('X', 'user_name', 'raw_timestamp_part_1', 'raw_timestamp_part_2', 'cvtd_timestamp', 'new_window', 'num_window')
tr.core <- tr.notnan[, -which(names(tr.notnan) %in% remove)]
dim(tr.core)

# only numeric variabls can be evaluated in this way.

zeroVar= nearZeroVar(tr.core[sapply(tr.core, is.numeric)], saveMetrics = TRUE)
tr.nonzero = tr.core[,zeroVar[, 'nzv']==0]
dim(tr.nonzero)


# only numeric variabls can be evaluated in this way.
corrMatrix <- cor(na.omit(tr.nonzero[sapply(tr.nonzero, is.numeric)]))
dim(corrMatrix)


removecor = findCorrelation(corrMatrix, cutoff = .90, verbose = TRUE)

tr.decor = tr.nonzero[,-removecor]
dim(tr.decor)


inTrain <- createDataPartition(tr.decor$classe, p=0.7, list=F)
training <- tr.decor[inTrain,]
testing <- tr.decor[-inTrain,]

# desicion tree
# model fit
set.seed(12345)
rf.decTree_training <- rpart(classe ~ ., data=training, method="class")
fancyRpartPlot(rf.decTree_training, sub="Descision Tree")

# out of sample predicate
predicted <- predict(modFitDecTree, newdata=testing, type="class")
confMat <- confusionMatrix(predicted, testing$classe)
confMat
confMat$overall["Accuracy"]


# random forest
rf.randomForest_training=randomForest(classe~.,data=training,ntree=100, importance=TRUE)
rf.randomForest_training

# out of sample predicate
predictDecTree <- predict(rf.randomForest_training, newdata=testing, type="class")
confMat <- confusionMatrix(predicted, testing$classe)
confMat
confMat$overall["Accuracy"]





answers <- predict(rf.training, testRaw)
answers

# 
# trainRaw <- trainRaw[, colSums(is.na(trainRaw)) == 0] 
# testRaw <- testRaw[, colSums(is.na(testRaw)) == 0] 
# 
# 
# 
# classe <- trainRaw$classe
# trainRemove <- grepl("^X|timestamp|window", names(trainRaw))
# trainRaw <- trainRaw[, !trainRemove]
# trainCleaned <- trainRaw[, sapply(trainRaw, is.numeric)]
# trainCleaned$classe <- classe
# testRemove <- grepl("^X|timestamp|window", names(testRaw))
# testRaw <- testRaw[, !testRemove]
# testCleaned <- testRaw[, sapply(testRaw, is.numeric)]
# 
# 
# 
# set.seed(22519) # For reproducibile purpose
# inTrain <- createDataPartition(trainCleaned$classe, p=0.70, list=F)
# trainData <- trainCleaned[inTrain, ]
# testData <- trainCleaned[-inTrain, ]
# 
# 
# 
# controlRf <- trainControl(method="cv", 5)
# modelRf <- train(classe ~ ., data=trainData, method="rf", trControl=controlRf, ntree=250)
# modelRf
# 
# 
# predictRf <- predict(modelRf, testData)
# confusionMatrix(testData$classe, predictRf)
# accuracy <- postResample(predictRf, testData$classe)
# accuracy
# oose <- 1 - as.numeric(confusionMatrix(testData$classe, predictRf)$overall[1])
# oose
# 
# 
# result <- predict(modelRf, testCleaned[, -length(names(testCleaned))])
# result
# 







training.dena <- trainRaw[ , colSums(is.na(trainRaw)) == 0]


