plot4<-function(){
        #Reads the text file after it has already been extracted and saved to the main directory
        #Accounting for the null characters and the separator character
        energy<-read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")
        
        #Converts the Date column from a factor to date class
        energy$Date<-as.Date(energy$Date,"%d/%m/%Y")
        
        #Converts the Time column from a factor to a time class and formats it correctly
        energy$Time<-strptime(energy$Time,"%H:%M:%S")
        energy$Time<-format(energy$Time,"%H:%M:%S")
        
        #Subsets the data frame to get just the desired date range
        energy<-subset(energy,Date >= "2007-02-01" & Date <= "2007-02-02")
        
        #Combines the date and time into one datetime format
        energy$DateTime<-as.POSIXct(paste(energy$Date,energy$Time), format="%Y-%m-%d %H:%M:%S")
        
        #Creates the file plot4.png to the requested dimensions
        png(filename="plot4.png",width=480,height=480)
        
        #Sets up a 2x2 layout for the charts
        par(mfrow=c(2,2))
        
        #Creates the global active power line plot with the proper axis and line type
        plot(energy$DateTime,energy$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
        
        #Creates the voltage line plot with proper axis and line type
        plot(energy$DateTime,energy$Voltage,type="l",ylab="Voltage",xlab="datetime")
        
        #Creates the multi-plot with the specified lables, and line type for the first line
        plot(energy$DateTime,energy$Sub_metering_1,type="l",ylab="Energy Sub Metering",xlab="")
        
        #Adds the second x-axis variable as a red line
        lines(energy$DateTime,energy$Sub_metering_2,type="l",col="red")
        
        #Adds the third x-axis variable as a blue line
        lines(energy$DateTime,energy$Sub_metering_3,type="l",col="blue")
        
        #Adds the legend
        legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"),bty="n")
        
        #Creates the global reactive power line plot with the proper axis and line type
        plot(energy$DateTime,energy$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
        
        #Closes the file
        dev.off()
}