library(dplyr)
library(lubridate)

powerdata <- read.table("./data/household_power_consumption.txt", header = TRUE, 
                        sep = ";", nrows = 600000)

power <-
        powerdata %>%
        filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
        mutate(Date = dmy(Date))
power$DateTime <- paste(power$Date, power$Time, sep = " ")
power$DateTime <- strptime(power$DateTime, format = "%Y-%m-%d %H:%M:%S")

png(file = "plot4.png")

par(mfrow = c(2,2))

#Top-left graph
plot(power$DateTime, power$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power")

#Top-right graph
plot(power$DateTime, power$Voltage, type = "l", xlab = "datetime", 
     ylab = "Voltage")

#Bottom-left graph
plot(power$DateTime, power$Sub_metering_1, type = "l", xlab = "", 
     ylab = "Energy sub metering")
lines(power$DateTime, power$Sub_metering_2, col = "red")
lines(power$DateTime, power$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), cex = 1, bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), lty = 1,
       y.intersp = 1)

#Bottom-right graph
plot(power$DateTime, power$Global_reactive_power, xlab = "datetime", 
     ylab = "Global_reactive_power", type = "l")

dev.off()