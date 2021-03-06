#Download and unzip data
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="project_ExData.zip")
unzip("project_ExData.zip")

# Read file into file
EPC<-read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?",
                colClasses =c("character", "character", "numeric", "numeric", "numeric", "numeric",
                              "numeric", "numeric", "numeric"))

#Date/Time and Date
EPC$Time<-strptime(paste(EPC$Date, EPC$Time), "%d/%m/%Y %H:%M:%S") #Convert Time into Date/Time
names(EPC)[2] <- "DateTime" #Rename column
EPC$Date<-as.Date(EPC$Date, "%d/%m/%Y") #Convert character to Date

#Subset data
EPC_adjusted<-subset(EPC, Date >= as.Date("2007-02-01"))
EPC_adjusted<-subset(EPC_adjusted, Date <= as.Date("2007-02-02"))

#Plot
png(file="plot1.png", width=480, height=480)
hist(EPC_adjusted$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()