## This script is used for the third plot of 
## Course Project assignment 1: exploratory data analysis
## The assumptions for using this script:
## 1. The raw data file had already been downloaded into the current working directory

        library(dplyr)
        ## Read raw data
        data_set <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
        
        ## Data cleansing
        ## 1. Filter out those observations between [2007-02-01, 2007-02-02]
        ## 2. Change the type of Global_active_power from character to numeric
        ## 3. Paste the value of Date and Time with seperator as one space, change the type from charactor to POSIXlt. The results
        ##    are put into the new created column named as "DateTime"
        ## 4. Select columns DateTime, Sub_metering_1, Sub_metering_2 and Sub_metering_3 to be the final data set which will be used 
        ##    for plotting
        data_set <- filter(data_set, as.Date(data_set[, 1], "%d/%m/%Y") >= "2007-02-01"&as.Date(data_set[, 1], "%d/%m/%Y") <= "2007-02-02")
        data_set[, 7:8] <- apply(data_set[, 7:8], 2, as.numeric)
        data_set$DateTime <- strptime(paste(data_set$Date, data_set$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")
        data_set <- select(data_set, DateTime, Sub_metering_1, Sub_metering_2, Sub_metering_3)

        ## Plotting
        plot(data_set$DateTime, data_set$Sub_metering_1, col = "black", type ="l", xlab ="", ylab = "Energy sub metering")
        lines(data_set$DateTime, data_set$Sub_metering_2, col = "red")
        lines(data_set$DateTime, data_set$Sub_metering_3, col = "blue")
        legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
        ## Copy the plot to a PNG file
        dev.copy(png, file = "plot3.png")
        ## Don't foget to close the PNG device
        dev.off()