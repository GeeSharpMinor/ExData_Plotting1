## Download file from website
zipfile = "exdata-data-household_power_consumption.zip";
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip";
download.file(url=url, destfile=zipfile);

## This part reads in the power consumption table and does some class conversions for the time and dates for convenience

power <- read.table(file=unz(zipfile, "household_power_consumption.txt"), sep = ";", 
                    na.strings = "?", header=TRUE, stringsAsFactors=FALSE);

power <- rbind(subset(power, Date=="1/2/2007"), subset(power, Date=="2/2/2007"));
power$Time <- strptime(x = paste(power$Date, power$Time), format = "%d/%m/%Y %H:%M:%S");           
power$Date <- as.Date(power$Date, "%d/%m/%Y");


## Create Plots

# Set global variable so that plots are placed in a 2 x 2 grid
par(mfcol=c(2,2));

# Plot the top left graph
plot(y=power$Global_active_power, x=power$Time, 
     ylab="Global Active Power (kilowatt)", xlab="", type="l");

# Plot the bottom left graph
plot(y=power$Sub_metering_1, x=power$Time, type="l", ylab= "Energy sub metering", xlab="");
with(power, lines(y=Sub_metering_2, x=Time, col = "red"));
with(power, lines(y=Sub_metering_3, x=Time, col = "blue"));

legend(x="topright", lty=1, cex=.8, bty="n", col = c("black", "blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"));

# Plot the top right graph
plot(y=power$Voltage, x=power$Time, 
     ylab="Voltage", xlab="datetime", type="l");

# Plot the bottom right graph
with(power, plot(y=Global_reactive_power, x=Time, xlab="datetime", type="l"));

# Output to png
dev.copy(png, filename = "plot4.png", width=480, height = 480);
dev.off();

