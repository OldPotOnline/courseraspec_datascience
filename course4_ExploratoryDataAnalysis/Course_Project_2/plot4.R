dataDir <- "/Users/tingliangguo/repos/github/data/ExData_Plotting2/"

library(plyr)
library(ggplot2)

NEI <- readRDS(paste(dataDir, "summarySCC_PM25.rds", sep = ""))
SCC <- readRDS(paste(dataDir, "Source_Classification_Code.rds", sep = ""))

SCC_coal <- grep("coal", SCC$Short.Name, ignore.case = TRUE)
SCC_coal <- SCC[SCC_coal, ]
SCC_identifiers <- as.character(SCC_coal$SCC)

NEI$SCC <- as.character(NEI$SCC)
NEI_coal <- NEI[NEI$SCC %in% SCC_identifiers, ]

aggregate_coal <- with(NEI_coal, aggregate(Emissions, by = list(year), sum))
colnames(aggregate_coal) <- c("year", "Emissions")

#Plot 4
png(filename = "plot4.png",
    units = "px", bg = "transparent",
    width = 480, height = 480)
plot(aggregate_coal, type = "b", ylab = expression("Total Emissions, PM"[2.5]), 
     xlab = "Year", main = "Emissions and Total Coal Combustion for the United States", 
     xlim = c(1999, 2008))
dev.off()
