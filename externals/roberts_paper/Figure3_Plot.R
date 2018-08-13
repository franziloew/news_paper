############
# This is code to make Figure 3 in Roberts, Stewart and Airoldi (2016)
# it is primarily for documentation purposes as much of the code
# has been supplanted by other alternatives.
# this sequentially calculates coverage you need based on the simulated
# models that are given in the Simulation.R script in this folder.
#############


library(Matrix)
library(devtools)
library(stm)
library(clue)
library(pdist)

#Load the original model
load("Truth.RData")
load("ChinaSimData.RData")



###
# Create a function to sample for one document
###

#there are now better version of this in stm
#see thetaPosterior
rtheta <- function(nsims, lambda, Sigma, choleskydecomp) {
  mat <- stm:::rmvnorm(nsims, lambda, Sigma, choleskydecomp)
  mat <- cbind(mat, 0)
  return(exp(mat - stm:::row.lse(mat)))
}
#test <- rtheta(1000, lambda[1,], Sigma, choleskydecomp)

binnedcover <- vector(mode="list", length=100)
bias <- vector(mode="list", length=100)
L1error <- vector(mode="list", length=100)
true <- mod.out.replicate$theta

for(i in 1:100) {
  load(sprintf("estimated%i.RData", i))
  cost <- pdist(t(mod.out.replicate$theta), t(hopeful$theta))
  align <- solve_LSAP(as.matrix(cost), maximum=FALSE)
  
  #Calculate the global approximation to nu
  Sigma <- hopeful$sigma
  mu <- hopeful$mu$mu
  lambda <- hopeful$eta
  covariance <- crossprod(lambda-t(mu)) 
  #rescale by the number of documents
  covariance <- covariance/nrow(lambda)
  #subtract off the effect from the global covariance
  Sigma <- Sigma - covariance
  choleskydecomp <- chol(Sigma)
  est <- hopeful$theta[,align]
  
  
  cover <- vector(mode="list", length=nrow(lambda))
  cis <- vector(mode="list", length=nrow(lambda))
  for(d in 1:nrow(lambda)) {
    draws <- rtheta(2500, lambda[d,], Sigma, choleskydecomp)
    cis[[d]] <- apply(draws[,align], 2, quantile, c(.025,.975))
    cover[[d]] <- true[d,] > cis[[d]][1,] & true[d,] < cis[[d]][2,]
    rm(draws)
    if(d%%100==0) cat(".")
    if(d%%1000==0) cat(d)
  }
  cat("\n confidence intervals complete... \n")
  
  cover <- do.call(rbind, cover)
  results <- list(cis=cis, cover=cover, group=i)
  save(results, file=sprintf("CiCover%i.RData",i))
  ends <- seq(from=.05, to=1, by=.05)
  binnedcover[[i]] <- unlist(lapply(ends, function(x) mean(cover[true >= (x-.05) & true < x])))
  L1error[[i]] <- unlist(lapply(ends, function(x) mean(abs(true[true >= (x-.05) & true < x] - est[true >= (x-.05) & true < x]))))
  bias[[i]] <- unlist(lapply(ends, function(x) mean(est[true >= (x-.05) & true < x] - true[true >= (x-.05) & true < x])))
  
  cat(sprintf("Completed Set %i \n", i))
}
save(binnedcover, L1error, bias, file="Aggregates.RData")



#Making graphics for inclusion
load("CiCover1.RData")
cover <- results$cover
for(i in 2:100) {
  load(sprintf("CiCover%i.RData",i))
  cover <- results$cover + cover
  cat(".")
}

load("Truth.RData")
load("ChinaSimData.RData")

true <- mod.out.replicate$theta
segment <- .05
ends <- seq(from=segment, to=1, by=segment)
binnedcover <- unlist(lapply(ends, function(x) mean(cover[true >= (x-segment) & true < x])))


ends <- seq(from=0, to=1, by=segment)
ints <- cut(true, breaks=ends)

lab <- as.numeric(bcut(tvec, breaks=10))
labnames <- seq(from=segment/2, to= (1- segment/2), by=segment)
cover <- cover/100
boxplot(c(cover) ~ints, names=labnames, 
        main="Coverage Rates of Document-Topic Proportions",
        ylab="Coverage Rate",
        xlab="True Theta Value",outline=FALSE, ylim=c(55,100),
        pars=list(whisklwd=0, whiskcol="white", outcol="white",  staplecol="white")) 
abline(h=95, lty=2)

#Load up the L1 error
load("estimated1.RData")
cost <- pdist(t(mod.out.replicate$theta), t(hopeful$theta))
align <- solve_LSAP(as.matrix(cost), maximum=FALSE)
L1 <- abs(hopeful$theta[,align]-true)
for(i in 2:100) {
  load(sprintf("estimated%i.RData", i))
  cost <- pdist(t(mod.out.replicate$theta), t(hopeful$theta))
  align <- solve_LSAP(as.matrix(cost), maximum=FALSE)
  L1 <- L1 + abs(hopeful$theta[,align]-true)
  cat(".")
}
L1 <- L1/100 #renorm


ends <- seq(from=0, to=max(true), by=segment)
ints <- cut(true, breaks=ends)
labnames <- seq(from=segment/2, to= (max(ends)- segment/2), by=segment)


pdf(file="CoverageLargeK.pdf", width=12, height=6)
par(mfrow=c(1,2))
boxplot(c(cover) ~ints, names=labnames, 
        main="Coverage of Document-Topic Proportions",
        ylab="Coverage of 95% Credible Interval",
        xlab="True Theta Value",outline=FALSE, ylim=c(.55,1),
        pars=list(whisklwd=0, whiskcol="white", outcol="white",  staplecol="white")) 
abline(h=.95, lty=2)

boxplot(c(L1) ~ints, names=labnames, 
        main= "Expected Error of Document-Topic Proportions",
        ylab="L1 Error",
        xlab="True Theta Value",outline=FALSE, ylim=c(0, .15), 
        pars=list(whisklwd=0, whiskcol="white", outcol="white",  staplecol="white")) 
dev.off()
