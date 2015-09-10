
## read in data only between the dates we are interested in
powerdata <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),
         sep = ';',
         stringsAsFactors = FALSE)

## set column names
names(powerdata) <- c("Date","Time","Global_active_power",
                       "Global_reactive_power","Voltage","Global_intensity",
                       "Sub_metering_1","Sub_metering_2","Sub_metering_3")

## convert the date column to an actual date
powerdata$Date <- as.Date(powerdata$Date, format = '%d/%m/%Y')

## convert data to be plotted to numeric
powerdata$Global_active_power <- as.numeric(powerdata$Global_active_power)

## open graphics device
png(filename = "plot1.png",
    width = 480,
    height = 480)

## draw the histogram
hist(powerdata$Global_active_power, 
     ylab = 'Frequency',
     xlab = 'Global Active Power (kilowatts)',
     main = 'Global Active Power',
     col = 'red')

## close graphics device
dev.off()