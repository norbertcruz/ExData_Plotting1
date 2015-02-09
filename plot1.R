    
## Read Data    

    library(data.table)
    
    data <- fread("household_power_consumption.txt", header = T, sep = ";", 
                  colClasses = c("character"), na.strings = "?")
    
## Subsetting
    
    data <- data[data$Date %in% c("1/2/2007", "2/2/2007")]

## Reformatting
    
    data <- as.data.frame(data)
    
    for (i in 3:9) {
        
        data[, i] <- as.numeric(data[, i])
        
    }
    
## Create pgn file
    
    png(file = "./ExData_Plotting1/plot1.png")
    
## Create Plot
    
    hist(data$Global_active_power, main = "Global Active Power", 
         xlab = "Global Active power (kilowatts)", col = "red")
    
## Close file
    
    dev.off()
