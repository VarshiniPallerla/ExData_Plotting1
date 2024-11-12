install.packages("data.table")

library(data.table)

data <- fread("household_power_consumption.txt", na.strings = "?")

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

data_filtered <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02"]

data_filtered$Global_active_power <- as.numeric(data_filtered$Global_active_power)

# Create Plot 1 and save it as a PNG file
png("plot1.png", width = 480, height = 480)
hist(data_filtered$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     col = "red")
dev.off()
