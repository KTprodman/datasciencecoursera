# Create temporary file, download .zip file, unzip and load in memory
filename <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(filename,temp)
con <- unz(temp, "household_power_consumption.txt")
EPCall<-read.csv(con, sep=";", header=TRUE, stringsAsFactors=FALSE)
unlink(temp)

# Subset to 2 days
EPC <- EPCall[EPCall$Date=="1/2/2007" | EPCall$Date=="2/2/2007", ]
rm(EPCall)

#Convert columns
EPC$Date <- as.Date(EPC$Date, format="%d/%m/%Y")
EPC$DateTime <- paste(EPC$Date," ", EPC$Time)
EPC$DateTime <- strptime(EPC$DateTime, format="%Y-%m-%d %H:%M:%S")
EPC$Sub_metering_1 <- as.numeric(EPC$Sub_metering_1)
EPC$Sub_metering_2 <- as.numeric(EPC$Sub_metering_2)
EPC$Sub_metering_3 <- as.numeric(EPC$Sub_metering_3)

#Change locale
Sys.setlocale("LC_TIME", "English")

#plot and save
png("plot3.png", width=480, height=480)
with(EPC, plot(DateTime, Sub_metering_1,type="l", ylim=c(0,40), 
               col="black", xlab="", ylab="Energy sub metering", yaxt='n'))
with(EPC, lines(DateTime, Sub_metering_2, type="l", ylim=c(0,40), 
                col="red", xlab="", ylab="Energy sub metering", yaxt='n'))
with(EPC, lines(DateTime, type="l", Sub_metering_3, ylim=c(0,40), 
                col="blue", xlab="", ylab="Energy sub metering", yaxt='n'))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, col=c("black", "red", "blue"))
axis(side=2, at=c(0, 10, 20, 30))

dev.off()