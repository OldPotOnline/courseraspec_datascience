dataDir <- "/Users/tingliangguo/repos/github/data/ExData_Plotting2/"

library(plyr)
library(ggplot2)

NEI <- readRDS(paste(dataDir, "summarySCC_PM25.rds", sep = ""))
SCC <- readRDS("Source_Classification_Code.rds")

NEI_24510 <- NEI[which(NEI$fips == "24510"), ]

aggData <- with(NEI_24510, aggregate(Emissions, by = list(year), sum))

NEI_24510_type <- ddply(NEI_24510, .(type, year), summarize, Emissions = sum(Emissions))

#Plot 3
png(filename = "plot3.png",
    units = "px", bg = "transparent",
    width = 480, height = 480)
#qplot is the basic plotting function in the ggplot2 package
qplot(year, Emissions, data = NEI_24510_type, group = type, color = type, 
      geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "TotalEmissions in Baltimore City by Type of Pollutant")
dev.off()
