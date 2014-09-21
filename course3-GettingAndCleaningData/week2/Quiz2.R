#Question 1
library(httpuv)
library(httr)
library(jsonlite)

oauth_endpoints("github")

myapp <- oauth_app("github", "fde0c877ac481d124cfd", "ea99a933220c84caab1c2c571bf30dc0ed30c493")
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

#Question 4
library(XML)
url <- "http://biostat.jhsph.edu/~jleek/contact.html"
htmlCode <- readLines(url)
close(con)
print(nchar(htmlCode[c(10,20,30,100)]))

#Question 5
data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
data_file <- "getdata_Fwksst8110.for"
download.file(data_url, destfile=data_file, method = "curl")
myData<-read.fwf(data_file,widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4), skip=4)
head(myData)
sum(myData[, 4])