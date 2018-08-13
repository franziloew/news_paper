#This is the code for the posterior predictive checks
#which appear in Figure 5 of Roberts,Stewart,Airoldi


library(stm)
#load some auxiliary functions
source("ppcfunctions.R")

#Background you don't need to run
#load("ChinaModelOut.RData")

#meta <- read.csv("../Sample.csv")
#processed <- textProcessor(meta$V6, metadata=meta)
#out <- prepDocuments(processed$documents, processed$vocab, processed$meta, lower.thresh=100)
#out$meta$sourc <- as.factor(out$meta$Source)

#documents <- out$documents
#vocab <- out$vocab
#rm(out,meta,processed)
#mod <- mod.spectral
#rm(mod.spectral)
#set.seed(01238)
#ppc.out <- ppc(mod,documents)
#save(documents, mod, ppc.out, file="ppc.RData")

#now load up the file created above
load("ppc.RData")

#the two lines below are not strictly necessary
#because the object ppc.out is in the loaded file
set.seed(01238)
ppc.out <- ppc(mod,documents)

#make some labels
vocab <- mod$vocab
labs <- sageLabels(mod, n=10)
labs2 <- match(labs$marginal$prob,vocab)
labs2 <- matrix(labs2, nrow=100)

pdf(file="ppc.pdf", width=12, height=4)
par(mfrow=c(1,3))
plot.ppc(ppc.out, labs2[58,], 58, vocab, main="SARS/Avian Flu")
plot.ppc(ppc.out, labs2[21,], 21, vocab, main="Tibet and Human Rights")
plot.ppc(ppc.out, labs2[41,], 41, vocab, xlim=c(0,5), main="North Korea")
dev.off()
