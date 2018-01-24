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
if (dev.cur()[1] > 1){
    dev.off()
}

#global params
par(bg=NA)

hist(dataset$Global_active_power, 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", 
     col = "red",
     main = "Global Active Power")

dev.copy(png, "plot1.png",width = 480, height = 480, units = "px") 
dev.off()

