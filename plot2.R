
sample<-read.table("household_power_consumption.txt",sep=';',header=TRUE,skip=66636,nrows=2880,na.strings=c("?"))
n<-names(read.table("household_power_consumption.txt",sep=';',header=TRUE,nrows=1))
colnames(sample)<-n

# We only require data from two dates
sample <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

# Create a new column with the combined date and time
x<-function(x1, x2){as.POSIXct(paste(x1, x2), format = "%d/%m/%Y %H:%M:%S")}
sample$datetime <- mapply(x,sample$Date,sample$Time)


png("plot2.png")
plot(sample$datetime, sample$Global_active_power, type="l", xaxt = "n",
     ylab = "Global Active Power (kilowatts)", xlab = "")
axis.POSIXct(1, as.POSIXct(sample$datetime, origin="1970-01-01"))
dev.off()