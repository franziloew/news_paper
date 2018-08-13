##initializations, convergence checks, matrix stats

##
#A series of fast softmax functions mostly wrappers around matrixStats package functions
##
logsoftmax <- function(x) {
  x - lse(x)
}

lse <- function(x) {
  logSumExp(x)
}

row.lse <- function(mat) {
  rowLogSumExps(mat)
}
col.lse <- function(mat) {
  colLogSumExps(mat)
}

softmax <- function(x) {
  exp(x - lse(x))
}

safelog <- function(x) {
  out <- log(x)
  out[which(out< -1000)] <- -1000
  out
}


###
# Kappa initialization
###

#initialize the parameters.  
init.paramsSAGE <- function(K, documents, vocab, num.views, it.num=50, alpha.gibbs=.01, eta.gibbs=.01) {
  resetdocs <- documents
  for (i in 1:length(documents)) {
    resetdocs[[i]][1,] <- as.integer(resetdocs[[i]][1,]-1)
  }
  
  mod <- lda.collapsed.gibbs.sampler(resetdocs, K, vocab, num.iterations=it.num, alpha=alpha.gibbs,
                                     eta=eta.gibbs)
  gamma <- t(mod$document_sums) + .Machine$double.eps
  topics <- mod$topics + .Machine$double.eps
  logbeta <- log(topics) - log(rowSums(topics))
  logbetalist <- list()
  for(i in 1:num.views) {
    logbetalist[[i]] <- logbeta
  }
  kappa <- kappa.init(documents, K, length(vocab), A=num.views, interactions=TRUE)
  
  current.params <- list(global=list(alpha=rep(1/K,K), logbeta=logbetalist, kappa=kappa), 
                         local=list(gamma=gamma),
                         params=list(K=K, num.views=num.views, V=length(vocab)))
  return(current.params)
}




kappa.init <- function(documents, K, V, A, interactions) {
  kappa.out <- list()
  #Calculate the baseline log-probability (m)
  freq <- matrix(unlist(documents),nrow=2) #break it into a matrix
  freq <- split(freq[2,], freq[1,]) #shift into list by word type
  m <- unlist(lapply(freq, sum)) #sum over the word types
  m <- m/sum(m)
  #m <- log(m)
  m <- log(m) - log(mean(m)) #logit of m
  kappa.out$m <- m
  
  #Defining parameters
  aspectmod <- A > 1
  if(aspectmod) {
    interact <- interactions 
  } else {
    interact <- FALSE
  }
  
  #Create the parameters object
  parLength <- K + A*aspectmod + (K*A)*interact
  kappa.out$params <- vector(mode="list",length=parLength)
  for(i in 1:length(kappa.out$params)) {
    kappa.out$params[[i]] <- rep(0, V)
  }
  
  #Create a running sum of the kappa parameters starting with m
  kappa.out$kappasum <- vector(mode="list", length=A)
  for (a in 1:A) {
    kappa.out$kappasum[[a]] <- matrix(m, nrow=K, ncol=V, byrow=TRUE)
  }
  
  #create covariates. one element per item in parameter list.
  #generation by type because its conceptually simpler
  if(!aspectmod & !interact) {
    kappa.out$covar <- list(k=1:K, a=rep(NA, parLength), type=rep(1,K))
  }
  if(aspectmod & !interact) {
    kappa.out$covar <- list(k=c(1:K,rep(NA,A)), a=c(rep(NA, K), 1:A), type=c(rep(1,K), rep(2,A)))      
  }
  if(interact) {
    kappa.out$covar <- list(k=c(1:K,rep(NA,A), rep(1:K,A)), 
                            a=c(rep(NA, K), 1:A, rep(1:A,each=K)), 
                            type=c(rep(1,K), rep(2,A), rep(3,K*A)))            
  }
  return(kappa.out)
}

convergence.check <- function(bound.ss, model, settings) {
  convergence <- model$convergence
  verbose <- settings$verbose
  emtol <- settings$convergence$em.converge.thresh
  maxits <- settings$convergence$max.em.its
 
  if(is.null(convergence)) {
    convergence <- list(bound=c(), its=1, converged=FALSE)
  }
  convergence$bound[convergence$its] <- sum(bound.ss)
  
  if(convergence$its > 1) {
    old <- convergence$bound[convergence$its-1]
    new <- convergence$bound[convergence$its]
    convergence.check <- (new-old)/abs(old)
    
    if(convergence.check < emtol) {
      convergence$converged <- TRUE
      if(verbose) cat("Model Converged \n")
      return(convergence)
    }
  }
  if(convergence$its==maxits) {
    if(verbose) cat("Model Terminated Before Convergence Reached \n")
    convergence$converged <- TRUE
    return(convergence)
  }
  convergence$its <- convergence$its + 1
  return(convergence)
}
