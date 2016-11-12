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
with(subPCData, plot(DateTime, Global_active_power,type = "l",ylab = "Global Active Power (kilowatts)",xlab=""))
#copy into a png file
dev.copy(png,file="plot2.png",width=480,height=480)
dev.off()
