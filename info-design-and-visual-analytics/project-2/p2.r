# Data vis my city in time
library('rjson')
library('jsonlite')
library('geojsonio')
library('leaflet')
library('tidyverse')
library('ggplot2')
library(viridis)


all.q2 <- read.csv('C:/Users/alibs/Google Drive/Courses/INSH 5302 - Info Design & Visual Analytics/Project 2/boston-taz-2019-2-All-HourlyAggregate.csv',
                   stringsAsFactors=F)

city.bounds <- geojson_read("C:/Users/alibs/Google Drive/Courses/INSH 5302 - Info Design & Visual Analytics/Project 2/boston_taz.json",
                                      what = "sp")

pal <- colorNumeric("viridis", NULL, reverse = T)
#pal <- colorNumeric(scale_colour_hue(h = c(230, 330)), NULL, reverse = T)
#  scale_colour_hue(h = c(230, 330))
#Z <- city.bounds[city.bounds$town=='BOSTON'|
#                 city.bounds$town=='BROOKLINE'|
#                 city.bounds$town=='CAMBRIDGE', ]


# Popularity of regions:
# Destinations
pop.dest <- as.data.frame(table(all.q2$dstid))
#pop.dest.filt <- subset(pop.dest, Var1 %in% Z$MOVEMENT_ID)
pop.dest <- pop.dest[match(city.bounds$MOVEMENT_ID, pop.dest$Var1),]

# Sources
pop.src <- as.data.frame(table(all.q2$sourceid))
#pop.src.filt <- subset(pop.src, Var1 %in% Z$MOVEMENT_ID)
pop.src <- pop.src[match(city.bounds$MOVEMENT_ID, pop.src$Var1),]

# For not having NAs in the map:
city.bounds <- subset(city.bounds, MOVEMENT_ID %in% pop.dest$Var1)
pop.dest <- pop.dest[match(city.bounds$MOVEMENT_ID, pop.dest$Var1),]






#V <- inner_join(Z, Filt.data2, by='MOVEMENT_ID')
#Z$MOVEMENT_ID
leaflet(Z) %>%
  addTiles() %>%
  addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = 1,
              fillColor = ~pal(as.numeric(Filt.data2$mean_travel_time)/60),)%>%
  addLegend(pal = pal, values = ~as.numeric(Filt.data2$mean_travel_time)/60, opacity = 1.0, title='Travel time [min]')



leaflet(city.bounds) %>%
  addTiles() %>%
  addPolygons(stroke = FALSE, smoothFactor = 0.1, fillOpacity = 0.6,
              fillColor = ~pal(pop.src$Freq), label=city.bounds$MOVEMENT_ID)%>%
  addLegend(pal = pal, values = ~as.numeric(pop.src$Freq), opacity = 0.9, title='Count')

leaflet(city.bounds) %>%
  addTiles() %>%
  addPolygons(stroke = FALSE, smoothFactor = 0.1, fillOpacity = 0.6,
              fillColor = ~pal(pop.dest$Freq), label=city.bounds$MOVEMENT_ID)%>%
  addLegend(pal = pal, values = ~as.numeric(pop.dest$Freq), opacity = 0.9, title='Count')


#-------------------------------
  pal <- colorNumeric("viridis", NULL)
  
  leaflet(nycounties) %>%
    addTiles() %>%
    addPolygons(stroke = FALSE, smoothFactor = 0.3, fillOpacity = 1,
                fillColor = ~pal(log10(pop)),
                label = ~paste0(county, ": ", formatC(pop, big.mark = ","))) %>%
    addLegend(pal = pal, values = ~log10(pop), opacity = 1.0,
              labFormat = labelFormat(transform = function(x) round(10^x)))
  
  
  
# -------------------------------------------------------------------
# MALDEN TO AIRPORT:

#----- Daily Averages For Apr, May, June ------------->
mta.daily4 <- read.csv('C:/Users/alibs/Google Drive/Courses/INSH 5302 - Info Design & Visual Analytics/Project 2/Malden-Airport/Travel_Times_Daily (04).csv',
                      stringsAsFactors = F)
