require(lda)
require(matrixStats)
library(stm)

out <- prepDocuments(poliblog5k.docs, poliblog5k.voc, poliblog5k.meta,subsample=500,lower.thresh=20,upper.thresh=200)
documents <- out$documents
vocab <- out$vocab
meta <- out$meta
K <- 50
source("SAGE.R")
source("SAGEkapp.R")
source("SAGEaux.R")
mod <- SAGE(documents, vocab, K, content=~rating, data=meta, max.em.its=3)

#where things are
mod$model$local$theta  #theta
mod$model$global$logbeta #list of logbetas
