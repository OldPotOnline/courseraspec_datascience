dataDir <- "/Users/tingliangguo/repos/github/data/ExData_Plotting2/"

library(plyr)
library(ggplot2)

NEI <- readRDS(paste(dataDir, "summarySCC_PM25.rds", sep = ""))
SCC <- readRDS(paste(dataDir, "Source_Classification_Code.rds", sep = ""))

SCC_motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
SCC_motor <- SCC[SCC_motor, ]
SCC_identifiers <- as.character(SCC_motor$SCC)

NEI$SCC <- as.character(NEI$SCC)
NEI_motor <- NEI[NEI$SCC %in% SCC_identifiers & (NEI$fips == "24510" | NEI$fips == "06037"), ]
NEI_motor_location_sum <- ddply(NEI_motor, .(fips, year), summarize, Emissions = sum(Emissions))

NEI_motor_location_sum$city[NEI_motor_location_sum$fips == "06037"] <- "Los Angeles County" 
NEI_motor_location_sum$city[NEI_motor_location_sum$fips == "24510"] <- "Baltimore City" 

#Plot 6
png(filename = "plot6.png",
    units = "px", bg = "transparent",
    width = 480, height = 480)
#qplot is the basic plotting function in the ggplot2 package
qplot(year, Emissions, data = NEI_motor_location_sum, group = city, color = city, 
      geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "Total Emissions in U.S. by Type of Pollutant") + 
      labs(name = "City")
dev.off()
