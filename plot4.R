
sample<-read.table("household_power_consumption.txt",sep=';',header=TRUE,skip=66636,nrows=2880,na.strings=c("?"))
n<-names(read.table("household_power_consumption.txt",sep=';',header=TRUE,nrows=1))
colnames(sample)<-n

# We only require data from two dates
sample <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

# Create a new column with the combined date and time
x<-function(x1, x2){as.POSIXct(paste(x1, x2), format = "%d/%m/%Y %H:%M:%S")}
sample$datetime <- mapply(x,sample$Date,sample$Time)

png(file = paste(getwd(),"/plot4.png",sep=""),width=480,height=480,units="px")
plot(sample$datetime, sample$Sub_metering_1, type="l", xaxt = "n",
     ylab = "Energy sub metering", xlab = "")
lines(sample$datetime, sample$Sub_metering_2, col = "red")
lines(sample$datetime, sample$Sub_metering_3, col = "blue")
axis.POSIXct(1, as.POSIXct(sample$datetime, origin="1970-01-01"))
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()