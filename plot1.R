
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

##### Plot 1 #####

png(paste(dirProj, "/plot1.png", sep=""), width=480, height=480)

hist(powerData$Global_active_power, col="Orangered", main="Global Active Power"
     , xlab="Global Active Power (kilowatts)", ylab="Frequency")

dev.off()

