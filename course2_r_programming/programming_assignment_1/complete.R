complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  #Step 1: get file names
  fileName <- paste(directory, "/", formatC(id, width=3, flag="0"), ".csv", sep="")
  #Step 2: read data
  raw_data <- lapply(fileName, read.csv)
  data <- lapply(raw_data, function(x) x[!with(x, is.na(sulfate) | is.na(nitrate)), ])
  #a <- fileName[!with(fileName, is.na(sulfate) | is.na(nitrate)), ]
  #typeof(a)
  #length(a)
  
  tmp <- lapply(1:length(id), function(x) c(id[x], NROW(data[[x]])))
  #print(tmp[[1]])
  result <- ldply(tmp)
  #print(result)
  #print(tmp)
  #m <- mapply(function(X,Y) {
  #  sapply(1:length(id), function(row) c(X[row], NROW(Y[[row]])))
  #}, X=id, Y=data)
  #print(m)
  #print(c(id[1], NROW(data[[id[1]]])))
  #sum(a[1]) 
  data.frame(id=result$V1, nobs=result$V2)
}
