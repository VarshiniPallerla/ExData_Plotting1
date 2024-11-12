library(data.table)

data <- fread("household_power_consumption.txt", na.strings = "?")

data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

data_filtered <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02", ]

data_filtered$Sub_metering_1 <- as.numeric(data_filtered$Sub_metering_1)
data_filtered$Sub_metering_2 <- as.numeric(data_filtered$Sub_metering_2)
data_filtered$Sub_metering_3 <- as.numeric(data_filtered$Sub_metering_3)

png("plot3.png", width = 480, height = 480)
plot(data_filtered$DateTime, data_filtered$Sub_metering_1, type = "l", col = "black", 
     xlab = "", ylab = "Energy sub metering", main = "Energy Sub Metering over Time")
lines(data_filtered$DateTime, data_filtered$Sub_metering_2, col = "red")
lines(data_filtered$DateTime, data_filtered$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1)
dev.off()

