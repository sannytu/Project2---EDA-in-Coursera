# Question: How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# Loading the data 

"NEI" <- readRDS("summarySCC_PM25.rds")
"SCC" <- readRDS("Source_Classification_Code.rds")

# Loading the packages

library(dplyr)
library(ggplot2)

# Calculate total emissions from motor vehicles only in Baltimore City

"vehicle" <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
"Merge.vehicle" <- merge(NEI, SCC[vehicle,])

"Total_emission.Vehicle.Bal" <- filter(Merge.vehicle, Merge.vehicle$fips == "24510")
unique(Total_emission.Vehicle.Bal$fips)  # to check the data only baltimore city
Total_emission.Vehicle.Bal <- tapply(Total_emission.Vehicle.Bal$Emissions, Total_emission.Vehicle.Bal$year, sum)
Total_emission.Vehicle.Bal <- data.frame("Year" = c(1999,2002,2005,2008), "Total Emission" = Total_emission.Vehicle.Bal)

row.names(Total_emission.Vehicle.Bal) <- 1:nrow(Total_emission.Vehicle.Bal)

# Make a plot
png("plot_5.png")

"plot_5" <- plot(Total_emission.Vehicle.Bal$Year, Total_emission.Vehicle.Bal$Total.Emission, type = "b", xlab = "Year", ylab = "Total emissions", main = "Total emissions from motor vehicle sources changed \n from 1999-2008 in Baltimore")

dev.off()
