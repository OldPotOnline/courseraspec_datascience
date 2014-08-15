corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  
  source("complete.R")
  completeTable <- complete("specdata")
  
  remainedTable <- completeTable[(with(completeTable, completeTable$nobs > threshold)),]
  
  fileName <- paste(directory, "/", formatC(1:332, width=3, flag="0"), ".csv", sep="")
  raw_data <- lapply(fileName, read.csv)
  
  selectedData <- raw_data[remainedTable$id]
  raw_result <- lapply(1:length(selectedData), function(x) cor(selectedData[[x]]$sulfate, selectedData[[x]]$nitrate, use = "na.or.complete"))
   result <- ldply(raw_result)
  return(result$V1)
}