plot1<-function(){
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
        
        #Creates the file plot1.png to the requested dimensions
        png(filename="plot1.png",width=480,height=480)
        
        #Creates the histogram with the specified title, lables, and color scheme
        hist(energy$Global_active_power, main="Global Active Power",col="Red",xlab=" Global Active Power (kilowatts)")
        
        #Closes the file
        dev.off()
}