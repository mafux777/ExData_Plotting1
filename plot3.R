## plot3.R
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
png(file="plot3.png")
data[, plot(datetime, Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")]
data[, lines(datetime, Sub_metering_1, col="black")]
data[, lines(datetime, Sub_metering_2, col="red")]
data[, lines(datetime, Sub_metering_3, col="blue")]
data[, legend(x="topright", "Sub_metering_1", lty=1)]
## right-justifying a set of labels: thanks to Uwe Ligges
temp <- legend("topright", legend = c(" ", " ", " "),
               text.width = strwidth("Sub_metering_X"),
               lty = 1, xjust = 1, yjust = 1, col=c("black", "red", "blue"))
text(temp$rect$left + temp$rect$w, temp$text$y,
     c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pos = 2)
dev.off()
