## plot4.R
library("data.table")

setwd("/Users/mfunke/Downloads/")

data=fread("household_power_consumption.txt", colClasses="character")
startdate=as.Date("2007-02-01")
enddate=as.Date("2007-02-02")

## Convert all dates to proper Date
data[,Date2:=as.Date(Date, format="%d/%m/%Y")]

## Filter only the values of the two days in question
data = data[Date2 >= startdate & Date2 <= enddate,]
## Convert to numeric
data = data[, gap:=as.numeric(Global_active_power)]
data = data[, Voltage:=as.numeric(Voltage)]
## Generate POSIXct, i.e. date and time in one variable
data = data[, datetime:=as.POSIXct(strptime(paste(Date, Time, sep=" "), format="%d/%m/%Y %H:%M:%S"))]
## Open the PNG file and plot
png(file="plot4.png")
par(mfrow=c(2,2))
## The first plot is like Plot2
plot(data$datetime, data$gap, type="l", ylab="Global Active Power (kilowatts)", xlab="")
## The second plot is similar, just another variable
with(data, plot(datetime, Voltage, type="l"))
## The third plot corresponds to Plot3
with(data, plot(datetime, Sub_metering_1, type="n", ylab="Energy sub metering", xlab=""))
with(data, lines(datetime, Sub_metering_1, col="black"))
with(data, lines(datetime, Sub_metering_2, col="red"))
with(data, lines(datetime, Sub_metering_3, col="blue"))
with(data, legend(x="topright", "Sub_metering_1", lty=1, bty="n"))
## right-justifying a set of labels: thanks to Uwe Ligges
temp <- legend("topright", legend = c(" ", " ", " "),
               text.width = strwidth("Sub_metering_X"),
               lty = 1, xjust = 1, yjust = 1, col=c("black", "red", "blue"))
text(temp$rect$left + temp$rect$w, temp$text$y,
     c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pos = 2)
## The fourth one is another variable
with(data, plot(datetime, Global_reactive_power, type="l"))
dev.off()
