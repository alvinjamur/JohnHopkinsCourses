

setwd("~/Desktop/pm25data")

library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset data from NEI for Baltimore's by using "fip" code

baltimore <- NEI[NEI$fips=="24510", ]

# Aggregate using sum the Baltimore emissions data by year and type

aggregate_totals_Baltimore <- aggregate(Emissions ~ year + type, baltimore, sum)

# now plot

png("plot3.png",width=800,height=800,units="px",bg="white")

g <- ggplot(aggregate_totals_Baltimore, aes(year, Emissions, color = type))
g <- g + geom_line() +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions in Baltimore City from 1999 to 2008')
print(g)
dev.off()
