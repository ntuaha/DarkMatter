rm(list=ls(all=TRUE))
library(gstat)
answer <-read.csv('/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/data/Training_halos.csv')
mydata <- data.frame(SkyId=answer$SkyId,pred_x1 = 1:300*0, pred_y1 = 1:300*0,pred_x2 = 1:300*0, pred_y2 = 1:300*0,pred_x3 = 1:300*0, pred_y3 = 1:300*0)
ptm <- proc.time()
i <- 1
data_path <- paste('/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/data/Train_Skies/Training_Sky',i,sep="")
data_path <- paste(data_path,'.csv',sep="")
d<- read.csv(data_path)
coordinates(d) <- ~x+y
e <- sqrt(d$e1**2 +d$e2**2)
d$z <- (1-e)/(1+e)


#image setting
marker <-3
g <- gstat(id="z",formula=z~1,data=d)
par(mar=c(2,2,2,2))
image(g,1,col=terrain.colors(20))
title(paste('Training_Sky',i,sep=""))
#image path
png_path <- paste("/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab",i,sep="")
png_path <- paste(png_path,".png",sep="")
png(file = png_path)

spplot(d,zcol="z",contour=TRUE,labels=TRUE,col='brown',main='OK prediction')

#contour(g$,add=TRUE,drawlabels=TRUE,col='brown')  
points(answer$halo_x1[i],answer$halo_y1[i],col='blue',pch=marker,cex=3)
dev.off()
