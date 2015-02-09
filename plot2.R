
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

    png(file = "./ExData_Plotting1/plot2.png")

## Create Plot

    plot(data$Global_active_power ~ data$DateTime, ty = "l", xlab = "Time",
         ylab = "Global Active Power (kilowatts)")

## Close file

    dev.off()