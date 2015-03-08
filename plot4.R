
plot4 <- function() {

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

    png(file = "./ExData_Plotting1/plot4.png", width = 480, height = 480)

## Create Plot
    
    par(mfrow = c(2, 2), mar = c(5, 4, 5, 3.5), oma = c(0, 0, 0, 0))
    
    with(data, {
        
        plot(data$Global_active_power ~ data$DateTime, ty = "l", 
             xlab = "", ylab = "Global Active Power")
        
        plot(data$Voltage ~ data$DateTime, ty = "l", xlab = "datetime",
             ylab = "Voltage")
        
        plot(data$Sub_metering_1 ~ data$DateTime, ty = "l", xlab = "",
             ylab = "Energy sub metering")
        
            points(data$Sub_metering_2 ~ data$DateTime, ty = "l", col = "red")
        
            points(data$Sub_metering_3 ~ data$DateTime, ty = "l", col = "blue")
        
            legend("topright", lty = 1, bty = "n" , col = c("black", "red", 
                "blue"), legend = c("Sub_metering_1", "Sub_metering_2", 
                "Sub_metering_3"))
        
        plot(data$Global_reactive_power ~ data$DateTime, ty = "l", 
             xlab = "datetime", ylab = "Global_reactive _power")
        
    })
    
## Close file

    dev.off()

}