mta.daily5 <- read.csv('C:/Users/alibs/Google Drive/Courses/INSH 5302 - Info Design & Visual Analytics/Project 2/Malden-Airport/Travel_Times_Daily (05).csv',
                       stringsAsFactors = F)
mta.daily6 <- read.csv('C:/Users/alibs/Google Drive/Courses/INSH 5302 - Info Design & Visual Analytics/Project 2/Malden-Airport/Travel_Times_Daily (06).csv',
                       stringsAsFactors = F)

# Sorting the rows based on date:
mta.daily4 <- mta.daily4[order(as.Date(mta.daily4$Date, format="%m/%d/%Y")),]
mta.daily5 <- mta.daily5[order(as.Date(mta.daily5$Date, format="%m/%d/%Y")),]
mta.daily6 <- mta.daily6[order(as.Date(mta.daily6$Date, format="%m/%d/%Y")),]
row.names(mta.daily4) <- NULL
row.names(mta.daily5) <- NULL
row.names(mta.daily6) <- NULL

# Adding days:
mta.daily4$day <- seq(1, nrow(mta.daily4))
mta.daily5$day <- seq(1, nrow(mta.daily5))
mta.daily6$day <- seq(1, nrow(mta.daily6))

# Adding Month
mta.daily4$month <- 'April'
mta.daily5$month <- 'May'
mta.daily6$month <- 'June'

# Removing day 31 from May to have even day counts for all months
mta.daily5 <- mta.daily5[1:30, ]

# Sorting the data based on date:
mta.daily <- mta.daily[order(as.Date(mta.daily$Date, format="%m/%d/%Y")),]
# Extracting Month in a separate column:
mta.daily$month <- substr(mta.daily$Date, 1, 2)
row.names(mta.daily) <- NULL
# Grouping the data by date:
mta.daily.gr <- group_by(mta.daily, month)
  
# Area plot
ggplot(mta.daily4, aes(x=day, y=mta.daily4$Daily.Mean.Travel.Time..Seconds./60)) + 
  geom_area(aes(colour=mta.daily4$month, fill=mta.daily4$month,
                size=.7),alpha=0.5, show.legend=F)+
  geom_area(aes(y= mta.daily5$Daily.Mean.Travel.Time..Seconds./60, 
                colour=mta.daily5$month, fill=mta.daily5$month, size=.7),
            alpha=0.5, show.legend=F)+
  geom_area(aes(y= mta.daily6$Daily.Mean.Travel.Time..Seconds./60,
                colour=mta.daily6$month, fill=mta.daily6$month, size=.7),
            alpha=0.5, show.legend=F)+
  coord_cartesian(ylim=c(15, 33), xlim=c(2, 29))+
  # Plot Pannel colors and formatting:
  theme(panel.background = element_rect(fill = 'gray18', colour = "gray18",
                                    size = 2, linetype = "solid"),
    panel.grid.major = element_line(size = 0.5, linetype = 'solid',
                                    colour = "gray60"), 
    panel.grid.minor = element_line(size = 0.25, linetype = 'solid',
                                    colour = "gray40"),
    plot.background = element_rect(fill = 'gray18'),
    axis.title.x = element_blank(),
    axis.title.y = element_blank()
  )+
  scale_fill_hue(h = c(230, 330)) +
  scale_colour_hue(h = c(230, 330))

#----- Week Day Averages For Apr, May, June ------------->
mta.week4 <- read.csv('C:/Users/alibs/Google Drive/Courses/INSH 5302 - Info Design & Visual Analytics/Project 2/Malden-Airport/Travel_Times_day_of_week (04).csv',
                      stringsAsFactors = F)
mta.week5 <- read.csv('C:/Users/alibs/Google Drive/Courses/INSH 5302 - Info Design & Visual Analytics/Project 2/Malden-Airport/Travel_Times_day_of_week (05).csv',
                      stringsAsFactors = F)
