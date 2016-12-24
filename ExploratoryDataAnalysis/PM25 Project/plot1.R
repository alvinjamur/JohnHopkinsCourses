setwd("~/Desktop/pm25data")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# get aggregate numbers

aggregate_totals <- aggregate(Emissions ~ year, NEI, sum)

# now plot

png("plot1.png", width=800, height=800, units="px", bg="white")

barplot( (aggregate_totals$Emissions)/10^6, names.arg=aggregate_totals$year,
  xlab="Year", ylab="PM2.5 Emissions (10^6 Tons)",
  main="Total PM 2.5 Emissions From All US Sources"
)
dev.off()


