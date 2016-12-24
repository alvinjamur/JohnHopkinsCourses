

setwd("~/Desktop/pm25data")

library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get NEI & SCC records with Short.Name vehicle 

vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicles_SCC <- SCC[vehicles,]$SCC
vehicles_NEI <- NEI[NEI$SCC %in% vehicles_SCC,]

# Subset the vehicles NEI data by Baltimore fip and also for LA

baltimore_vehicles <- vehicles_NEI[vehicles_NEI$fips=="24510", ]
baltimore_vehicles$city <- "Baltimore City"

LA_vehicles <- vehicles_NEI[vehicles_NEI$fips=="06037",]
LA_vehicles$city <- "Los Angeles County"

# Merge the two

combinedNEI <- rbind(baltimore_vehicles, LA_vehicles)

# now plot

png("plot6.png",width=800,height=800,units="px",bg="transparent")

ggp <- ggplot(combinedNEI, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") + facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="year", y=expression("Total PM"[2.5]*" Emissions (in Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Emissions : Baltimore & LA from 1999-2008"))

print(ggp)

dev.off()

