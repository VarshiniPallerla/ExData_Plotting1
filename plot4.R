# Load necessary library
library(data.table)

# Load the data
data <- fread("household_power_consumption.txt", na.strings = "?")

# Convert the Date column to Date format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Filter the data for the dates 2007-02-01 and 2007-02-02
data_filtered <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02", ]

# Combine Date and Time into a single POSIXct datetime column
data_filtered$Datetime <- as.POSIXct(paste(data_filtered$Date, data_filtered$Time), 
                                     format = "%Y-%m-%d %H:%M:%S")

# Convert relevant columns to numeric (in case they are not)
data_filtered$Global_active_power <- as.numeric(data_filtered$Global_active_power)
data_filtered$Voltage <- as.numeric(data_filtered$Voltage)
data_filtered$Sub_metering_1 <- as.numeric(data_filtered$Sub_metering_1)
data_filtered$Sub_metering_2 <- as.numeric(data_filtered$Sub_metering_2)
data_filtered$Sub_metering_3 <- as.numeric(data_filtered$Sub_metering_3)

# Create Plot 4 (4 subplots in a 2x2 layout)
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))  # Set layout for 2x2 grid

# Plot 1: Global Active Power
plot(data_filtered$Datetime, data_filtered$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)", col = "blue")

# Plot 2: Voltage
plot(data_filtered$Datetime, data_filtered$Voltage, type = "l", 
     xlab = "Datetime", ylab = "Voltage", col = "green")

# Plot 3: Sub-metering 1, 2, and 3
plot(data_filtered$Datetime, data_filtered$Sub_metering_1, type = "l", 
     xlab = "", ylab = "Energy Sub-metering", col = "black", 
     ylim = range(c(data_filtered$Sub_metering_1, data_filtered$Sub_metering_2, data_filtered$Sub_metering_3)))
lines(data_filtered$Datetime, data_filtered$Sub_metering_2, col = "red")
lines(data_filtered$Datetime, data_filtered$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1, bty = "n")

# Plot 4: Global Reactive Power
plot(data_filtered$Datetime, data_filtered$Global_reactive_power, type = "l", 
     xlab = "Datetime", ylab = "Global Reactive Power (kilowatts)", col = "purple")

dev.off()
