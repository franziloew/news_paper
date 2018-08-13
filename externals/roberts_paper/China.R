##
# This file replicates the China analyses.
# We note that this work was done before many 
# of the modern features for stm were in place.
# As such much of the code below is written in
# a more complex way than would now be necessary.
# Please see the most recent version of the stm package
# for more.

library(Matrix)
library(stm) #should work on version 1.1.3 but may not exactly replicate after.
library(stringr)

K <- 100

#Raw texts not provided due to intellectually property constraints
#here is the preprocessing:
# meta <- read.csv("Sample.csv")
# processed <- textProcessor(meta$V6, metadata=meta)
# out <- prepDocuments(processed$documents, processed$vocab, processed$meta, lower.thresh=100)
# out$meta$sourc <- as.factor(out$meta$Source)

#stm was then run via the specification below
#mod.spectral <- stm(documents = out$documents, vocab = out$vocab, K =
#                    K, prevalence = ~  sourc + s(as.numeric(Date)), 
#                    data = out$meta, max.em.its = 200, init.type="Spectral")
load("ChinaModelOut.RData")
load("ChinaData.RData")

sagelabs <- sageLabels(mod.spectral, 25)
out$meta$Date <- as.numeric(as.Date(as.character(out$meta$Date)))

effect <- estimateEffect(c(1:100)~ sourc + s(Date), mod.spectral, metadata=out$meta, uncertainty="None")
plot.estimateEffect(effect, "Date", topics=c(63), method="continuous", npoints=500)

#Label topics based on Xinhua

sagelabs$cov.betas[[5]]$problabels
#Topic 1: general china
#2: taiwan
#3: general china
#4: Korea, mongolia
#5: Hong Kong return
#6: Visiting other nations
#7: Japanese relations
#8: WTO and international trade
#9: Announccments
#10: Dollar financial markets
#11: China state council
#12: Economic numbers
#13: Promoting cooperation between states
#14: Banks and loans, financial crisis?
#15: ASEAN
#16: big numbers?
#17: Chinese ambassador, visits to other countries
#18: The Communist Party
#19: Foreign ministry press statements
#20: General reporting words
#21: Human rights Tibet
#22: Not sure, people live effort carry great
#23: Global challenges, world, international
#24: Southeast asian relations
#25: Presidential leaders, jintao, clinton
#26: big numbers again
#27: Russia, central asia
#28: Words about time
#29: jiaxuan tang -- foregin minister of PRC
#30: one system, hong kong, Tung (Prez of Executive Council of Hong Kong from takeover)
#31: stocks
#32: Australia, New Zealand
#33: General CHina
#34: Nuclear Iran
#35: The military, army
#36: George Bush, America, U.S. Powell
#37: Unemployment, welfare in China
#38: Manufacturing
#39: Prices, inflation?
#40: South Afria
#41: NOrth Korea
#42: Ethnic minorities
#43: General diplomatic
#44: General communication
#45: Privincial topic
#46: Possibly bid for the olympics in Beijing?
#47: European Union
#48: Conference, meeting topics
#49: Development topic
#50: Oil, energy resource topic
#51: Asia pacific region
#52: General Xinhua news topic
#53: New york and papua guinea? no idea
#54: Not sure
#55: Japanese aggression
#56: Mines, coal safety, chemicals
#57: Negotiation
#58: SARS
#59: Rural taxes, rural income
#60: Pentagon, war topic, spratly islands? not sure
#61: Island disputes in the Pacific
#62: Chen and democracy (probably taiwan)
#63: Falungong cult, etc
#64: South east asia again, philippines, indonesia, malaysia
#65: Textile and machinery exports
#66: Asian market growth
#67: students an deduation
#68: Protecting the environment form pollution
#69: King howard? not ure
#70:Wang mainland, reside, fujian, not sure..
#71: Foriegn direct investment
#72: Olympics
#73: Big, powerful cities like Shanghai Shenzhen
#74: Law, legal system
#75: Terrorism
#76: Economic growth and reform
#77: Zhu rongji, Wen Jiabao topic
#78: airline flight passengers
#79: Accidents -- fire, injured kill, etc
#80: Construction
#81: Vietnam border
#82: Agreements between countries
#83: Thailand
#84: Maritime travel
#85: Science and space research
#86: India/Pakistan/Sri Lanka
#87: Being friends with other nations
#88: Washington and America
#89: Today see yang wei.. not sure
#90: Jiang zemin
#91: germany, canaday, brazil italy (some sort of sports competitoin)
#92: Iraq, Palestine/Israel, peace
#93: Cities children families
#94: World cup
#95: Drug traffiking
#96: Rice, factory, production
#97: Tourism
#98: National people's congress
#99: Floods
#100: Courts, law, rulings

