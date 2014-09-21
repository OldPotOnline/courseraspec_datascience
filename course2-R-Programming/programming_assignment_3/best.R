
best <- function(state, outcome) {
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")    
    options(warn=-1) # disable warn if there are NA data
    
    if(!state %in% data$State) stop(sprintf("Error in best(\"%s\", \"%s\") : invalid state", state, outcome))
    if(outcome == "heart attack") {
        outcome_data <- as.numeric(data[, 11])
    } else if(outcome == "heart failure") {
        outcome_data <- as.numeric(data[, 17])
    } else if(outcome == "pneumonia") {
        outcome_data <- as.numeric(data[, 23])
    } else {
        stop(sprintf("Error in best(\"%s\", \"%s\") : invalid outcome", state, outcome))
    }
    allName <- data$Hospital.Name[data$State == state][which.min(outcome_data[data$State == state])]
    allName[order(allName)[1]]
}
