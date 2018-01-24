#--------------------------------------------------
# data preparation

# load libs
library(data.table)

if (!exists("dataset")){
    # read all data from file
    data_all <- fread("household_power_consumption.txt", sep = ";", na.strings = c("?"))
    
    # filter data
    dataset <- subset(data_all, Date == "1/2/2007" | Date == "2/2/2007")
    rm(data_all)
    
    # combine date and time column
    date_time <- paste(dataset$Date, dataset$Time, sep = " ")
    
    #convert datetime
    dataset$DateTime <- as.POSIXct(date_time, format = "%d/%m/%Y %H:%M:%S", tz = "")
}


#--------------------------------------------------
# plotting

png("plot3.png",width = 480, height = 480, units = "px")

#global params
par(bg=NA)
Sys.setlocale("LC_ALL","English")


plot(dataset$DateTime,
     dataset$Sub_metering_1,
     type = "l",
     xlab = NA,
     ylab = "Energy sub metering"
     )
lines(dataset$DateTime, dataset$Sub_metering_2, col = "red")
lines(dataset$DateTime, dataset$Sub_metering_3, col = "blue")

legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1,
       col = c("black", "red", "blue"))

dev.off()

