library(igraph)
library(dplyr)

all.q2 <- read.csv('C:/Users/alibs/Google Drive/Courses/INSH 5302 - Info Design & Visual Analytics/Project 2/boston-taz-2019-2-All-HourlyAggregate.csv', )
# Finding the frequency of destinations:
q2.dest.freq <- as.data.frame(table(all.q2$dstid), stringsAsFactors=F)
# Sorting the frequencies in descending order:
q2.dest.freq <- q2.dest.freq[order(q2.dest.freq$Freq, decreasing = T),]
row.names(q2.dest.freq) <- NULL
colnames(q2.dest.freq) <- c('dstid', 'freq')
# Selecting the top 50 destinations:
top <- as.character(q2.dest.freq$dstid[1:11])
top <- top[-2]
# Keepng only the top destinations in the data and source/dest ID:
filt.q2 <- all.q2[(all.q2$dstid %in% top & all.q2$sourceid %in% top), c('sourceid', 'dstid')]
# all.q2$sourceid %in% top | 
filt.q2$sourceid <- as.character(filt.q2$sourceid)
filt.q2$dstid <- as.character(filt.q2$dstid)

# Removing duplicates:
filt.q2 <- unique(filt.q2)
row.names(filt.q2) <- NULL
# Adding frequencies for destinations:
filt.q2 <- inner_join(filt.q2, q2.dest.freq, by = "dstid")

#V.list <- data.frame(dstid=as.character(c(351, 362, 312, 204, 215, 202, 203, 441, 131, 216, 130, 359, 459, 232, 249, 794, 217, 170, 368, 122)),
#                     stringsAsFactors=F)
V.list <- data.frame(dstid=as.character(c(351, 204, 215, 203, 131, 249, 202, 368, 312, 122)),
                     stringsAsFactors=F)

V.list <- inner_join(V.list, q2.dest.freq, by = "dstid")

colnames(V.list) <- c('MOVEMENT_ID', 'freq')
V.list.names <- inner_join(V.list, as.data.frame(city.bounds), by='MOVEMENT_ID')

filt.q2.graph <- graph.data.frame(filt.q2, directed=F)
filt.q2.graph <- simplify(filt.q2.graph)

V(filt.q2.graph)$frame.color <- "deeppink1"
V(filt.q2.graph)$color <- "firebrick1"
V(filt.q2.graph)$label.color <- "ivory1"
V(filt.q2.graph)$label.cex <- 3
#V(filt.q2.graph)$label <- ""
V(filt.q2.graph)$size <- V.list$freq/3000
V(filt.q2.graph)$shape <- "circle"
E(filt.q2.graph)$arrow.mode <- 0
E(filt.q2.graph)$color <- "gray75"
#E(filt.q2.graph)$width <- DD.e$V3*5

#par(mfrow=c(1,1))
par(bg = "gray18")
plot(filt.q2.graph, layout=layout.sphere)
plot(filt.q2.graph, layout=layout.circle)
plot(filt.q2.graph, layout=layout.random)
plot(filt.q2.graph, layout=layout.fruchterman.reingold)
plot(filt.q2.graph, layout=layout.reingold.tilford)


for (i in 1:length(top)) {
  print(as.character(city.bounds$DISPLAY_NAME[city.bounds$MOVEMENT_ID==top[i]]))
}
