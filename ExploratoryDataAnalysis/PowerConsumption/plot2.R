#
# Script assumes you are in directory with the file 'household_power_consumption.txt'
#


datafile <- "household_power_consumption.txt"
data <- read.table(datafile, sep=";", header=TRUE, stringsAsFactors=FALSE, dec=".")

# subset the data to the dates we are interested in...

subsetdata <- data[data$Date %in% c("1/2/2007","2/2/2007") , ]

# get date and time subset

datetime <- strptime(paste(subsetdata$Date, subsetdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

globalactivepower <- as.numeric(subsetdata$Global_active_power)

png("plot2.png", width=480, height=480)
plot(datetime, globalactivepower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
