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

## Plot 4
png(filename = "plot4.png", 
    units = "px", bg = "transparent",
    width = 480, height = 480)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,1,2,0), bg="transparent")
with(data, {
    plot(Global_active_power~Datetime, type="l", 
         ylab="Global Active Power", xlab="")
    plot(Voltage~Datetime, type="l", 
         ylab="Voltage", xlab="datetime")
    plot(Sub_metering_1~Datetime, type="l", 
         ylab="Global Active Power", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~Datetime, type="l", 
         ylab="Global_Rective_Power",xlab="datetime")
})
dev.off()