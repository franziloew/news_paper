## Monte Carlo's in the style of 4.1 of Roberts, Stewart and Airoldi
# Stewart 2.21.15


# Simulation of text data from the following model:
# beta_k ~ Dirichlet(eta)
# N_d ~ Poisson(lambda)
# x_d ~ Uniform(0,10)
# theta_d ~ LogisticNormal(c(.5,alpha*cos(x_d)), diag(sig2))
# w_{d,n} ~ Mult(theta_d%*%beta)

library(stm)
library(clue) #for aligning topics
library(lda)  #for lda

simulate <- function(n.docs=100, V=50, 
                     eta=.05, lambda=50, sig2=.5, 
                     alpha=1,
                     theta.only=FALSE) {
  #Generate  
  X <- runif(n.docs, 0, 1)
  theta <- t(sapply(X, function(x) {
   gaussian <- stm:::rmvnorm(1, c(.5, alpha*cos(10*x)), diag(rep(sig2, 2)))
   stm:::softmax(c(gaussian,0))
   }))
  
  if(theta.only) {
    #if we only want theta, just stop here.
    return(list(theta=theta, X=X))
  }
  
  #Draw the topic word distributions
  beta <- matrix(rgamma(V*3, eta), nrow=3, ncol=V)

  #Words
  NWords <- rpois(n.docs, lambda) 
  
  #Expected Count Matrix
  ecm <- theta%*%beta
  
  #Simulate the observed data
  documents <- vector(mode="list", length=n.docs)
  for (d in 1:nrow(theta)) {
    w <- rmultinom(1, NWords[d], ecm[d,])
    documents[[d]] <- rbind(which(w>0), w[w>0])
  }
  
  #stm won't like it if there are words which are never used, so we drop them out here
  prepped <- prepDocuments(documents, 1:V, lower.thresh=0, verbose=FALSE)
  
  return(list(documents=prepped$documents, vocab=prepped$vocab, X=X, theta=theta))
}

eval.sim <- function(simobj, lda.alpha=.05, lda.eta=.05, lda.nits=100, 
                     stm.df=5, lda.burnin=TRUE, stm.init="LDA", span=2/3, 
                     #setting lda.burn=TRUE averages over a bunch of draws
                     lda.only=FALSE,...) {
  
  ##Prep files
  documents <- simobj$documents
  vocab <- simobj$vocab
  
  #like everything else besides R, lda indexes from 0.  So we have to offset all the indices.
  resetdocs <- documents
  for (i in 1:length(documents)) {
    resetdocs[[i]][1,] <- as.integer(resetdocs[[i]][1,]-1)
  }
  
  covar <- simobj$X
  truth.theta <- simobj$theta
  
  ##Run LDA
  if(lda.burnin){
    burnin <- floor(lda.nits/2) 
  } else {
    burnin <- NULL
  }  
  mod <- lda.collapsed.gibbs.sampler(resetdocs, 3, vocab, 
                                     num.iterations=lda.nits, burnin= burnin,
                                     alpha=lda.alpha,
                                     eta=lda.eta)
  if(lda.burnin) {
    lda.theta <- t(mod$document_expects)/rowSums(t(mod$document_expects))
  } else {
    lda.theta <- t(mod$document_sums)/rowSums(t(mod$document_sums))
  }
  hungarian.lda <- solve_LSAP(t(truth.theta)%*%lda.theta, maximum=TRUE) 
  lda.theta <- lda.theta[,hungarian.lda]
  lda.line <- loess.smooth(covar, lda.theta[,2], span=span)
  
  if(lda.only) return(list(lda=lda.line))
  
  ##Run STM
  mod <- stm(documents, vocab, K=3,prevalence=~s(covar, df=stm.df), 
             init.type=stm.init, verbose=FALSE,...)
  stm.theta <- mod$theta
  
  ##Align with the truth
  hungarian.stm <- solve_LSAP(t(truth.theta)%*%stm.theta, maximum=TRUE) 
  stm.theta <- stm.theta[,hungarian.stm]
  
  #Calculate Loess Smoothed Line
  stm.line <- loess.smooth(covar, stm.theta[,2], span=span)
    
  return(list(lda=lda.line, stm=stm.line, covar=covar, stm.theta=stm.theta[,2], lda.theta=lda.theta[,2]))
}


set.seed(02138)
span <- 1/3  # the span of the loess smoother
sig2 <- .5
#Loop over 50 datasets to create the solutions
line.storage <- vector(mode="list", length=50)
for(i in 1:length(line.storage)) {
  simobj <- simulate(alpha=1, sig2=sig2, V=50)
  line.storage[[i]] <- eval.sim(simobj, lda.burnin=TRUE, stm.df=10, stm.init="LDA", 
                                lda.alpha=.05, lda.eta=.05, span=span, 
                                control=list(nits=500, burnin=400, 
                                             alpha=.05, eta=.05))
  cat(sprintf("Finished Simulation %i \n",i))
}

#We want a line for the truth
truth <- simulate(n.docs=5000, sig2=sig2, theta.only=TRUE)
true.line <- loess.smooth(x=truth$X, y=truth$theta[,2], span=.25)

pdf(file="Cosine.pdf", width=9, height=3)
par(mfrow=c(1,3))
plot(0,0,xlim=c(0,1),ylim=c(0,1),type="n", main="LDA", xlab="Covariate", ylab="Topic Proportion")
for (i in 1:length(line.storage)) {
  lines(line.storage[[i]]$lda, col=rgb(160,32,240,50,maxColorValue=255))
}
lines(true.line, lwd=2)

plot(0,0,xlim=c(0,1),ylim=c(0,1),type="n", main="STM", xlab="Covariate", ylab="Topic Proportion")
for (i in 1:length(line.storage)) {
  lines(line.storage[[i]]$stm, col=rgb(160,32,240,50,maxColorValue=255))
}
lines(true.line, lwd=2)

plot(0,0,xlim=c(0,1),ylim=c(0,1),type="n", main="True Values", xlab="Covariate", ylab="Topic Proportion")
for(i in 1:50) {
  noest <- simulate(n.docs=100, sig2=sig2, theta.only=TRUE)
  lines(loess.smooth(x=noest$X, y=noest$theta[,2], span=span), col=rgb(32,32,32,50,maxColorValue=255))
}
lines(true.line, lwd=2)
dev.off()
