# Q3 - Of the four types of sources indicated by the \color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

# Loading the data
"NEI" <- readRDS("summarySCC_PM25.rds")
"SCC" <- readRDS("Source_Classification_Code.rds")

# Loading the package
library(ggplot2)
library(dplyr)

# Filter the data only Baltimore

"NEI_Bal" <- filter(NEI, NEI$fips == "24510")
unique(NEI_Bal$fips)                              # Check the data only Baltimore

"Total_emission.Bal.Type" <- aggregate(NEI_Bal$Emissions ~ NEI_Bal$year + NEI_Bal$type, NEI_Bal, FUN = sum)

# Make a plot

"plot_3" <- ggplot(Total_emission.Bal.Type, aes(x = Total_emission.Bal.Type$`NEI_Bal$year`, y = Total_emission.Bal.Type$`NEI_Bal$Emissions`)) + geom_point() + geom_line() + facet_grid(.~Total_emission.Bal.Type$`NEI_Bal$type`) + theme_bw() + theme(plot.title = element_text(hjust = 0.5), axis.text.x = element_text(angle = 45, hjust = 1)) + xlab("Year") + ylab("Total Emissions") + ggtitle("decreased PM2.5 in the US from 1999 to 2008 \n in Baltimore by different type of sources")

ggsave("plot_3.png")
