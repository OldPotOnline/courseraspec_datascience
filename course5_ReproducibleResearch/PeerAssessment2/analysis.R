dataDir <- "/Users/tingliangguo/repos/github/data/ReprodResearch_Assessment2/"

data <- read.csv(paste(dataDir, "repdata-data-StormData.csv", sep = ""))

head(data)
names(data)

str(data)



data$EVTYPE <- toupper(data$EVTYPE)
eventtype <- sort(unique(data$EVTYPE))
## Show first 50 event types
eventtype[1:50]

data$EVTYPE <- as.factor(data$EVTYPE)
data$FATALITIES <- as.numeric(data$FATALITIES)
data$INJURIES <- as.numeric(data$INJURIES)


library(data.table)
fatalities <- as.data.table(subset(aggregate(FATALITIES ~ EVTYPE, data = data, FUN = "sum"), FATALITIES > 0))
fatalities <- fatalities[order(-FATALITIES), ]
fatalities$EVTYPE <- reorder(fatalities$EVTYPE, fatalities$FATALITIES)
top20 <- fatalities[1:20, ] 
library(ggplot2)
ggplot(data = top20, aes(x=EVTYPE, y=FATALITIES, fill = FATALITIES) ) + 
    geom_bar(stat = "identity") + 
    xlab("Event") + 
    ylab("Fatalities") + 
    ggtitle("Fatalities caused by Events (top 20) ") + 
    coord_flip() 



library(data.table)
injuries <- as.data.table(subset(aggregate(INJURIES ~ EVTYPE, data = data, 
                                             FUN = "sum"), INJURIES > 0))
injuries <- injuries[order(-INJURIES), ]
injuries$EVTYPE <- reorder(injuries$EVTYPE, injuries$INJURIES)

top20 <- injuries[1:20, ] 

library(ggplot2)
ggplot(data = top20, aes(ymin=0, ymax=INJURIES+2000,
                         x=EVTYPE, y=INJURIES, fill = INJURIES)) + 
    geom_bar(stat = "identity") + 
    xlab("Event") + 
    ylab("Injuries") + 
    ggtitle("Injuries caused by Events (top 20) ") + 
    coord_flip() +
    geom_text(size=4, aes(label=INJURIES),  position = position_dodge(width=0.1), hjust = -0.1)




unique(data$PROPDMGEXP)

data$PROPDMGEXP <- toupper(data$PROPDMGEXP)
unique(stormdata$PROPDMGEXP)

calcExp <- function(x, exp = "") {
    switch(exp, 
           `-` = x * -1, 
           `?` = x, 
           `+` = x, 
           `1` = x, 
           `2` = x * (10^2), 
           `3` = x * (10^3), 
           `4` = x * (10^4), 
           `5` = x * (10^5), 
           `6` = x * (10^6), 
           `7` = x * (10^7), 
           `8` = x * (10^8), 
           H = x * 100, 
           K = x * 1000, 
           M = x * 1e+06, 
           B = x * 1e+09, x)
}

applyCalcExp <- function(vx, vexp) {
    if (length(vx) != length(vexp)) 
        stop("Not same size")
    result <- rep(0, length(vx))
    for (i in 1:length(vx)) {
        result[i] <- calcExp(vx[i], vexp[i])
    }
    result
}

data$EconomicCosts <- applyCalcExp(as.numeric(data$PROPDMG), data$PROPDMGEXP)
summary(data$EconomicCosts)

cost <- as.data.table(subset(aggregate(EconomicCosts ~ EVTYPE, data = data, 
                                           FUN = "sum"), EconomicCosts > 0))
cost <- cost[order(-EconomicCosts), ]
cost$EVTYPE <- reorder(cost$EVTYPE, cost$EconomicCosts)

top20 <- cost[1:20, ] 

library(ggplot2)
ggplot(data = top20, aes(ymin=0, ymax=EconomicCosts + 0.1 * EconomicCosts ,
                         x=EVTYPE, y=EconomicCosts, fill = EconomicCosts)) + 
    geom_bar(stat = "identity") + 
    xlab("Event") + 
    ylab("Injuries") + 
    ggtitle("Injuries caused by Events (top 20) ") + 
    coord_flip() +
    geom_text(size=4, aes(label=format(EconomicCosts, scientific=TRUE)),  position = position_dodge(width=0.1), hjust = -0.1)


ggplot(data = top20, aes(x=EVTYPE, y=EconomicCosts, fill = EconomicCosts)) + 
    geom_bar(stat = "identity") + 
    xlab("Event") + 
    ylab("Injuries") + 
    ggtitle("Injuries caused by Events (top 20) ") + 
    coord_flip() +
    geom_text(size=4, aes(label=format(EconomicCosts, scientific=TRUE)),  position = position_dodge(width=0.1), hjust = -0.1)




