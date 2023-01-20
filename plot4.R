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
png(file="plot4.png",width = 480, height = 480)

par(mfcol=c(2,2))

#---top-left panel 
ylab="Global Active Power"
with(sdt,plot(datetime,Global_active_power,xlab="",ylab=ylab,type="n"))
lines(sdt$datetime,sdt$Global_active_power)

#---bottom left panel 
ylab3="Energy sub metering"
with(sdt,plot(datetime,Sub_metering_1,ylab=ylab3,xlab="",type="n"))
lines(sdt$datetime,sdt$Sub_metering_1,col='black')
lines(sdt$datetime,sdt$Sub_metering_2,col='red')
lines(sdt$datetime,sdt$Sub_metering_3,col='blue')
x1<-sdt$datetime[1200] ; y1<-39
legend(x1,y1,lty=c(1,1,1),col=c("black","red","blue"),
       legend=names(sdt)[7:9],box.lty =0, cex=0.7)

#---top right panel
with(sdt,plot(datetime,Voltage,type = "n"))
lines(sdt$datetime,sdt$Voltage,lty=1)

#---bottom right panel
with(sdt,plot(datetime,Global_reactive_power,xlab="datetime",type="n"))
lines(sdt$datetime,sdt$Global_reactive_power,lty=1)

dev.off()

