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

# constructing plot 1
png(filename = "plot1.png",width = 480, height = 480, units = "px", pointsize = 12, bg = "white" )
par(mfrow= c(1,1))
hist(final$Global_active_power, xlab = "Global Active Power (Kilowatts)", ylab = "Frequency", main= "Global Active Power", col = "Red")
graphics.off()


