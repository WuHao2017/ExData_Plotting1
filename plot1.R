## This script is used for the first plot of 
## Course Project assignment 1: exploratory data analysis
## The assumptions for use this script:
## 1. The raw data file had already been downloaded into the current working directory

        library(dplyr)
        ## Read raw data
        data_set <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
        data_set[, 3:8] <- apply(data_set[, 3:8], 2, as.numeric)
        data_set[, 1] <- as.Date(data_set[, 1], "%d/%m/%Y")
        
        ## Data cleansing
        data_set <- select(data_set, Date, Global_active_power) %>%
                    filter(Date >= "2007-02-01"&Date <= "2007-02-02")
        
        ## Plotting
        hist(data_set[, 2], col = "red", ylim = c(0, 1200), main = "Global Active Power", xlab = "Global Active Power(kilowatts)")
        
        ## Copy the plot to a PNG file
        dev.copy(png, file = "plot1.png")
        ## Don't foget to close the PNG device
        dev.off()