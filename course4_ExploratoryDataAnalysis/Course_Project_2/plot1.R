dataDir <- "/Users/tingliangguo/repos/github/data/ExData_Plotting2/"

library(plyr)

NEI <- readRDS(paste(dataDir, "summarySCC_PM25.rds", sep = ""))

aggData <- with(NEI, aggregate(Emissions, by = list(year), sum))

#Plot 1
png(filename = "plot1.png",
    units = "px", bg = "transparent",
    width = 480, height = 480)
plot(aggData, type = "b", ylab = expression("Total Emissions, PM"[2.5]), 
     xlab = "Year", main = "Total Emissions in the United States")
dev.off()
