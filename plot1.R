library(dplyr)
library(lubridate)

powerdata <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", 
                        nrows = 600000)

power <-
        powerdata %>%
        filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
        mutate(Date = dmy(Date))
power$Global_active_power <- as.numeric(as.character(power$Global_active_power))


png(file = "plot1.png")
hist(power$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")   
dev.off()