mta.week6 <- read.csv('C:/Users/alibs/Google Drive/Courses/INSH 5302 - Info Design & Visual Analytics/Project 2/Malden-Airport/Travel_Times_day_of_week (06).csv',
                      stringsAsFactors = F)

mta.week4$month <- 'April'
mta.week5$month <- 'May'
mta.week6$month <- 'June'

mta.week4$day <- seq(1, 7)
mta.week5$day <- seq(1, 7)
mta.week6$day <- seq(1, 7)

mta.week.all <- rbind(mta.week4, mta.week5, mta.week6)

# Bar plot
ggplot(mta.week.all, aes(fill=month, y=mta.week.all$Mean.Travel.Time..Seconds./60, x=day)) + 
  geom_bar(width=.5, position="dodge", stat="identity", show.legend = F) +
  scale_fill_hue(h = c(230, 330)) +
  theme(panel.background = element_rect(fill = 'gray18', colour = "gray18",
                                        size = 2, linetype = "solid"),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major.y = element_line(size = 0.5, linetype = 'solid',
                                          colour = "gray60"),
        panel.grid.minor.y = element_line(size = 0.25, linetype = 'solid',
                                          colour = "gray40"),
        plot.background = element_rect(fill = 'gray18'),
        axis.title.x = element_blank(),
        axis.title.y = element_blank()
  )


 

#----- Hourly Averages For Apr, May, June ------------->
mta.hour4 <- read.csv('C:/Users/alibs/Google Drive/Courses/INSH 5302 - Info Design & Visual Analytics/Project 2/Malden-Airport/Travel_Times_time_of_day (04)-1.csv',
                       stringsAsFactors = F)
mta.hour5 <- read.csv('C:/Users/alibs/Google Drive/Courses/INSH 5302 - Info Design & Visual Analytics/Project 2/Malden-Airport/Travel_Times_time_of_day (05)-1.csv',
                       stringsAsFactors = F)
mta.hour6 <- read.csv('C:/Users/alibs/Google Drive/Courses/INSH 5302 - Info Design & Visual Analytics/Project 2/Malden-Airport/Travel_Times_time_of_day (06)-1.csv',
                       stringsAsFactors = F)

mta.hour4$month <- 'April'
mta.hour5$month <- 'May'
mta.hour6$month <- 'June'

mta.hour4$h <- seq(1, 5)
mta.hour5$h <- seq(1, 5)
mta.hour6$h <- seq(1, 5)

mta.hour.all <- rbind(mta.hour4, mta.hour5, mta.hour6)

# Bar plot
ggplot(mta.hour.all, aes(fill=month, y=mta.hour.all$Mean.Travel.Time..Seconds./60, x=h)) + 
  geom_bar(width=.4, position="dodge", stat="identity", show.legend = F) +
  scale_fill_hue(h = c(230, 330)) +
  theme(panel.background = element_rect(fill = 'gray18', colour = "gray18",
                                        size = 2, linetype = "solid"),
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.grid.major.y = element_line(size = 0.5, linetype = 'solid',
                                          colour = "gray60"),
        panel.grid.minor.y = element_line(size = 0.25, linetype = 'solid',
                     colour = "gray40"),
        plot.background = element_rect(fill = 'gray18'),
        axis.title.x = element_blank(),
        axis.title.y = element_blank()
  )
  



# OTHERS:
Filt.data <- A[A$sourceid==159, ] # Boston common
Filt.data <- Filt.data[order(Filt.data$dstid), ]

Filt.data2 <- B[B$sourceid==159 & B$month==1, ] # Boston common
Filt.data2 <- Filt.data2[order(Filt.data2$dstid), ]
Filt.data2 <- subset(Filt.data2, dstid %in% Z$MOVEMENT_ID)
Filt.data2 <- Filt.data2[match(Z2$MOVEMENT_ID, Filt.data2$dstid),]
df[match(target, df$name),]
row.names(Filt.data2) <- NULL
