## Read Data

    library(data.table)
    
    data <- fread("household_power_consumption.txt", header = T, sep = ";", 
                  colClasses = c("character"), na.strings = "?")

## Subsetting

    data <- data[data$Date %in% c("1/2/2007", "2/2/2007")]

## Reformatting

    data$DateTime <- paste(data$Date, data$Time)
    
    data <- as.data.frame(data)
    
    data$Date <- as.Date(data$Date, "%d/%m/%Y")
    
    data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")
    
    data$DateTime <- as.POSIXct(data$DateTime)
    
    for (i in 3:9) {
        
        data[, i] <- as.numeric(data[, i])
        
    }

## Create pgn file

    png(file = "./ExData_Plotting1/plot4.png")

## Create Plot
    
    par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
    
    with(data, {
        
        plot(data$Global_active_power ~ data$DateTime, ty = "l", 
             xlab = "dateTime", ylab = "Global Active Power (kilowatts)")
        
        plot(data$Voltage ~ data$DateTime, ty = "l", xlab = "dateTime",
             ylab = "Voltage")
        
        plot(data$Sub_metering_1 ~ data$DateTime, ty = "l", xlab = "datetime",
             ylab = "Energy sub metering")
        
        points(data$Sub_metering_2 ~ data$DateTime, ty = "l", col = "red")
        
        points(data$Sub_metering_3 ~ data$DateTime, ty = "l", col = "blue")
        
        legend("topright", lty = 1, col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
        plot(data$Global_reactive_power ~ data$DateTime, ty = "l", 
             xlab = "dateTime", ylab = "Global Reactive Power (kilowatts)")
        
    })
    
## Close file

    dev.off()