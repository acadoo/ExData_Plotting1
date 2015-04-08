"Checks for data directory and creates one if it doesn't exist"
if (!file.exists("data/UCI_Electric_power_consumption")) {
  message("Creating data directory")
  dir.create("data/UCI_Electric_power_consumption")
}
if (!file.exists("data/UCI_Electric_power_consumption")) {
  # download the data
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  zipfile="data/UCI_Electric_power_consumption.zip"
  message("Downloading data")
  download.file(fileURL, destfile=zipfile)
  unzip(zipfile, exdir="data")
}


## Getting full dataset
data_full <- read.csv("./data/UCI_Electric_power_consumption/household_power_consumption.txt", header=T, sep=';', na.strings="?",
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")
## Subsetting the data
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_full)
## Converting dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)
## Plot 1
hist(data$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
## Saving to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
