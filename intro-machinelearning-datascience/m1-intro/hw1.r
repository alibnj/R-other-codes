require(ggplot2)

Cauchy_Dist <- data.frame(A=dcauchy(-6:6,location = 0,scale = 0.5),
                          B=dcauchy(-6:6,location = 0,scale = 1),
                          C=dcauchy(-6:6,location = 0,scale = 2),
                          D=dcauchy(-6:6,location = -2,scale = 1))
head(Cauchy_Dist)

summary(Cauchy_Dist)

qplot(x=-6:6,data=Cauchy_Dist$A,geom= "density", colour=1)

plot(-6:6, Cauchy_Dist$A, xlab = "x", ylab = "P(x)", main = "Possibility Density Function", col=1)
points(-6:6,Cauchy_Dist$B,col=2)
points(-6:6,Cauchy_Dist$C,col=3)
points(-6:6,Cauchy_Dist$D,col=4)

Input_Data <- read.csv(file = "C:/Users/Ali/Desktop/DSCS 6030 - Intro to data Mining and Machine Learning/Module 1/Assignment/M01_Lesson_02_Q1.csv",
         header=TRUE, sep=",")

# qplot(Input_Data$X,Input_Data$E)+scale_x_continuous(breaks=seq(0,330,10))

hist(Input_Data$A)
hist(Input_Data$B)
hist(Input_Data$C)
hist(Input_Data$D)
hist(Input_Data$E)

summary(Input_Data$A)
summary(Input_Data$B)
summary(Input_Data$C)
summary(Input_Data$D)
summary(Input_Data$E)

#We will use the excellent "fitdistrplus" package which offers some nice functions for distribution fitting.
#We will use the "functiondescdist" to gain some ideas about possible candidate distributions.

install.packages("C:/Users/Ali/Desktop/DSCS 6030 - Intro to data Mining and Machine Learning/PACKAGES/fitdistrplus_1.0-5.tar.gz", repos = NULL, type = "source")
require(fitdistrplus)

#Now lets use descdist:

descdist(Input_Data$A, discrete = FALSE)

#The kurtosis and squared skewness of your sample is plottet as a blue point named "Observation".
#It seems that possible distributions include the Weibull, Lognormal, Normal and possibly the Gamma distribution.

#Let's fit a normall distribution and a normal distribution:

fit.normA <- fitdist(Input_Data$A, "norm")
plot(fit.normA)

#Source: http://stats.stackexchange.com/questions/132652/how-to-determine-which-distribution-fits-my-data-best-r

#B:
descdist(Input_Data$B, discrete = FALSE)

fit.normB <- fitdist(Input_Data$B, "norm")
plot(fit.normB)

#C:
descdist(Input_Data$C, discrete = FALSE)

fit.normC <- fitdist(Input_Data$C, "norm")
plot(fit.normC)

fit.unifC <- fitdist(Input_Data$C, "unif")
plot(fit.unifC)

fit.lnormC <- fitdist(Input_Data$C, "lnorm")
plot(fit.lnormC) #GOOD

fit.gammaC <- fitdist(Input_Data$C, "gamma")
plot(fit.gammaC) #GOOD

#D:
descdist(Input_Data$D, discrete = FALSE)

fit.gammaD <- fitdist(Input_Data$D, "gamma")
plot(fit.gammaD) #GOOD

fit.normD <- fitdist(Input_Data$D, "norm")
plot(fit.normD)

fit.lnormD <- fitdist(Input_Data$D, "lnorm")
plot(fit.lnormD)

#E:
descdist(Input_Data$E, discrete = FALSE)

fit.unifE <- fitdist(Input_Data$E, "unif")
plot(fit.unifE) #GOOD
#-------------------------------------
#REGENERATING THE DATA:

#A:
set.seed(100)
trails <- 333
St <- sd(Input_Data$A)
Me <- mean(Input_Data$A)
norm_distA <- rnorm(trails, sd=St, mean=Me)

xfit <- seq(min(norm_distA),max(norm_distA),length=50)
norm_denGA <- dnorm(xfit, sd=St, mean=Me)
hG <- hist(norm_distA, breaks=10, col="red", main="Histogram of Generated Data with Normal Curve") 
yfit <- norm_denGA*diff(hG$mids[1:2])*trails 
lines(xfit, yfit, col="blue", lwd=2)

#Compared with:
xfitA <- seq(min(norm_distA),max(norm_distA),length=50)
norm_denAA <- density(Input_Data$A)
hA <- hist(Input_Data$A, breaks=10, col="red", main="Histogram of Actual Data")
yfitA <- norm_denAA*diff(hA$mids[1:2])*trails 
lines(xfit, yfit, col="blue", lwd=2)
