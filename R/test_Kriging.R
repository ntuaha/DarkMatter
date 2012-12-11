rm(list=ls(all=TRUE))
library(gstat)
library(automap)

answer <-read.csv('/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/data/Training_halos.csv')

mydata <- data.frame(SkyId=answer$SkyId,pred_x1 = 1:300*0, pred_y1 = 1:300*0,pred_x2 = 1:300*0, pred_y2 = 1:300*0,pred_x3 = 1:300*0, pred_y3 = 1:300*0)
ptm <- proc.time()
for (i in 101:101)
{

  i <- 1
  
  data_path <- paste('/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/data/Train_Skies/Training_Sky',i,sep="")
  data_path <- paste(data_path,'.csv',sep="")
  d<- read.csv(data_path)
  coordinates(d) <- ~x+y
  e <- sqrt(d$e1**2 +d$e2**2)
  d$z <- (1-e)/(1+e)
  
  
  
  #bubble(d,zcol='z',fill=TRUE,do.sqrt=FALSE)
  x=seq(from=0,to=4200,by=50)
  y=seq(from=0,to=4200,by=50)
  gg <- expand.grid(x=x,y=y)
  coordinates(gg) <- ~x+y
  gridded(gg) <-TRUE
  
  
#  g <- gstat(id="z",formula=z~1,data=d)
#  v <- variogram(g)
  # Fit Linear model  anis??
  #v.fit <- fit.variogram(v,model=vgm(model='Nug'))
  
  #v.fit <- fit.variogram(v,model=vgm(model='Sph',range=4000,nugget=0.015))

  
  #plot(v,model=v.fit,as.table=TRUE)
  #g2 <- gstat(g,id="z",model=v.fit)
  auto_Kriging = autoKrige(z~1, d, gg,model = c("Sph", "Exp", "Gau","Ste"))
  #vgm()
  plot(auto_Kriging)
  p <- auto_Kriging$krige_output
  
  
  
  
  #plot and predict
  #p <- predict(g2,model=v.fit,newdata=gg)
  par(mar=c(2,2,2,2))
  png_path <- paste("/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/R/RFigure/",i,sep="")
  png_path <- paste(png_path,".png",sep="")
  png(file = png_path)
  
  image(p,1,col=terrain.colors(20))
  contour(p,add=TRUE,drawlabels=TRUE,col='brown')
  title(paste('Training_Sky',i,sep=""))
  
  back <- p$var1.pred
  ind <-1:3
  ind[1]<-which(back == min(back), arr.ind = TRUE)
  
  #if(ind[1]==1)
  #{
  #  v.fit <- fit.variogram(v,model=vgm(model='Exp',range=4000))
  #  g2 <- gstat(g,id="z",model=v.fit)
  #  p <- predict(g2,model=v.fit,newdata=gg)
  #  image(p,1,col=terrain.colors(20))
  #  contour(p,add=TRUE,drawlabels=TRUE,col='brown')    
  #  back <- p$var1.pred
  #  ind <-1:3
  #  ind[1]<-which(back == min(back), arr.ind = TRUE)    
  #}
  
  marker <- 3
  
  index<-ind
  if(answer$numberHalos[i]>0)
  {
    mydata$pred_x1[i] <- p@coords[index[1],1]
    mydata$pred_y1[i] <- p@coords[index[1],2]
    points(p@coords[index[1],1],p@coords[index[1],2],col='red',pch=marker,cex=3)  
    points(answer$halo_x1[i],answer$halo_y1[i],col='blue',pch=marker,cex=3)
  }
  
  
  

  #halo2
  
  #index<-which(p$z.pred < 0.3, arr.ind = TRUE)
  l <- length(p@coords[,1])
  if(answer$numberHalos[i]>1)
  {
    for(j in 1:l)
    {
      rx <- p@coords[ind[1],1]-p@coords[j,1]
      ry <- p@coords[ind[1],2]-p@coords[j,2]
      if((rx*rx+ry*ry)<1000000)
      {
        back[j] <- 1.0
      }
    }

    ind[2]<-which(back == min(back), arr.ind = TRUE)
    index<-ind
    mydata$pred_x2[i] <- p@coords[index[2],1]
    mydata$pred_y2[i] <- p@coords[index[2],2]
    points(p@coords[index[2],1],p@coords[index[2],2],col='red',pch=marker,cex=3)  
    points(answer$halo_x2[i],answer$halo_y2[i],col='blue',pch=marker,cex=3)  
  }
  if(answer$numberHalos[i]>2)
  {
    for(j in 1:l)
    {
      rx <- p@coords[ind[2],1]-p@coords[j,1]
      ry <- p@coords[ind[2],2]-p@coords[j,2]
      if((rx*rx+ry*ry)<1000000)
      {
        back[j] <- 1.0
      }
    }

    ind[3]<-which(back == min(back), arr.ind = TRUE)
    index<-ind
    mydata$pred_x3[i] <- p@coords[index[3],1]
    mydata$pred_y3[i] <- p@coords[index[3],2]
    points(p@coords[index[3],1],p@coords[index[3],2],col='red',pch=marker,cex=3)  
    points(answer$halo_x3[i],answer$halo_y3[i],col='blue',pch=marker,cex=3)
  }
  
  #points(p@coords[index,1],p@coords[index,2],col='green',pch=1,cex=3)  
  dev.off()
}
write.csv(mydata, file = "/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/R/RResult/Kriging.csv", row.names = FALSE)
proc.time()-ptm
