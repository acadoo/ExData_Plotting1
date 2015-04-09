## Checks for data directory and creates one if it doesn't exist"
if (!file.exists("data")) {
  message("Creating data directory")
  dir.create("data")
}
if (!file.exists("data/")) {
  ##  download the data
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  zipfile="data/UCI_Electric_power_consumption.zip"
  message("Downloading data")
  download.file(fileURL, destfile=zipfile)
  unzip(zipfile, exdir="data")
}

## Getting full dataset
data_full <- read.csv("./Data/household_power_consumption.txt", header=T, sep=';', na.strings="?",
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")
## Subsetting the data
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_full)
## Converting dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)
## Plot 3
with(data, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()