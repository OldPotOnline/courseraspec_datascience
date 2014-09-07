## Reading full data set
##? how to read satisified data only
all_data <- read.csv("./data/household_power_consumption.txt", header=TRUE, sep=';', na.strings="?", 
                     check.names=FALSE, stringsAsFactors=FALSE, comment.char="", quote='\"')
all_data$Date <- as.Date(all_data$Date, format="%d/%m/%Y")

## Subsetting the data
data <- subset(all_data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(all_data)

## Combine Date and Time
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Plot 2
png(filename = "plot2.png", 
    units = "px", bg = "transparent",
    width = 480, height = 480)
plot(data$Global_active_power~data$Datetime, 
     type="l", ylab="Global Active Power (kilowatts)", xlab="")

dev.off()