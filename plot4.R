## This script is used for the forth plot of 
## Course Project assignment 1: exploratory data analysis
## The assumptions for using this script:
## 1. The raw data file had already been downloaded into the current working directory

        library(dplyr)
        ## Read raw data
        data_set <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
        
        ## Data cleansing
        ## 1. Filter out those observations between [2007-02-01, 2007-02-02]
        ## 2. Change the data type for all the measurements from charater to numberic
        ##    Those measurements are Global_active_power, Global_reactive_power, Voltage, Global_intensity,
        ##    Sub_metering_1, Sub_metering_2, Sub_metering_3
        ## 3. Paste the value of Date and Time with seperator as one space, change the type from charactor to POSIXlt. The results
        ##    are put into the new created column named as "DateTime"
        ## 4. Selected the required varaibles needed by plot4, they are: DateTime, Global_active_power, Global_reactive_power,
        ##    Voltage, Sub_metering_1, Sub_metering_2, Sub_metering_3
        data_set <- filter(data_set, as.Date(data_set[, 1], "%d/%m/%Y") >= "2007-02-01"&as.Date(data_set[, 1], "%d/%m/%Y") <= "2007-02-02")
        data_set[, 3:8] <- apply(data_set[, 3:8], 2, as.numeric)
        data_set$DateTime <- strptime(paste(data_set$Date, data_set$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")
        data_set <- select(data_set, DateTime, 3:5, 7:9)
        
        ## Plotting
        ### 1. Set the plotting into that style: 4 plotting in one graphic device, arranged into 2 row 2 column in the plotting area
        par (mfcol = c(2, 2))
        
        ### 2. Plot 1: x = DataTime, y = Global_active_power
        with(data_set, plot(DateTime, Global_active_power, type ="l", xlab = "", ylab = "Global Active Power"))
        
        ### 3. Plot 2: x = DateTime, y = Sub_metering_1, Sub_metering_2, Sub_metering_3
        plot(data_set$DateTime, data_set$Sub_metering_1, col = "black", type ="l", xlab ="", ylab = "Energy sub metering")
        lines(data_set$DateTime, data_set$Sub_metering_2, col = "red")
        lines(data_set$DateTime, data_set$Sub_metering_3, col = "blue")
        legend("topright", cex = 0.5, lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
        ### 4. Plot 3: x = DateTime, y = Voltage
        plot(data_set$DateTime, data_set$Voltage, col = "black", type ="l", xlab ="datetime", ylab = "Voltage")
        
        ### 5. Plot 4: x = DateTime, y = Global_reactive_power
        plot(data_set$DateTime, data_set$Global_reactive_power, col = "black", type ="l", xlab ="datetime", ylab = "Global_reactive_power")
        
        ## Copy the plot to a PNG file
        dev.copy(png, file = "plot4.png")
        ## Don't foget to close the PNG device
        dev.off()