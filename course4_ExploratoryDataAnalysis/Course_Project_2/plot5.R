dataDir <- "/Users/tingliangguo/repos/github/data/ExData_Plotting2/"

library(plyr)
library(ggplot2)

NEI <- readRDS(paste(dataDir, "summarySCC_PM25.rds", sep = ""))
SCC <- readRDS(paste(dataDir, "Source_Classification_Code.rds", sep = ""))

SCC_motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
SCC_motor <- SCC[SCC_motor, ]
SCC_identifiers <- as.character(SCC_motor$SCC)

NEI$SCC <- as.character(NEI$SCC)
NEI_24510_motor <- NEI[NEI$SCC %in% SCC_identifiers & NEI$fips == "24510", ]

aggregate_motor <- with(NEI_24510_motor, aggregate(Emissions, by = list(year), sum))
colnames(aggregate_motor) <- c("year", "Emissions")

#Plot 5
png(filename = "plot5.png",
    units = "px", bg = "transparent",
    width = 480, height = 480)
plot(aggregate_motor, type = "b", ylab = expression("Total Emissions, PM"[2.5]), 
     xlab = "Year", main = "Emissions and Total motor Combustion for  Baltimore City", 
     xlim = c(1999, 2008))
dev.off()
