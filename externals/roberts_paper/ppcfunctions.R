
ppc <- function(mod, documents, nsims=20) {
  if(!require(data.table)) stop("Install data.table to use this function.")
  nsims <- nsims + 1 #add one for the original data
  theta <- mod$theta
  betaindex <- mod$settings$covariates$betaindex
  beta <- lapply(mod$beta$logbeta, exp)
  K <- mod$settings$dim$K
  V <- mod$settings$dim$V
  # Create the data structures
  # H1- maintain docs by topic counts
  # H2- maintain the doc-topic-word counts
  H1 <- vector(mode="list",length=nsims)
  H2 <- vector(mode="list",length=nsims)
  N <- length(documents)
  ctevery <- ifelse(N>100, floor(N/100), 1)
  
  for(s in 1:nsims) {
    #store the doc topic counts and the document-topic-vocab object
    doctopiccounts <- matrix(0, nrow=length(documents), ncol=K)
    dkv.storage <- vector(mode="list", length(documents))
    for(i in 1:length(documents)) {
      #pull components out and calculate phi
      doc <- documents[[i]]
      thetad <- theta[i,]
      doc.ct <- doc[2,]
      betasub <- beta[[betaindex[i]]][,doc[1,]]
      EB <- thetad*betasub #calculate exp(eta)\beta for each word
      EB <- t(EB)/colSums(EB) #transpose and norm by (now) the row
      
      #replicate out the probabilities to sample realizations
      phi <- EB[rep(1:length(doc.ct), times=doc.ct),]
      draws <- apply(phi, 1, function(x) sample(1:K, size=1,prob=x))    
      #sum up the draws by topic and store.
      tab <- tabulate(draws, nbins=K)
      doctopiccounts[i,] <- tab
      
      #If observed, use that, if not sample
      if(s==1) {        
        #bind to the observed words
        dkv.storage[[i]] <- cbind(i, draws, rep(doc[1,], times=doc[2,]))
      } else {
        #Sample the Words in Blocks by Topic
        words <- vector(mode="list", length=K)
        for(k in 1:length(tab)) {
          if(tab[k]==0) next
          #sample new words from the distribution
          words[[k]] <- sample(x=1:V, size=tab[k], prob=beta[[betaindex[i]]][k,], replace=TRUE)
        }
        #Unlist and put in a matrix
        words <- unlist(words)
        zs <- rep(1:length(tab), times=tab) #reorder the z's so they match the order of the sampled words
        dkv.storage[[i]] <- cbind(i, zs,words)  
      }
      if(i%%ctevery==0) cat(".")
    }
    #Calculate Entropy H(d|k)
    x <- t(doctopiccounts)
    x <- x/rowSums(x)
    x <- log2(x)*x
    x[is.na(x)] <- 0
    H1[[s]] <- -rowSums(x)
    
    dkvtab <- do.call(rbind,dkv.storage)
    rm(dkv.storage)
    dkv <- data.table(dkvtab)
    rm(dkvtab)
    setnames(dkv, c("d", "k", "v"))    
    setkey(dkv, k, v)
    H2[[s]] <- dkv[, mytab(d), by=list(k,v)]
    rm(dkv)
    setkey(H2[[s]], k,v)
    if(s==1) cat("\n Completed Observed Data Calculation \n")
    if(s>1) cat(sprintf("\n Finished Simulation %i \n", s-1))
  }
  H1 <- do.call(rbind,H1)
  return(list(H1=H1, H2=H2))
}



mytab <- function(x) {
  tab <- tabulate(x)
  pofx <- tab[tab!=0]/sum(tab)
  -sum(pofx*log2(pofx))
}
mytab <- compiler::cmpfun(mytab)

plot.ppc <- function(x, windex, k, vocab, xlim=NULL, 
                     main=sprintf("Topic %i",k), xlab="Instantaneous Mutual Information", 
                     ylab="Word Rank in Topic") {
  H1 <- x$H1
  H2 <- x$H2
  query <- data.table(k=k, v=windex)
  imivals <- H1[1,k] - H2[[1]][query]$V1
  if(is.null(xlim)) xlim <- c(0, max(imivals)+.1)
  plot(imivals, 1:length(windex), ylim=c(length(windex)+1,1), xlim=xlim,
       pch=19, main=main, ylab=ylab, xlab=xlab)
  text(imivals, 1:length(windex),vocab[windex],pos=1)
  for(s in 2:length(H2)) {
    setkey(H2[[s]], k, v)
    points(H1[s,k] - H2[[s]][query]$V1, 1:length(windex), col=rgb(160,32,240,50,maxColorValue=255))
  }
  abline(h=1:length(windex),lty=2, col="lightgrey")
}