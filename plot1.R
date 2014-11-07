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
EPC$Global_active_power<-as.numeric(EPC$Global_active_power)

#Plot and save to png
png("plot1.png", width=480, height=480)

hist(EPC$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)",
     ylab="Frequency", col="red1")

dev.off()