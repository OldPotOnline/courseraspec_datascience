library(plyr)

pollutantmean <- function(directory, pollutant, id = 1:332) {

  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  
  #Step 1: get file names
  fileName <- paste(directory, "/", formatC(id, width=3, flag="0"), ".csv", sep="")
  #Step 2: read data
  raw_data <- lapply(fileName, read.csv)
  data <- ldply(raw_data)
  #Step 3: calculate mean of the data
  result <- mean(data[, pollutant], na.rm=TRUE)
  return(result)
}


