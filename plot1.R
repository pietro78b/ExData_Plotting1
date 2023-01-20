library(lubridate)
library(data.table)

rm(list=ls())
pfile<-"household_power_consumption.txt"
dt  <- fread(pfile,sep=";")

sdt <- subset(dt, Date=="1/2/2007" | Date=="2/2/2007")       
sdt[,"datetime"]<-dmy_hms(paste(sdt$Date,sdt$Time,sep=" "))  
dim(sdt)      #--> just a quick check
names(sdt)    #--> check new col

#---make plot in png device
png(file="plot1.png",width = 480, height = 480)

hist(as.numeric(sdt$Global_active_power),col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

dev.off()
