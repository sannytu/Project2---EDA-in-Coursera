# Question: Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

# Loading the data 

"NEI" <- readRDS("summarySCC_PM25.rds")
"SCC" <- readRDS("Source_Classification_Code.rds")

# Loading the packages

library(dplyr)
library(ggplot2)

# Calculate emissions from coal combustion-related sources

"Coal" <- grepl("coal", SCC$Short.Name, ignore.case = TRUE)
"Merge.coal" <- merge(NEI, SCC[Coal,])

"Total_emissions.coal_related" <- tapply(Merge.coal$Emissions, Merge.coal$year, sum)
Total_emissions.coal_related <- data.frame("Year" = c(1999,2002,2005,2008), "Total Emissions" = Total_emissions.coal_related)

rownames(Total_emissions.coal_related) <- 1:nrow(Total_emissions.coal_related)

# Make a plot

png("plot_4.png")

"plot_4" <- plot(Total_emissions.coal_related$Year, Total_emissions.coal_related$Total.Emissions, type = "b", xlab = "Year", ylab = "Total emissions", main = "Total emissions from coal combustion-related \n sources changed from 1999-2008")

dev.off()
