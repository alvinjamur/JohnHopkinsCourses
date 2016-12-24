#
# Script assumes you are in directory with the file 'household_power_consumption.txt'
#


datafile <- "household_power_consumption.txt"
data <- read.table(datafile, sep=";", header=TRUE, stringsAsFactors=FALSE, dec=".")

# subset the data to the dates we are interested in...

subsetdata <- data[data$Date %in% c("1/2/2007","2/2/2007") , ]

# paste Date and Time in to class POSIXct

datetime <- strptime(paste(subsetata$Date, subSetData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
globalactivepower <- as.numeric(subsetdata$Global_active_power)
submeter1 <- as.numeric(subsetdata$Sub_metering_1)
submeter2 <- as.numeric(subsetdata$Sub_metering_2)
submeter3 <- as.numeric(subsetdata$Sub_metering_3)
globalreactivepower <- as.numeric(subsetdata$Global_reactive_power)
voltage <- as.numeric(subsetdata$Voltage)

png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(datetime, globalactivepower, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, submeter1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, submeter2, type="l", col="red")
lines(datetime, submeter3, type="l", col="blue")

legend("topright", c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(datetime, globalreactivepower, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()