plot2<-function(){
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
        
        #Creates the file plot2.png to the requested dimensions
        png(filename="plot2.png",width=480,height=480)
        
        #Creates the line plot with the proper axis and line type
        plot(energy$DateTime,energy$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
        
        #Closes the file
        dev.off()
}