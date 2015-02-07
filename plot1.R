## plot1.R
library("data.table")

setwd("/Users/mfunke/Downloads/")

data=fread("household_power_consumption.txt", colClasses="character")
startdate=as.Date("2007-02-01")
enddate=as.Date("2007-02-02")

## Convert all dates to proper Date - is time required? Maybe can be simplified
data[,Date2:=as.Date(strptime(Date, format="%d/%m/%Y"))]

## Filter only the values for 1st and 2nd Feb 
data = data[Date2 >= startdate & Date2 <= enddate]

## Prepare the plot
png(file="plot1.png")
par(mfrow=c(1,1))
data[,plot(hist(as.numeric(Global_active_power)), 
           col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")]
dev.off()
