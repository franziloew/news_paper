#The setup for the simulation reported in Roberts, Stewart and Airodi (2016)
#is included below.  This was parallelized over a cluster computing system
#Due to changes in the underlying package we would not expect this to replicate
#exactly.

library(Matrix)
library(devtools)
library(stm)
library(clue)
library(pdist)

#the lines below expect an integer that came from the run on the cluster computer
iteration <- as.integer(commandArgs(TRUE))+1
set.seed(iteration)

load("Truth.RData") #a reference model
load("ChinaSimData.RData") #the version of the documents that go with this model
#we create a simulation based on the observed data.

beta <- lapply(mod.out.replicate$beta$logbeta, exp)
theta <- mod.out.replicate$theta
theta <- t(apply(theta, 1, function(x) {
               y <- rep(0, length(x)) 
               y[which.max(x)] <- 1
               return(y)}))

Nd <- unlist(lapply(out$documents, function(x) sum(x[2,])))
index <- mod.out.replicate$settings$covariates$betaindex
sim.docs <- vector(mode="list", length=length(out$documents))
V <- length(out$vocab)
for(i in 1:length(sim.docs)) {
  prob <- theta[i,]%*%beta[[index[i]]]
  x <- table(sample(x = 1:V, prob = prob, size = Nd[i],replace = TRUE))
  sim.docs[[i]] <- rbind(as.integer(names(x)), as.integer(x))
}

sim.estimate <- stm(documents = sim.docs, vocab = out$vocab, K = 100, 
               prevalence = ~  sourc + s(as.numeric(date)), 
               content = ~ sourc, 
               data = out$meta, max.em.its = 500, init.type="Spectral")
save(sim.estimate, file=sprintf("estimated%i.RData", iteration))

