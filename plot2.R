library(dplyr)
library(lubridate)

powerdata <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", 
                        nrows = 600000)

power <-
        powerdata %>%
        filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
        mutate(Date = dmy(Date))
power$DateTime <- paste(power$Date, power$Time, sep = " ")
power$DateTime <- strptime(power$DateTime, format = "%Y-%m-%d %H:%M:%S")

png(file = "plot2.png")
plot(power$DateTime, power$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")
dev.off()