library(sqldf)
library(lubridate)
today = as.Date(Sys.time())
#fetch zip data
exdata<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(exdata, destfile = "./exdata.zip", method = "curl")
#unzip it
unzip("exdata.zip")
#read data where the date is between 2007-02-01 and 2007-02-02
initial_data <- read.csv.sql("household_power_consumption.txt", sep = ';', sql = "select * from file
                             where Date = '1/2/2007' OR Date ='2/2/2007'")
##Create a new column with exact timepoint
initial_data$Timepoint <- paste(initial_data$Date, initial_data$Time)
##convert it to date/time object
initial_data$Timepoint<-dmy_hms(initial_data$Timepoint)

#create png file 
png(filename = "plot3.png",
    width = 480, height = 480)
#write plot
plot(initial_data$Timepoint, initial_data$Sub_metering_1, type = "l", col= "black", 
     xlab='', ylab='Energy sub metering')
lines(initial_data$Timepoint, initial_data$Sub_metering_2, type = "l", col= "red")
lines(initial_data$Timepoint, initial_data$Sub_metering_3, type = "l", col= "blue")
legend("topright", lwd = 2, col = c("black","red", "blue"),
       legend= c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))


dev.off()
