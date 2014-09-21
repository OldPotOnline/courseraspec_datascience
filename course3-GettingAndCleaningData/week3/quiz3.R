#Question 1
data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
data_file <- "getdata_2Fdata_Fss06hid.csv"
download.file(data_url, destfile=data_file, method = "curl")
data <- read.csv(data_file, header=TRUE)
which(data$AGS == 6 & data$ACR == 3)

#Question 2
library(jpeg)
data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
data_file <- "getdata_2Fjeff.jpg"
download.file(data_url, destfile=data_file, method = "curl")
img <- readJPEG(data_file, TRUE)

quantile(img, probs = seq(0, 1, 0.3))
quantile(img, probs = seq(0, 1, 0.8))
quantile(img, probs = c(0.3, 0.8))

#Question 3
data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
data_file <- "getdata_2Fdata_2FGDP.csv"
download.file(data_url, destfile=data_file, method = "curl")
gdpData <- read.csv(data_file, header=TRUE)

data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
data_file <- "getdata_2Fdata_2FEDSTATS_Country.csv"
download.file(data_url, destfile=data_file, method = "curl")
countryData <- read.csv(data_file, header=TRUE)
mergedData <- merge(gdpData, countryData, by.x = "X", by.y = "CountryCode")
raw_data <- mergedData[, c(1,2)]

mergedData$Gross.domestic.product.2012 <- as.numeric(as.character(mergedData$Gross.domestic.product.2012))
mean(mergedData$Gross.domestic.product.2012[which(mergedData$Income.Group=="High income: OECD")], na.rm=TRUE)
mean(mergedData$Gross.domestic.product.2012[which(mergedData$Income.Group=="High income: nonOECD")], na.rm=TRUE)

quantile(mergedData$Gross.domestic.product.2012,probs=c(0.2,0.4,0.6,0.8,1))
library(Hmisc)
mergedData$gdp=cut2(mergedData$Gross.domestic.product.2012,g=5)
table(mergedData$Income.Group,mergedData$gdp)
