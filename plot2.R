library(data.table)

data <- fread("household_power_consumption.txt", na.strings = "?")

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data_filtered <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02", ]
data_filtered$Datetime <- as.POSIXct(paste(data_filtered$Date, data_filtered$Time))

data_filtered$Global_active_power <- as.numeric(data_filtered$Global_active_power)

png("plot2.png", width = 480, height = 480)
plot(data_filtered$Datetime, data_filtered$Global_active_power, 
     type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
