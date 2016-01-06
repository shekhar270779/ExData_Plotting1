# Plot4.R code
# Below steps are performed already
# source file is downloaded on my computer
# in R, I have set current working directory to the location where my file is downloaded

# load package for fread to import the file in R
library(data.table)
data <- fread("household_power_consumption.txt", sep = ";" , 
		header = TRUE, stringsAsFactors = FALSE)

# Convert Date column to date class 
data$Date <- as.Date(data$Date,"%d/%m/%Y")

# Since in this assignment it is given to work on Feb 1st and 2nd data only
# subset and filter only records where Date is Feb 1 or Feb 2,2007

# We will work on feb_data
feb_data <- subset(data, Date =='2007-02-01' | Date == '2007-02-02')

# Since we have filtered records, so no need to keep original data in memory
rm(data)

# Add datetime as one additional column, after converting Date and Time into one column
feb_data$datetime <- as.POSIXct(paste(feb_data$Date, feb_data$Time), format="%Y-%m-%d %H:%M:%S")

# convert Global_active_power column into numeric
feb_data$Global_active_power <- as.numeric(feb_data$Global_active_power)

# convert Global_reactive_power column into numeric
feb_data$Global_reactive_power <- as.numeric(feb_data$Global_reactive_power)

# convert Sub_metering_n columns into numeric
feb_data$Sub_metering_1 <- as.numeric(feb_data$Sub_metering_1)
feb_data$Sub_metering_2 <- as.numeric(feb_data$Sub_metering_2)
feb_data$Sub_metering_3 <- as.numeric(feb_data$Sub_metering_3)

#convert voltage column to numeric
feb_data$Voltage = as.numeric(feb_data$Voltage)

# Initialise Graphic Device
png(filename = "plot4.png", width = 480, height = 480, units = "px")

#set par() , 4 graphs byrows
par(mfrow = c(2,2))

#plot first graph in (1,1) 
with(feb_data, plot(datetime, Global_active_power, type="l", 
                    xlab="", ylab="Global Active Power (kilowatts)"
			 )
     )

# Plot second graph in (1,2)
with(feb_data, plot(datetime, Voltage, type="l", ylab="Voltage"))


# Plot third graph in (2,1)
with(feb_data,  plot(datetime, Sub_metering_1, ylab="Energy Sub metering", xlab="", type="l"))
with(feb_data, lines(datetime, Sub_metering_2, type="l", col="red"))
with(feb_data, lines(datetime, Sub_metering_3, type="l", col="blue"))
legend("topright", lty= 1, col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot fourth graph in (2,2)
with(feb_data, plot(datetime, Global_reactive_power, type="l", ylab="Global reactive power"))


#off device
dev.off()