topics <- matrix(c(2, "Taiwan", 4, "Korea, \n Mongolia", 5, "Return of \n Hong Kong", 6, "Visits to \n other nations",
            7, "Japanese \n relations", 8, "WTO and \n International Trade", 9, "Announcements",
            10, "Dollar and \n financial markets", 11, "Chinese State \n Council", 13, "International \n cooperation",
            14, "Banks, \n loans", 15, "ASEAN", 17, "Chinese \n ambassador", 18, "The Communist \n Party",
            19, "Foreign \n  ministry", 21, "Tibet and \n human rights", 23, "Global \n challenges",
            24, "Southeast \n  Asia", 25, "Presidents of U.S. \n and China", 27, "Russia",
            30, "One country,\n two systems", 31, "Stocks", 32, "Australia, \n  New Zealand",
            34, "Iran", 35, "Military", 36, "U.S. \n  leaders", 37, "Unemployment \n and welfare",
            38, "Manufacturing", 39, "Prices \n and inflation", 40, "South \n Africa",
            41, "North \n Korea",
            42, "Ethnic \n minorities", 43, "General \n diplomatic", 45, "Provinces",
            47, "European \n  Union", 49, "Development", 50, "Oil",
            51, "Asia \n Pacific", 55, "Japan visits \n to shrine", 56, "Mines, coal, \n chemicals",
            57, "Negotiation", 58, "SARS", 59, "Rural taxes \n and income", 60, "Pentagon \n and war",
            61, "Pacific islands \n disputes", 62, "Elections in \n Taiwan", 63, "Falungong",
            64, "Philippines, Indonesia,\n  Malaysia", 65, "Textile \n exports", 66, "Asian \n market",
            67, "Education", 68, "Environment and \n pollution", 71, "Foreign direct \n investment",
            72, "Olympics", 73, "Big cities \n in China", 74, "Law in \n  China", 75, "Terrorism",
            76, "Economic growth \n and reform", 77, "Zhu Rongji \n Wen Jiabao",
            78, "Airlines", 79, "Accidents \n and Disasters", 80, "Construction",
            81, "Vietnam", 83, "Thailand", 84, "Maritime \n travel", 85, "Space and science \n research",
            86, "India/Pakistan", 88, "U.S. \n Relations", 90, "Jiang \nZemin", 91, "Sports",
            92, "Middle East", 93, "Families", 94, "World cup", 95, "Drug \n traffiking",
            96, "Rice and \n factory production", 97, "Tourism", 98, "National people's \n congress",
            99, "Floods", 100, "Court \n rulings"), ncol=2, byrow=T)


#For Xinhua
cormat <- cor(mod.spectral$theta[mod.spectral$settings$covariates$betaindex==5,])
adjmat <- ifelse(cormat>.1,1,0)
corr <- list()
corr$posadj <- adjmat
corr$poscor <- cormat*adjmat
corr$cor <- ifelse(abs(cormat)>.1,cormat,0)
stm:::plot.topicCorr(corr, topics=as.numeric(topics[,1]), vlabels=topics[,2], vertex.color="white",
     vertex.frame.color="white", vertex.size=5, vertex.label.cex=.5, edge.color="forestgreen",
     edge.width=.5, main="Xinhua Correlation Plot")

#For AP
cormat <- cor(mod.spectral$theta[mod.spectral$settings$covariates$betaindex==3,])
adjmat <- ifelse(cormat>.1,1,0)
corr.ap <- list()
corr.ap$posadj <- adjmat
corr.ap$poscor <- cormat*adjmat
corr.ap$cor <- ifelse(abs(cormat)>.1,cormat,0)
plot.topicCorr(corr.ap, topics=as.numeric(topics[,1]), vlabels=topics[,2], vertex.color="white",
               vertex.frame.color="white", vertex.size=5, vertex.label.cex=.5, edge.color="forestgreen",
               edge.width=.5, main="BBC Correlation Plot")
