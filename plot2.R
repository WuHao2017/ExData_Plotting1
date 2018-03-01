## This script is used for the second plot of 
## Course Project assignment 1: exploratory data analysis
## The assumptions for using this script:
## 1. The raw data file had already been downloaded into the current working directory

        library(dplyr)
        ## Read raw data
        data_set <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

        ## Data cleansing
        ## 1. Select columns named as Date, Time and Global_active_power
        ## 2. Filter out those observations between [2007-02-01, 2007-02-02]
        ## 3. Paste the value of Date and Time with seperator as one space, change the type from charactor to POSIXlt. The results
        ##    are put into the new created column named as "DateTime"
        ## 4. Change the type of Global_active_power from character to numeric
        ## 5. Select columns DateTime and Global_active_power to be the final data set which will be used for plotting
        data_set <- select(data_set, Date, Time, Global_active_power) %>%
                    filter(as.Date(data_set[, 1], "%d/%m/%Y") >= "2007-02-01"&as.Date(data_set[, 1], "%d/%m/%Y") <= "2007-02-02")
        
        data_set$DateTime <- strptime(paste(data_set$Date, data_set$Time, sep = " "), format = "%d/%m/%Y %H:%M:%S")
        data_set[, 3] <- as.numeric(data_set[, 3])
                    
        data_set <- select(data_set, DateTime, Global_active_power)
        
        ## Plotting
        with(data_set, plot(DateTime, Global_active_power, type ="l", xlab = "", ylab = "Global Active Power (kilowatts)"))
        
        ## Copy the plot to a PNG file
        dev.copy(png, file = "plot2.png")
        ## Don't foget to close the PNG device
        dev.off()