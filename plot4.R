# Downloading and unzipping the file
URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("exdata_data_household_power_consumption.zip")){
  download.file(URL, destfile = "exdata_data_household_power_consumption.zip")
}
if(file.exists("exdata_data_household_power_consumption.zip")){
  unzip("exdata_data_household_power_consumption.zip")
}

# loading the reqired packages
library(dplyr)
library(lattice)
library(grDevices)

# reading the text file into table
project <- read.csv("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE, na.strings = "?")
project$Date <- as.Date(project$Date, c("%d/%m/%Y"))
project <- arrange(project, Date)
final<- filter(project, Date == "2007-02-01" | Date == "2007-02-02")
final<- mutate(final, week.days = strftime(final$Date, "%A"))

# constructing plot 4
png(filename = "plot4.png",width = 480, height = 480, units = "px", pointsize = 12, bg = "white" )
par(mfrow= c(2,2), mar=c(5, 4, 1, 5))

# plot 4.1
plot(final$Global_active_power,xaxt="n", type="l", ylab = "Global Active Power (Kilowatts)", xlab = "")
axis(1,at=1,labels= "Thu")
axis(1, at=1441, labels = "Fri")
axis(1, at=2881, labels= "Sat")

#plot 4.2
plot(final$Voltage, xaxt="n", type = "l", ylab = "Voltage", xlab= "datetime", col= "Black")
axis(1,at=1,labels= "Thu")
axis(1, at=1441, labels = "Fri")
axis(1, at=2881, labels= "Sat")

#plot 4.3
plot(final$Sub_metering_1, type="l", ylab = "Energy Sub metering", xlab = "", col="Black")
lines(final$Sub_metering_2, col="Red")
lines(final$Sub_metering_3, col="Blue")
leg.txt <- c("sub_metering_1", "sub_metering_2", "sub_metering_3")
legend("topright", leg.txt, col = c("Black", "Red", "Blue"), lty= 1, cex = 0.8, bty = "n" )

#plot 4.4
plot(final$Global_reactive_power, xaxt="n", type="l", ylab = "Global_Reactive_Power", xlab = "datetime", col="Black")
axis(1,at=1,labels= "Thu")
axis(1, at=1441, labels = "Fri")
axis(1, at=2881, labels= "Sat")
graphics.off()

