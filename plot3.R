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

# constructing plot 3
png(filename = "plot3.png",width = 480, height = 480, units = "px", pointsize = 12, bg = "white" )
plot(final$Sub_metering_1, type="l", ylab = "Energy Sub metering", xlab = "", col="Black")
lines(final$Sub_metering_2, col="Red")
lines(final$Sub_metering_3, col="Blue")
leg.txt <- c("sub_metering_1", "sub_metering_2", "sub_metering_3")
legend("topright", leg.txt, col = c("Black", "Red", "Blue"), lty= 1, cex = 1 )
graphics.off()