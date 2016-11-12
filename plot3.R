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

with(subPCData, plot(Sub_metering_1 ~ DateTime,type = "l",ylab = "Energy Sub metering",xlab=""))
with(subPCData, lines(Sub_metering_2 ~ DateTime,col="red"))
with(subPCData, lines(Sub_metering_3 ~ DateTime,col="blue"))
legend("topright",col=c("black","red","blue"),lty=1,lwd=2,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#copy into a png file
dev.copy(png,file="plot3.png",width=600,height=480)
dev.off()
