##FINAL PRESENTATION OF COMPLEX NETWORKS COURSE

require(ggplot2)
require(igraph)

DD.e <- read.csv('C:/Users/Ali/Desktop/PHYS 5116 - Complex Networks - Fall 2015/Final Project/Final Presentation/trait_trait.csv', header = F, sep = ',')
SS.e <- read.csv('C:/Users/Ali/Desktop/PHYS 5116 - Complex Networks - Fall 2015/Final Project/Final Presentation/snp_snp.csv', header = F, sep = ',')

#----------DISEASE-DISEASE NETWORK----------
#Creating Node List:
DD.n <- data.frame(Nod=c(as.character(DD.e$V1), as.character(DD.e$V2))) #Combining two columns into 1
DD.nc <- as.data.frame(DD.n[!duplicated(DD.n$Nod), ]) #Removing duplicated rows
write.csv(DD.nc, 'C:/Users/Ali/Desktop/PHYS 5116 - Complex Networks - Fall 2015/Final Project/Final Presentation/DD.nod.csv')
write.csv(DD.e, 'C:/Users/Ali/Desktop/PHYS 5116 - Complex Networks - Fall 2015/Final Project/Final Presentation/DD.edg.csv')

#Creating The Disease-Disease Network
DD.Net <- graph.data.frame(DD.e, DD.nc, directed=F)

#Degrees and Degree Distribution
DD.deg <- degree(DD.Net, mode="all")
DD.deg.sorted <- sort(DD.deg, decreasing = T) #sort from highest deg to the lowest

Top50Dis <- head(DD.deg.sorted, 50) #Display 50 highest deg nodes
tail(DD.deg.sorted, 20) #Display 20 lowest deg nodes

write.csv(Top50Dis, 'C:/Users/Ali/Desktop/PHYS 5116 - Complex Networks - Fall 2015/Final Project/Final PresentationTop50Dis.csv') #Save a data frame to a file

n <- function(x) {
  return(x/(max(x)))
} #Function for deviding each value to the max value

DD.deg.n <- n(DD.deg)

DD.Deg.dist <- degree.distribution(DD.Net, cumulative=T, mode="all")
par(mar=c(4,4,4,4))
plot(DD.Deg.dist, log="xy", pch=19, cex=0.5, col="violetred4", xlab="k", ylab="P(k)", main = "Cumulative Degree Distribution")

#Clustering Coefficient
DD.clust <- transitivity(DD.Net,type="local")
plot(DD.deg, DD.clust, log="xy", pch=19, cex=0.5, col="violetred4", xlab="k", ylab="C(k)", main = "Clustering")

require(qgraph)
DD.clust.WS <- clustWS(DD.Net, thresholdWS=0) #clustering coefficient for unweighted networks introduced by Watts & Strogatz

#Components
DD.c.dist <- component_distribution(DD.Net, cumulative = FALSE, mul.size = FALSE)
DD.comps <- components(DD.Net, mode = c("weak", "strong"))
plot(DD.c.dist, pch=19, cex=0.5, col="violetred4", xlab="k", ylab="P(k)", main = "Cumulative Degree Distribution")

#Basic info of the graph
DD.vc <- vcount(DD.Net) #number of vertices
DD.ec <- ecount(DD.Net) #number of edges
summary(DD.deg) #min/max/average degree
DD.ave.path.len <- average.path.length(DD.Net) #average path length

#Plotting The Graph
V(DD.Net)$frame.color <- "white"
V(DD.Net)$color <- "firebrick1"
V(DD.Net)$label <- ""
V(DD.Net)$size <- DD.deg.n*20
V(DD.Net)$shape <- "circle"
E(DD.Net)$arrow.mode <- 0
E(DD.Net)$color <- "gray75"
E(DD.Net)$width <- DD.e$V3*5

V(G.nsl)$size <- bet.nsl.norm*8

par(mar=c(0,0,0,0))#, mfrow=c(2,2))
l1 <- layout.kamada.kawai(DD.Net)
plot(DD.Net, rescale=T, vertex.label=NA, layout=l1)

#----------SNP-SNP NETWORK----------
#Creating Node List:
SS.n <- data.frame(Nod=c(as.character(SS.e$V1), as.character(SS.e$V2))) #Combining two columns into 1
SS.nc <- as.data.frame(SS.n[!duplicated(SS.n$Nod), ]) #Removing duplicated rows

