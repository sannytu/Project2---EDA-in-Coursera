# Question 2 - Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (\color{red}{\verb|fips == "24510"|}fips == "24510") from 1999 to 2008? Use the base 
# plotting system to make a plot answering this question.

# Loading the data
"NEI" <- readRDS("summarySCC_PM25.rds")
"SCC" <- readRDS("Source_Classification_Code.rds")

# Loading the package
library(ggplot2)
library(dplyr)

# Filter the data only Baltimore

"NEI_Bal" <- filter(NEI, NEI$fips == "24510")
unique(NEI_Bal$fips)                              # Check the data only Baltimore

"Total_emissions.Bal" <- tapply(NEI_Bal$Emissions, NEI_Bal$year, sum)
Total_emissions.Bal <- data.frame("Year" = c(1999, 2002, 2005, 2008), "Emissions" = Total_emissions.Bal)
rownames(Total_emissions.Bal) <- 1:nrow(Total_emissions.Bal)

# Make a plot
png("plot_2.png")

"plot_2" <- plot(Total_emissions.Bal$Year, (Total_emissions.Bal$Emissions/1.e6), type = "b", xlab = "Year", ylab = "Total emissions", main = "decreased PM2.5 in the US from 1999 to 2008 in Baltimore" )

dev.off()
