# Function to check whether package is installed
is.installed <- function(mypkg){
    is.element(mypkg, installed.packages()[,1])
} 

#Question 1
data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
data_file <- "getdata_2Fdata_2Fss06hid.csv"
download.file(data_url, destfile=data_file, method = "curl")
data <- read.csv(data_file, header=TRUE)
sum(data$VAL==24, na.rm=TRUE)

#Question 2
head(data$FES, 1000)

#Question 3
# check if package "xlsx" is installed
if (!is.installed("xlsx")){
    install.packages("xlsx")
}
library(xlsx)
data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
data_file <- "getdata_2Fdata_2FDATA.gov_NGAP.xlsx"
download.file(data_url, destfile=data_file, method = "curl")
rowIndex <- 18:23
colIndex <- 7:15
dat <- read.xlsx(data_file, sheetIndex = 1, colIndex=colIndex, rowIndex = rowIndex)
sum(dat$Zip*dat$Ext,na.rm=T) 

#Question 4
# check if package "XML" is installed
if (!is.installed("XML")){
    install.packages("XML")
}
library(XML)
data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
data_file <- "getdata_2Fdata_2FFrestaurants.xml"
download.file(data_url, destfile=data_file, method = "curl")
doc <- xmlTreeParse("getdata_2Fdata_2FFrestaurants.xml", useInternal=TRUE)
rootNode <-xmlRoot(doc)

#Question 5
data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv "
data_file <- "getdata_2Fdata_2Fss06pid.csv"
download.file(data_url, destfile=data_file, method = "curl")
data <- read.csv(data_file, header=TRUE)
require(data.table)
DT <- fread(data_file)
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2])
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))

DT <- fread(data_file)
#A
st = proc.time()
for (i in 1:100){
    sapply(split(DT$pwgtp15,DT$SEX),mean)
}
print (proc.time() - st)

#B
st = proc.time()
for (i in 1:100){
    rowMeans(DT)[DT$SEX==1];rowMeans(DT)[DT$SEX==2]
}
print (proc.time() - st)

#C
st = proc.time()
for (i in 1:100){
    mean(DT$pwgtp15,by=DT$SEX)
}
print (proc.time() - st)

#D
st = proc.time()
for (i in 1:100){
    tapply(DT$pwgtp15,DT$SEX,mean)
}
print (proc.time() - st)

#E
st = proc.time()
for (i in 1:100){
    mean(DT[DT$SEX==1,]$pwgtp15);mean(DT[DT$SEX==2,]$pwgtp15)
}
print (proc.time() - st)

#F
st = proc.time()
for (i in 1:100){
    DT[,mean(pwgtp15),by=SEX]
}
print (proc.time() - st)




