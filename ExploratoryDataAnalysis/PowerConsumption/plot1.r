#
# Script assumes you are in directory with the file 'household_power_consumption.txt'
#


datafile <- "household_power_consumption.txt"
data <- read.table(datafile, sep=";", header=TRUE, stringsAsFactors=FALSE, dec=".")

# subset the data to the dates we are interested in...

subsetdata <- data[data$Date %in% c("1/2/2007","2/2/2007") , ]

# convert to numeric and plot as png, then close the device

globalactivepower <- as.numeric(subsetdata$Global_active_power)
png("plot1.png", width=480, height=480)
hist(globalactivepower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()