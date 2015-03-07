# Filter out data from file with dates 01-Feb-2007 and 02-02-2007
sample<-read.table("household_power_consumption.txt",sep=';',header=TRUE,skip=66636,nrows=2880,na.strings=c("?"))
n<-names(read.table("household_power_consumption.txt",sep=';',header=TRUE,nrows=1))
colnames(sample)<-n

# Create a new column with the combined date and time
x<-function(x1, x2){as.POSIXct(paste(x1, x2), format = "%d/%m/%Y %H:%M:%S")}
sample$datetime <- mapply(x,sample$Date,sample$Time)

png(file = paste(getwd(),"/plot4.png",sep=""),width=480,height=480,units="px")
par(mfrow = c(2,2))

plot(sample$datetime, sample$Global_active_power, type="l", xaxt = "n",
     ylab = "Global Active Power", xlab = "")
axis.POSIXct(1, as.POSIXct(sample$datetime, origin="1970-01-01"))

plot(sample$datetime, sample$Voltage, type="l", xaxt = "n",
     ylab = "Voltage", xlab = "datetime")
axis.POSIXct(1, as.POSIXct(sample$datetime, origin="1970-01-01"))

plot(sample$datetime, sample$Sub_metering_1, type="l", xaxt = "n",
     ylab = "Energy sub metering", xlab = "")
lines(sample$datetime, sample$Sub_metering_2, col = "red")
lines(sample$datetime, sample$Sub_metering_3, col = "blue")
axis.POSIXct(1, as.POSIXct(sample$datetime, origin="1970-01-01"))
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")

plot(sample$datetime, sample$Global_reactive_power, type="l", xaxt = "n",
     ylab = "Global_reactive_power", xlab = "datetime")
axis.POSIXct(1, as.POSIXct(sample$datetime, origin="1970-01-01"))
dev.off()