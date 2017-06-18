
##--------------- Initialisation ---------------##

# clear workspace
rm(list = ls())

# project folder
dirProj = "Course Project 1"



##--------------- Load and Clean Data ---------------##

# load data
inputDataFile = paste(dirProj, "/data/household_power_consumption.txt", sep="")
inputData = read.table(inputDataFile, sep=";", header=TRUE, stringsAsFactors=FALSE, na.strings="?")

# convert date field to filter to dates of interest
inputData$Date <- as.Date(inputData$Date, "%d/%m/%Y")

# subset to dates of interest
powerData <- subset(inputData, Date >= "2007-02-01" & Date <= "2007-02-02")

# format remaining columns to numeric
powerData[,3:ncol(powerData)] = as.numeric(as.character(unlist(powerData[,3:ncol(powerData)])))

# create date time column
powerData$DateTime = strptime(paste(powerData$Date,powerData$Time, sep=" "), "%Y-%m-%d %H:%M:%S")

# remove original data
rm("inputData")


##--------------- Create Plots ---------------##


##### Plot 4 #####


png(paste(dirProj, "/plot4.png", sep=""), width=480, height=480)

par(mfrow=c(2,2))

# top left
plot(powerData$DateTime, powerData$Global_active_power, type="n", xlab = "", ylab="Global Active Power")
lines(powerData$DateTime, powerData$Global_active_power)

# top right
plot(powerData$DateTime, powerData$Voltage, type="n", xlab = "datetime", ylab="Voltage")
lines(powerData$DateTime, powerData$Voltage)

# bottom left
plot(powerData$DateTime, powerData$Sub_metering_1, type="n", xlab = "", ylab="Energy sub metering")
lines(powerData$DateTime, powerData$Sub_metering_1, col="black")
lines(powerData$DateTime, powerData$Sub_metering_2, col="red")
lines(powerData$DateTime, powerData$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = "n", lty=c(1,1,1), col=c("black","red","blue"))

# bottom right
plot(powerData$DateTime, powerData$Global_reactive_power, type="n", xlab = "datetime", ylab="Global_reactive_power")
lines(powerData$DateTime, powerData$Global_reactive_power)


dev.off()


