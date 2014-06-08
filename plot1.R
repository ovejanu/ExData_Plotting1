#Plot1

#Data Download

remote_file <- function(fileURL, remote_data) {
  if(!file.exists(remote_data)) {
    download.file(fileURL, destfile=remote_data, method="curl")
  }
  remote_data
}
remote_data <- remote_file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
raw <- unz(remote_data, "household_power_consumption.txt")

#Data Preparation
raw_data <- read.table(raw, header=T, sep=';', na.strings="?", colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
dataset <- raw_data[(raw_data$Date == "1/2/2007") | (raw_data$Date == "2/2/2007"),]
dataset$DateTime <- strptime(paste(dataset$Date, dataset$Time), "%d/%m/%Y %H:%M:%S")
write.csv(dataset, "tidy_data.csv")

#Results
plot1 <- function() {
  png(filename = "plot1.png", width = 480, height = 480, units = "px")
  hist(tidy_data$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
  dev.off()
}
plot1()
