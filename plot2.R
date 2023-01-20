library(lubridate)
library(data.table)

#---get data
#zfile="exdata_data_household_power_consumption.zip" 
#pfile<-unzip(zfile)    #<--(uncomment these 2 lines if use the zip file)
pfile<-"household_power_consumption.txt"
dt  <- fread(pfile,sep=";")
sdt <- subset(dt, Date=="1/2/2007" | Date=="2/2/2007")       #<--get subset
sdt[,"datetime"]<-dmy_hms(paste(sdt$Date,sdt$Time,sep=" "))  #<--add a col w/ date/time

#---make plot in png device
png(file="plot2.png",width = 480, height = 480)

with(sdt,plot(datetime,Global_active_power,xlab="",
              ylab="Global Active Power (kilowatts)",type="n"))
lines(sdt$datetime,sdt$Global_active_power)

dev.off()
