sample<-read.table("household_power_consumption.txt",sep=';',header=TRUE,skip=66636,nrows=2880)
n<-names(read.table("household_power_consumption.txt",sep=';',header=TRUE,nrows=1))
colnames(sample)<-n
png(file = paste(getwd(),"/plot1.png",sep=""),width=480,height=480,units="px")
hist(sample$Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)",ylab="Frequency",col="red")
dev.off()