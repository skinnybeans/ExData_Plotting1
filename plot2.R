## read in data only between the dates we are interested in
powerdata <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),
                        sep = ';',
                        stringsAsFactors = FALSE)

## set column names
names(powerdata) <- c("Date","Time","Global_active_power",
                      "Global_reactive_power","Voltage","Global_intensity",
                      "Sub_metering_1","Sub_metering_2","Sub_metering_3")

## convert global_active_power to numeric
powerdata$Global_active_power <- as.numeric(powerdata$Global_active_power)

## combine the time and date fields
powerdata$DateTime <- paste(powerdata$Date, powerdata$Time)

## convert value to a date time
powerdata$DateTime <- strptime(powerdata$DateTime, format="%d/%m/%Y %H:%M:%S")

## open graphics device
png(filename = "plot2.png",
    width = 480,
    height = 480)

## draw the plot
plot(powerdata$DateTime,
     powerdata$Global_active_power,
     type = 'l',
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

## close graphics device
dev.off()