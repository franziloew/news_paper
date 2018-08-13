##Sparse Additive Generative (SAGE) Model of Text
## Originally due to Eisenstein, Ahmed and Xing (2011) ICML
## Coded up by Brandon Stewart

SAGE <- function(documents, vocab, K, 
                 content, data, interactions=TRUE,
                 em.converge.thresh=.001, max.em.its=500, 
                 doc.converge.thresh=.001, max.doc.its=5,
                 verbose=TRUE, 
                 kappatau.converge.thresh=.001, 
                 max.kappatau.its=100,
                 mstep.converge.thresh=.001, 
                 max.mstep.its=10) {
  ############
  # Set things up
  ############
  
  # Process the content covariate
  if(inherits(content, "formula")) {
    termobj <- terms(content, data=data)
    if(attr(termobj, "response")==1) stop("Response variables should not be included in content formula.")
    if(nrow(attr(termobj, "factors"))!=1) stop("Currently content can only contain one variable.")
    if(is.null(data)) {
      yvar <- eval(attr(termobj, "variables"))[[1]]
    } else {
      char <- rownames(attr(termobj, "factors"))[1]
      yvar <- data[[char]]
    }
    yvar <- as.factor(yvar)
  } else {
    yvar <- as.factor(content)
  }
  yvarlevels <- levels(yvar)
  betaindex <- as.numeric(yvar)
  
  #Initialize Parameters
  N <- length(documents)
  A <- length(unique(betaindex))
  beta.mode <- ifelse(A==1, "SAGE", "TAI")
  current.params <- init.paramsSAGE(K, documents, vocab, num.views=A)
  
  wcountvec <- unlist(lapply(documents, function(x) rep(x[1,], times=x[2,])),use.names=FALSE)
  wcounts <- list(Group.1=sort(unique(wcountvec)))
  V <- length(wcounts$Group.1)  
  wcounts$x <- tabulate(wcountvec)
  rm(wcountvec)
  
  settings <- list(dim=list(K=K, A=A, V=V, wcounts=wcounts),
                   verbose=verbose,
                   convergence=list(max.em.its=max.em.its, 
                                    em.converge.thresh=em.converge.thresh),
                   covariates=list(betaindex=betaindex, 
                                   yvarlevels=yvarlevels),
                   kappa=list(interactions=interactions, 
                              fixedintercept=TRUE, 
                              mstep=list(maxit=max.mstep.its, 
                                         tol=mstep.converge.thresh)),
                   tau=list(mode="Jeffreys", 
                            tol=kappatau.converge.thresh, 
                            maxit= max.kappatau.its))
  
  global.bound <- c()
  converged <- FALSE
  ctevery <- ifelse(N>100, floor(N/100), 1)
  if(verbose) cat("Initialization Complete \n")
  
  while(!converged) {
    
    #Initialize sufficient statistics and storage to be used in M-step
    beta.ss <- vector(mode="list", length=A)
    for(i in 1:A) {
      beta.ss[[i]] <- matrix(0, nrow=K,ncol=length(vocab))
    }
    bound.ss <- vector(length=length(documents))
    
    #E-step    
    for(i in 1:length(documents)) {
      # Step 1: Get Priors
      priors <- list()
      priors$alpha<- current.params$global$alpha
      priors$logbeta <- current.params$global$logbeta[[(betaindex[i])]]
      priors$gamma <- current.params$local$gamma[i,]
      
      # Step 2: Infer Doc Parameters 
      doc.results <- sage.infer.doc(doc=documents[[i]],priors=priors, 
                                    doc.converge.thresh=doc.converge.thresh,
                                    max.doc.its=max.doc.its)    
      
      
      # Step 3: Update Sufficient Statistics
      wordindices <- documents[[i]][1,] 
      beta.ss[[betaindex[i]]][,wordindices] <- exp(doc.results$logphis) + beta.ss[[betaindex[i]]][,wordindices]
      rm(wordindices)
      bound.ss[i] <- doc.results$bound
      current.params$local$gamma[i,] <- doc.results$q.theta
      if(verbose && i%%ctevery==0) cat(".")
    }
    if(verbose) cat("\n") #add a line break for the next message
    if(verbose) cat("Completed E-step.\n")
    # (1) Update Beta
    bottom.opt <- estKappa(beta.ss=beta.ss, kappa=current.params$global$kappa, settings) 
    current.params$global$logbeta <- bottom.opt$logbeta
    current.params$global$kappa <- bottom.opt$kappa
    if(verbose) cat("Completed M-step.\n")

    # (2) One could update alpha here but we are treating it as fixed.
    
    # (3) Check Convergence    
    current.params$convergence <- convergence.check(bound.ss, current.params, settings)
    converged <- current.params$convergence$converged    
    if(verbose & !converged) cat(paste("Completing Iteration Number:",current.params$convergence$its-1,"\n"))
  }
  #Write Out Results
  current.params$local$theta <- current.params$local$gamma/rowSums(current.params$local$gamma)
  covariates <- betaindex
  sage.out <- list(model=current.params, covariates=covariates, vocab=vocab)
  class(sage.out) <- "SAGE"
  return(sage.out)
}

##
# Single Doc Loop
sage.infer.doc <- function(doc, priors, doc.converge.thresh=doc.converge.thresh, 
                           max.doc.its=max.doc.its) {
  q.theta <- priors$gamma
  doc.ct <- doc[2,]
  logbeta.subset <- priors$logbeta[,doc[1,],drop=FALSE]
  numit <- 0
  
  convergence <- FALSE
  while(convergence==FALSE & (numit < max.doc.its)) {     
    logphis <- sage.infer.docphis(doc=doc, logbeta.subset=logbeta.subset, gamma=q.theta)
    q.theta <- sage.infer.gamma(alpha=priors$alpha, logphis=logphis)
    localbound.new <-sage.bound(logbeta.subset=logbeta.subset,q.theta=q.theta,doc.ct=doc.ct)
    if(numit!=0) {
      convergence <- abs(localbound.new-localbound.old) < doc.converge.thresh
    }
    localbound.old <- localbound.new
    numit <- numit + 1
  }
  return(list(logphis=logphis, q.theta=q.theta,bound=localbound.new)) 
}


sage.bound <- function(logbeta.subset, q.theta,doc.ct) {
  logtheta <- log(q.theta) - log(sum(q.theta))
  logphinorm <- col.lse(logtheta + logbeta.subset)
  sum(doc.ct*logphinorm)
}

sage.infer.gamma <- function(alpha, logphis) {
  rowSums(exp(logphis))+alpha
}

sage.infer.docphis <- function(doc, logbeta.subset, gamma) {
  logphi <- digamma(gamma) + logbeta.subset
  sumterm <- col.lse(logphi)
  logphi <- sweep(logphi,MARGIN=2,sumterm,FUN="-") #subtract from each row.
  logphi <- sweep(logphi, MARGIN=2, STATS=log(doc[2,]), FUN="+")
  return(logphi)
}  
