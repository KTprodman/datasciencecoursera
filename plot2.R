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

#Convert colums
EPC$Date <- as.Date(EPC$Date, format="%d/%m/%Y")
EPC$DateTime <- paste(EPC$Date," ", EPC$Time)
EPC$DateTime <- strptime(EPC$DateTime, format="%Y-%m-%d %H:%M:%S")
#Change locale
Sys.setlocale("LC_TIME", "English")

#Plot and save to png
png("plot2.png", width=480, height=480)
plot(EPC$DateTime, EPC$Global_active_power, type="l", xlab="", ylab="Global Active Power (Kilowatts)")
dev.off()