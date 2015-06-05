##Set to English
Sys.setlocale("LC_TIME", "English")

##Download and unzip file
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="project_ExData.zip")
unzip("project_ExData.zip")

##Read file into variables
EPC<-read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?",
                colClasses =c("character", "character", "numeric", "numeric", "numeric", "numeric",
                              "numeric", "numeric", "numeric"))

##Date/Time and Date
EPC$Time<-strptime(paste(EPC$Date, EPC$Time), "%d/%m/%Y %H:%M:%S") #Convert Time into Date/Time
names(EPC)[2] <- "DateTime" #Rename column
EPC$Date<-as.Date(EPC$Date, "%d/%m/%Y") #Convert character to Date

##Subset data
EPC_adjusted<-subset(EPC, Date >= as.Date("2007-02-01"))
EPC_adjusted<-subset(EPC_adjusted, Date <= as.Date("2007-02-02"))

##Plot
png(file="plot4.png", width=480, height=480)

par(mfrow=c(2,2)) #multiple plots (2 rows and 2 columns)

#Plot(1,1)
plot(EPC_adjusted$DateTime, EPC_adjusted$Global_active_power, type="l", xlab="", ylab="Global Active Power")

#Plot(1,2)
plot(EPC_adjusted$DateTime, EPC_adjusted$Voltage, type="l", xlab="datetime", ylab="Voltage")

#Plot(2,1)
plot(EPC_adjusted$DateTime, EPC_adjusted$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(EPC_adjusted$DateTime, EPC_adjusted$Sub_metering_2, col="red")
lines(EPC_adjusted$DateTime, EPC_adjusted$Sub_metering_3, col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=1, col=c("black","red","blue"), bty="n")

#Plot(2,2)
plot(EPC_adjusted$DateTime, EPC_adjusted$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()