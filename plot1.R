#read all data
allPCData <- read.csv("./household_power_consumption.txt",header = TRUE,sep=";", stringsAsFactors = FALSE,na.strings = "?")
#convert Date column to Date object
allPCData$Date <- as.Date(allPCData$Date,"%d/%m/%Y")
#select only a subset of rows from the big data set
subPCData <- subset(allPCData, Date >= "2007-02-01" & Date <= "2007-02-02")
#remove the bigdata object to free up memory
rm(allPCData)
#histogram
hist(subPCData$Global_active_power,main="Global Active Power",xlab = "Global Active Power (kilowatts)", ylab = "Frequency",col = "red")
#copy into a png file
dev.copy(png,file="plot1.png",width=480,height=480)
dev.off()