#Overlapping correlation
library(igraph)
g.xh <- graph.adjacency(corr$cor, mode="undirected", weighted=T,diag=F)
g.bbc <- graph.adjacency(corr.ap$cor, mode="undirected", weighted=T,diag=F)
inter.graph<-graph.intersection(g.xh, g.bbc)
added.subgraph<-graph.difference(g.xh,inter.graph)
subs.subgraph<-graph.difference(g.bbc,inter.graph)
E(added.subgraph)$color<-"red"
E(subs.subgraph)$color<-"green"
E(inter.graph)$color<-"dodgerblue"
g.whole<-graph.union(inter.graph,added.subgraph,subs.subgraph)
V(g.whole)$color<-"dodgerblue"
E(g.whole)$color <- "green"
E(g.whole)[1:length(E(inter.graph))]$color<-"dodgerblue"
E(g.whole)[(length(E(inter.graph))+1):(length(E(inter.graph))+length(E(added.subgraph)))]$color<-"red"

inter.list <- get.edgelist(inter.graph)
xh.list <- get.edgelist(added.subgraph)
bbc.list <- get.edgelist(subs.subgraph)

cormat <- matrix(0, nrow=100, ncol=100)
for(i in 1:nrow(inter.list)){
  cormat[inter.list[i,1], inter.list[i,2]] <- .5
  cormat[inter.list[i,2], inter.list[i,1]] <- .5
}
for(i in 1:nrow(xh.list)){
  cormat[xh.list[i,1], xh.list[i,2]] <- -1
  cormat[xh.list[i,2], xh.list[i,1]] <- -1
}
for(i in 1:nrow(bbc.list)){
  cormat[bbc.list[i,1], bbc.list[i,2]] <- 1
  cormat[bbc.list[i,2], bbc.list[i,1]] <- 1
}
cormat <- cormat[as.numeric(topics[,1]),as.numeric(topics[,1])]
cormat[68,]
library(reshape2)
topics2 <- sapply(topics[,2], function (x) str_replace(x, "\n", ""))
rownames(cormat) <- colnames(cormat) <- topics2
#degree <- apply(cormat,1,function (x) sum(abs(x)))
#orderd <- order(degree, decreasing=T)
#cormat <- cormat[orderd, orderd]
bbconly <- apply(cormat,1, function (x) sum(x==1))
xhonly <- apply(cormat,1, function (x) sum(x==-1))
both <- apply(cormat,1, function (x) sum(x==.5))
all <- apply(cormat,1, function (x) sum(x!=0))
disagree <- bbconly/all + xhonly/all
disagreed <- order(disagree, decreasing=F)
list <- topics[disagreed,2]
disagreemat <- cormat[disagreed, disagreed]
rownames(disagreemat) <- topics2[disagreed]
colnames(disagreemat) <- topics2[disagreed]
library(corrplot)
#corrplot(cormat[c(17,19,21,23,24,25,26,28,30,37,54,55,58,60,74),], tl.cex=.5, cl.pos="n", tl.col="black")
corrplot(disagreemat, cl.pos="n", tl.col="black", tl.cex=.5)
legend(80,20, c("Xinhua", "BBC", "All", "None"),col=c("darkred", "darkblue", "lightblue", "white"), pch=c(15,15,16,16))

#In black and white
library(corrplot)
pdf("BWCorrplot.pdf", height=10, width=12)
par(mar=c(5.1,4.1,4.1,4.1))
#corrplot(cormat[c(17,19,21,23,24,25,26,28,30,37,54,55,58,60,74),], tl.cex=.5, cl.pos="n", tl.col="black")
corrplot(disagreemat, "circle",cl.pos="n", tl.col="black", tl.cex=.5, col=c("gray1", "black", "white","gray4", "darkgray"))
legend(80,20, c("Xinhua", "BBC", "All", "None"),col=c("black", "darkgray", "gray4", "white"), 
       pch=c(16,16,16,16), pt.cex = c(1.2,1.2,.7,1))
