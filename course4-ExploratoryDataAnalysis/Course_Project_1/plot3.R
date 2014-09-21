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

## Plot 3
png(filename = "plot3.png", 
    units = "px", bg = "transparent",
    width = 480, height = 480)
plot(data$Datetime, data$Sub_metering_1, 
     type = "l", col = "black",
     xlab = "", ylab = "Energy sub metering")
lines(data$Datetime, data$Sub_metering_2, col = "red")
lines(data$Datetime, data$Sub_metering_3, col = "blue")
legend("topright", 
       col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1)
dev.off()