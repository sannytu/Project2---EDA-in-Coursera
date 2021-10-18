# Question : Compare emissions from motor vehicle sources in Baltimore City with emissions from
# motor vehicle sources in Los Angeles County, California 
# (\color{red}{\verb|fips == "06037"|}fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# Loading the data 

"NEI" <- readRDS("summarySCC_PM25.rds")
"SCC" <- readRDS("Source_Classification_Code.rds")

# Loading the packages

library(dplyr)
library(ggplot2)

# Filter data only Baltimore and Los Angeles

"vehicle" <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
"Merge_vehicle" <- merge(NEI, SCC[vehicle,])

"Merge_vehicle.Bal_LA" <- filter(Merge_vehicle, Merge_vehicle$fips %in% c("06037","24510")) 
unique(Merge_vehicle.Bal_LA$fips)  # check the data only contain Baltimore and Los Angeles 

"Total_emission.Bal_LA" <- aggregate(Merge_vehicle.Bal_LA$Emissions ~ Merge_vehicle.Bal_LA$year + Merge_vehicle.Bal_LA$fips, Merge_vehicle.Bal_LA, FUN =  sum)
colnames(Total_emission.Bal_LA) <- c("Year", "City", "Total emissions")   # Rename the column
Total_emission.Bal_LA$City <- ifelse(Total_emission.Bal_LA$City == "06037", "Los Angeles", "Baltimore")

# Make a plot
png("plot_6.png")

"plot_6" <- ggplot(Total_emission.Bal_LA, aes(x = Total_emission.Bal_LA$Year, y = Total_emission.Bal_LA$`Total emissions`, color = Total_emission.Bal_LA$City)) + geom_point() + geom_line() + xlab("Year") + ylab("Total emissions") + labs(color = " ") + theme(plot.title = element_text(hjust = 0.5)) +
  ggtitle("Comparison emissions from motor vehicle sources \n from 1999 to 2008 between Baltimore City and Los Angeles")                      

ggsave("plot_6.png")
  
