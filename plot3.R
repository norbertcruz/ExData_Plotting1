
plot3 <- function() {

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

    png(file = "./ExData_Plotting1/plot3.png", width = 480, height = 480)

## Create Plot

    plot(data$Sub_metering_1 ~ data$DateTime, ty = "l", xlab = "",
         ylab = "Energy sub metering")
    
    points(data$Sub_metering_2 ~ data$DateTime, ty = "l", col = "red")
    
    points(data$Sub_metering_3 ~ data$DateTime, ty = "l", col = "blue")
    
    legend("topright", lty = 1, col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Close file

    dev.off()

}