dev.off()
out$meta$Date <- as.numeric(out$meta$Date)

plotByNewspaper <- function(topic, span=.25){
  x <- out$meta$Date[mod.spectral$settings$covariates$betaindex==1]
  y <- mod.spectral$theta[mod.spectral$settings$covariates$betaindex==1,topic]
  plot(x,y, pch=16, cex=.5, col="white", xaxt="n")
  axis(1,seq(9862,9862+365*10,by=365), labels=seq(1997,2007))
  loess1 <- loess(y~x, span=span)
  lines(loess1$x, loess1$fitted)
  print(sagelabs$cov.betas[[1]]$problabels[topic,])
  
  x <- out$meta$Date[mod.spectral$settings$covariates$betaindex==2]
  y <- mod.spectral$theta[mod.spectral$settings$covariates$betaindex==2,topic]
  #points(x,y, pch=16, cex=.5, col="red")
  loess1 <- loess(y~x, span=span)
  lines(loess1$x, loess1$fitted, col="red")
  print(sagelabs$cov.betas[[2]]$problabels[topic,])
  
  x <- out$meta$Date[mod.spectral$settings$covariates$betaindex==3]
  y <- mod.spectral$theta[mod.spectral$settings$covariates$betaindex==3,topic]
  #points(x,y, pch=16, cex=.5, col="blue")
  loess1 <- loess(y~x, span=span)
  lines(loess1$x, loess1$fitted, col="blue")
  print(sagelabs$cov.betas[[3]]$problabels[topic,])
    
  x <- out$meta$Date[mod.spectral$settings$covariates$betaindex==4]
  y <- mod.spectral$theta[mod.spectral$settings$covariates$betaindex==4,topic]
  #points(x,y, pch=16, cex=.5, col="orange")
  loess1 <- loess(y~x, span=span)
  lines(loess1$x, loess1$fitted, col="orange")
  print(sagelabs$cov.betas[[4]]$problabels[topic,])
  
  x <- out$meta$Date[mod.spectral$settings$covariates$betaindex==5]

  y <- mod.spectral$theta[mod.spectral$settings$covariates$betaindex==5,topic]
  #points(x,y, pch=16, cex=.5, col="green")
  loess1 <- loess(y~x, span=span)
  lines(loess1$x, loess1$fitted, col="green")  
  print(sagelabs$cov.betas[[5]]$problabels[topic,])
}


plotByNewspaper(63)
plotByNewspaper(18)
plotNewspaperHistogram <- function(topic){
  tab <- tapply(mod.spectral$theta[,topic], mod.spectral$settings$covariates$betaindex, mean)
  names(tab) <- c("AFP", "AP", "BBC", "JEN", "XIN")
  barplot(tab, horiz=F, ylab="Overall proportion of topic in corpus")
  }
plotNewspaperHistogram(63)
plotNewspaperHistogram(18)
plotOverall <- function(topic, span=.25, ylab="", xlab="", ylim=c(0,1)){
  x <- out$meta$Date
  y <- mod.spectral$theta[,topic]
  date <- as.character(as.Date(x, origin="1970-01-01"))
  date2 <- sapply(date, function (x) paste(str_sub(x,1,7), "-01", sep=""))
  pts <- tapply(y,as.factor(date2), mean)
  dat <- as.data.frame(cbind(x,y))[order(x),]
  plot(dat$x,dat$y, pch=16, cex=.5, col="white", xaxt="n", ylab=ylab, xlab=xlab, ylim=ylim)
  axis(1,seq(9862,9862+365*10,by=365), labels=seq(1997,2007))
  loess1 <- loess(dat$y~dat$x, span=span)
  lines(loess1$x, loess1$fitted, col="red", lwd=2)
  points(as.numeric(as.Date(names(pts))),pts, pch=16, cex=.4)
  print(sagelabs$cov.betas[[1]]$problabels[topic,])
}
#SARS short-lived
#North Korea long over time
#How they talk about Falungong differently

