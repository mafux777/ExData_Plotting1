## plot2.R
library("data.table")

setwd("/Users/mfunke/Downloads/")

data=fread("household_power_consumption.txt", colClasses="character")
startdate=as.Date("2007-02-01")
enddate=as.Date("2007-02-02")

## Convert all dates to proper Date
data[,Date2:=as.Date(Date, format="%d/%m/%Y")]

## Filter only the values and keep the interesting columns
data = data[Date2 >= startdate & Date2 <= enddate]

## Generate POSIXct, i.e. date and time in one variable
data[, datetime:=as.POSIXct(strptime(paste(Date, Time, sep=" "), format="%d/%m/%Y %H:%M:%S"))]
## Open the PNG file and plot
png(file="plot2.png")
data[,plot(datetime, Global_active_power, 
                type="l", ylab="Global Active Power (kilowatts)", xlab="")]
dev.off()
