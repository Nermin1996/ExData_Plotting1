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

# constructing plot 2
png(filename = "plot2.png",width = 480, height = 480, units = "px", pointsize = 12, bg = "white" )
plot(final$Global_active_power,xaxt="n", type="l", ylab = "Global Active Power (Kilowatts)", xlab = "")
axis(1,at=1,labels= "Thu")
axis(1, at=1441, labels = "Fri")
axis(1, at=2881, labels= "Sat")
graphics.off()