plotOverall(58, ylim=c(0,.8), xlab="Date", ylab="Topic Proportion", span=.01)
lines(c(9862+365*6+46, 9862+365*6+46), c(-1,.55), lty=2)
text(9862 +365*6 +46, .65, "SARs Outbreak \n in China")
lines(c(9862+365*7+8, 9862+365*7+46), c(-1,.65), lty=2)
text(9862 +365*7 +8, .75, "Avian Flu Outbreak \n in East Asia")

plotQuote(c(paste(sagelabs$cov.betas[[1]]$problabels[58,], collapse="\n"),
            paste(sagelabs$cov.betas[[5]]$problabels[58,], collapse="\n")))
text(2.5,6.8,"Agence France Presse", cex=1.1)
text(2.5,3.2,"Xinhua", cex=1.1)

plotOverall(41, ylim=c(0,.08), span=.1)
lines(c(9862+365*6+10, 9862+365*6+10), c(-1,.05), lty=2)
text(9862 +365*6 +10, .07, "North Korea \n Leaves NPT")

plotQuote(c(paste(sagelabs$cov.betas[[1]]$problabels[41,], collapse="\n"),
            paste(sagelabs$cov.betas[[5]]$problabels[41,], collapse="\n")))
text(2.5,6.8,"BBC", cex=1.1)
text(2.5,3.2,"Xinhua", cex=1.1)

plotOverall(18, ylim=c(0,.08), span=.01)
lines(c(9862+365*6+10, 9862+365*6+10), c(-1,.05), lty=2)
text(9862 +365*6 +10, .07, "North Korea \n Leaves NPT")


plotQuote(c(paste(sagelabs$cov.betas[[1]]$problabels[18,], collapse="\n"),
            paste(sagelabs$cov.betas[[2]]$problabels[18,], collapse="\n"),
            paste(sagelabs$cov.betas[[3]]$problabels[18,], collapse="\n"),
            paste(sagelabs$cov.betas[[4]]$problabels[18,], collapse="\n"),
            paste(sagelabs$cov.betas[[5]]$problabels[18,], collapse="\n")), width=40)
text(.5,11.5,"AFP", cex=1.1)
text(.5,9,"AP", cex=1.1)
text(.5,6.5,"BBC", cex=1.1)
text(.5,4,"JEN", cex=1.1)
text(.5,1.5,"XIN", cex=1.1)


sagelabs <- sageLabels(mod.spectral, n=25)
plotQuote(paste(sagelabs$cov.betas[[2]]$problabels[41,], collapse="\n"))

library(xtable)
xtable(cbind(sagelabs$cov.betas[[2]]$problabels[58,],sagelabs$cov.betas[[2]]$frexlabels[58,], sagelabs$kappa[58,]))

plotQuote(c(paste(sagelabs$cov.betas[[1]]$problabels[63,], collapse="\n"),
            paste(sagelabs$cov.betas[[2]]$problabels[63,], collapse="\n"),
            paste(sagelabs$cov.betas[[3]]$problabels[63,], collapse="\n"),
            paste(sagelabs$cov.betas[[4]]$problabels[63,], collapse="\n"),
            paste(sagelabs$cov.betas[[5]]$problabels[63,], collapse="\n")), width=40)
text(.5,11.5,"AFP", cex=1.1)
text(.5,9,"AP", cex=1.1)
text(.5,6.5,"BBC", cex=1.1)
text(.5,4,"JEN", cex=1.1)
text(.5,1.5,"XIN", cex=1.1)

plotQuote(c(paste(sagelabs$cov.betas[[2]]$problabels[63,], collapse="\n"),
            paste(sagelabs$cov.betas[[5]]$problabels[63,], collapse="\n")))
text(2.5,6.8,"Associated Press", cex=1.1)
text(2.5,3.2,"Xinhua", cex=1.1)
plotOverall(63, ylim=c(0,.06), span=.5)
plotByNewspaper(63)
plotNewspaperHistogram(63)         

effect <- estimateEffect(c(1:100)~ sourc + s(Date), mod.spectral, metadata=out$meta, uncertainty="None")
plot(effect, "sourc", topics=c(63), method="pointestimate",
                    labeltype="custom", custom.labels=rev(c("XIN", "BBC", "JEN", "AP", "AFP")),
                    xlab="Mean topic proportion in corpus")
