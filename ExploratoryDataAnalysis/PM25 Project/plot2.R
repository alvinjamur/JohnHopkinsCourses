setwd("~/Desktop/pm25data")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset data from NEI for Baltimore's by using "fip" code

baltimore <- NEI[NEI$fips=="24510", ]

# now aggregate

aggregate_totals_Baltimore <- aggregate(Emissions ~ year, baltimore, sum)

# now plot

png("plot2.png", width=800, height=800, units="px", bg="white")

barplot(aggregate_totals_Baltimore$Emissions,
        names.arg = aggregate_totals_Baltimore$year,
        xlab="Year",
        ylab="PM2.5 Emissions (Tons)",
      main="Total PM 2.5 Emissions : Baltimore (All Sources)"
)

dev.off()

