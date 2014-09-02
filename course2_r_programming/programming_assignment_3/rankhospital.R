
rankhospital <- function(state, outcome, num="best") {
    
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")    
    options(warn=-1) # disable warn if there are NA data
    
    if(!state %in% data$State) {
        stop(sprintf("Error in rankhospital(\"%s\", \"%s\", \"%s\") : invalid state", state, outcome, num))        
    }
    
    if(outcome == "heart attack") {
        outcome_data <- as.numeric(data[, 11])
    } else if(outcome == "heart failure") {
        outcome_data <- as.numeric(data[, 17])
    } else if(outcome == "pneumonia") {
        outcome_data <- as.numeric(data[, 23])
    } else {
        stop(sprintf("Error in rankhospital(\"%s\", \"%s\", \"%s\") : invalid outcome", state, outcome, num))
    }
    
    dataInd <- order(outcome_data[data$State == state], data$Hospital.Name[data$State == state])
    
    sortedData <- list(name = data$Hospital.Name[data$State == state][dataInd], rate= outcome_data[data$State == state][dataInd])
    if(num == "best") {
        headPosition = 1
        while(is.na(head(sortedData$rate, headPosition))  && headPosition < length(sortedData$rate)) {
            headPosition = headPosition + 1
        }
        tail(head(sortedData$name, headPosition), 1)
    } else if(num == "worst") {
        tailPosition = 1
        while(is.na(tail(sortedData$rate, tailPosition))  && tailPosition < length(sortedData$rate)) {
            tailPosition = tailPosition + 1
        }
        head(tail(sortedData$name, tailPosition), 1)
    } else if(!is.na(as.numeric(num))) {
        sortedData$name[as.numeric(num)]
    } else {
        stop(sprintf("Error in rankhospital(\"%s\", \"%s\", \"%s\") : invalid num", state, outcome, num))
    }   
}