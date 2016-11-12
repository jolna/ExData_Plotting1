#read all data
allPCData <- read.csv("./household_power_consumption.txt",header = TRUE,sep=";", stringsAsFactors = FALSE,na.strings = "?")
#convert Date column to Date object
allPCData$Date <- as.Date(allPCData$Date,"%d/%m/%Y")
#select only a subset of rows from the big data set
subPCData <- subset(allPCData, Date >= "2007-02-01" & Date <= "2007-02-02")
#remove the bigdata object to free up memory
rm(allPCData)
#concatenate the Date and Time to build a datetime object column
dateTime <- paste(subPCData$Date,subPCData$Time)
subPCData$DateTime <- as.POSIXct(dateTime)
#plot the chart
#adjust global par settings
par(mfcol=c(2,2),mar=c(4,4,2,1), oma=c(0,0,2,0))

with(subPCData, plot(Global_active_power ~ DateTime,type = "l",ylab = "Global Active Power (kilowatts)",xlab=""))

with(subPCData, plot(Sub_metering_1 ~ DateTime,type = "l",ylab = "Energy Sub metering",xlab=""))
with(subPCData, lines(Sub_metering_2 ~ DateTime,col="red"))
with(subPCData, lines(Sub_metering_3 ~ DateTime,col="blue"))
legend("topright",col=c("black","red","blue"),lty=1,lwd=2, bty="n",cex=0.5,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

with(subPCData, plot(Voltage ~ DateTime,type = "l",ylab = "Voltage",xlab="datetime"))
with(subPCData, plot(Global_reactive_power ~ DateTime,type = "l",xlab="datetime"))

#copy to a png file
dev.copy(png,file="plot4.png",width=600,height=480)
dev.off()
