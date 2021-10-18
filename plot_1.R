# Question: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# Loading the data
"NEI" <- readRDS("summarySCC_PM25.rds")
"SCC" <- readRDS("Source_Classification_Code.rds")

# Loading the package
library(ggplot2)
library(dplyr)

# Calculate the total emissions 

"Total_emissions" <- tapply(NEI$Emissions, NEI$year, sum)
Total_emissions <- data.frame("Year" = c(1999,2002,2005,2008), "Emissions" = Total_emissions)
row.names(Total_emissions) <- 1:nrow(Total_emissions)

# Make a plot
png("plot_1.png")

"plot_1" <- plot(Total_emissions$Year, (Total_emissions$Emissions/1.e6), type = "b", xlab = "Year", ylab = "Total emissions", main = "decreased PM2.5 in the US from 1999 to 2008")

dev.off()
