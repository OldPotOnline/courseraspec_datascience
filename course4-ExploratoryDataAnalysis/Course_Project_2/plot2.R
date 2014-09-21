dataDir <- "/Users/tingliangguo/repos/github/data/ExData_Plotting2/"

library(plyr)

NEI <- readRDS(paste(dataDir, "summarySCC_PM25.rds", sep = ""))
NEI_24510 <- NEI[which(NEI$fips == "24510"), ]
aggData <- with(NEI_24510, aggregate(Emissions, by = list(year), sum))

#Plot 2
png(filename = "plot2.png",
    units = "px", bg = "transparent",
    width = 480, height = 480)
plot(aggData, type = "b", ylab = expression("Total Emissions, PM"[2.5]), 
     xlab = "Year", main = "Total Emissions in the Baltimore City")
dev.off()
