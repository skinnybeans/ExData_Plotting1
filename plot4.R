## read in data only between the dates we are interested in
powerdata <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),
                        sep = ';',
                        stringsAsFactors = FALSE)

## set column names
names(powerdata) <- c("Date","Time","Global_active_power",
                      "Global_reactive_power","Voltage","Global_intensity",
                      "Sub_metering_1","Sub_metering_2","Sub_metering_3")

## convert numeric data that will be graphed
powerdata$Sub_metering_1 <- as.numeric(powerdata$Sub_metering_1)
powerdata$Sub_metering_2 <- as.numeric(powerdata$Sub_metering_2)
powerdata$Sub_metering_3 <- as.numeric(powerdata$Sub_metering_3)

powerdata$Voltage <- as.numeric(powerdata$Voltage)
powerdata$Global_active_power <- as.numeric(powerdata$Global_active_power)
powerdata$Global_reactive_power <- as.numeric(powerdata$Global_reactive_power)

## combine the time and date fields
powerdata$DateTime <- paste(powerdata$Date, powerdata$Time)

## convert value to a date time
powerdata$DateTime <- strptime(powerdata$DateTime, format="%d/%m/%Y %H:%M:%S")

## open graphics device
png(filename = "plot4.png",
    width = 480,
    height = 480)

## 2 x 2 graph placement on canvas
par(mfrow = c(2,2))

## first graph
## DateTime + Global Active Power
plot(powerdata$DateTime, 
     powerdata$Global_active_power,
     xlab = "",
     ylab = "Global Active Power",
     type = 'l',
     col = 'black')

## second graph
## DateTime + Voltage
plot(powerdata$DateTime, 
     powerdata$Voltage,
     xlab = "datetime",
     ylab = "Voltage",
     type = 'l',
     col = 'black')

## third graph
## DateTime + sub metering
plot(powerdata$DateTime,
     powerdata$Sub_metering_1,
     type = 'l',
     xlab = "",
     ylab = "Energy Sub Metering",
     col = 'black')

## add the other series to the plot
par(col = 'red')
lines(powerdata$DateTime ,powerdata$Sub_metering_2)
par(col = 'blue')
lines(powerdata$DateTime ,powerdata$Sub_metering_3)
par(col = 'black')
## add legend to plot
legend("topright", 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c('black', 'red', 'blue'),
       lty = c(1,1),
       lwd = c(2.5,2.5))

## fourth graph
## DateTime + Global reactive power
plot(powerdata$DateTime, 
     powerdata$Global_reactive_power,
     xlab = "datetime",
     ylab = "Global_reactive_power",
     type = 'l',
     col = 'black')

## close graphics device
dev.off()