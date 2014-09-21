
rankall <- function(outcome, num = "best") {
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
        
    if(num == "best") {
        hospital <- lapply(sort(unique(data$State)), function(x) 
            data$Hospital.Name[data$State == x][which.min(outcome_data[data$State == x])])
    } else if(num == "worst") {
        hospital <- lapply(sort(unique(data$State)), function(x) 
            data$Hospital.Name[data$State == x][which.max(outcome_data[data$State == x])])
    } else if(!is.na(as.numeric(num))) {
        hospital <- lapply(sort(unique(data$State)), function(x) 
            data$Hospital.Name[data$State == x][order(outcome_data[data$State == x], data$Hospital.Name[data$State == x])[as.numeric(num)]])
    } else {
        stop(sprintf("Error in rankhospital(\"%s\", \"%s\", \"%s\") : invalid num", state, outcome, num))
    }
    
    result <- data.frame(hospital = unlist(hospital), state = sort(unique(data$State)))
    rownames(result) <- result$state
    return(result)
}