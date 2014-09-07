#Question 1
data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
data_file <- "getdata_2Fdata_2Fss06hid.csv"
download.file(data_url, destfile=data_file, method = "curl")
data <- read.csv(data_file, header=TRUE)
strsplit(names(data), "wgtp")[123]

#Question 2
data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
data_file <- "getdata_2Fdata_2FGDP.csv"
download.file(data_url, destfile=data_file, method = "curl")
data <- read.csv(data_file, skip=4, nrows=190)
library(stringr)
mean(as.numeric(str_trim(gsub(",","",data[["X.4"]]))), na.rm=TRUE)
#mean(as.numeric(str_trim(gsub(",","",data[["X.3"]]))), na.rm=TRUE)

#Question 3
grep("^United", data$X.3)

#Question 4
data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
data_file <- "getdata_2Fdata_2FGDP.csv"
download.file(data_url, destfile=data_file, method = "curl")
gdpData <- read.csv(data_file, header=TRUE)

data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
data_file <- "getdata_2Fdata_2FEDSTATS_Country.csv"
download.file(data_url, destfile=data_file, method = "curl")
countryData <- read.csv(data_file, header=TRUE)
mergedData <- merge(gdpData, countryData, by.x = "X", by.y = "CountryCode")
# extract the information
fy.june <- grep('Fiscal year end: June', mergedData$Special.Notes)
length(fy.june)

#Question 5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
y2012 <- grepl("^2012", sampleTimes)
table(y2012)

# subset based on 2012
sampleTimes2012 <- subset(sampleTimes, y2012)

# convert to day of week
day <- format(sampleTimes2012, '%A')

# count each day
table(day)

