library(ggplot2)

setwd("~/Desktop/pm25data")

library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Merge data sets

NEISCC <- merge(NEI, SCC, by="SCC")

# Get NEI & SCC records with Short.Name (SCC) Coal and then subset it

coal_matches  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subset_NEISCC <- NEISCC[coal_matches, ]

aggregate_total_year <- aggregate(Emissions ~ year, subset_NEISCC, sum)

# now plot

png("plot4.png", width=800, height=800)

g <- ggplot(aggregate_total_year, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity", color="blue", fill="blue") + xlab("year") + ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from coal sources : 1999 to 2008')
print(g)
dev.off()
