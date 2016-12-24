

setwd("~/Desktop/pm25data")

library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get NEI & SCC records with Short.Name vehicle 

vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicles_SCC <- SCC[vehicles,]$SCC
vehicles_NEI <- NEI[NEI$SCC %in% vehicles_SCC,]

# Subset the vehicles NEI data by Baltimore fip

baltimore_vehicles <- vehicles_NEI[vehicles_NEI$fips=="24510", ]

# now plot

png("plot5.png", width=800, height=800)

gg <- ggplot(baltimore_vehicles, aes(factor(year), Emissions)) +
  geom_bar(stat="identity", fill="blue", width=0.5) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore : 1999-2008"))

print(gg)

dev.off()