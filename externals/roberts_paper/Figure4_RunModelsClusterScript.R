#Below is the original code that was put on a cluster system
#to run the models that would form the basis of Figure 4
#in Roberts, Stewart and Airoldi (2016)

#this is primarily as a record of the various parameters that were
#chosen.  The subfolders DMR and SAGE include the reference implementations
#that were used.

cur <- getwd()
library(matrixStats)
library(stringr)
#library(splines)
#library(Matrix)

K <- 60


#workingdir <- "/nfs/projects_nobackup/l/ldaglm/stmdev/rcode/stm/R"
#setwd(workingdir)
#library(matrixStats)
#install.packages(repos=NULL,pkgs="stm_0.03.19.tar.gz", type="source")
#library(stm)
library(lda)
library(stm)
#code <- list.files()
#for(i in 1:length(code)){
#    source(code[i])
#  }

iter <- as.integer(commandArgs(TRUE))

setwd("/nfs/projects_nobackup/l/ldaglm/HoldOut")

meta <- read.csv("Sample.csv")

processed <- textProcessor(meta$V6, metadata=meta)
out <- prepDocuments(processed$documents, processed$vocab, processed$meta, lower.thresh=100)
out$meta$sourc <- as.factor(out$meta$Source)

setwd("/nfs/projects_nobackup/l/ldaglm/HoldOut/HeldOutAtScale")

#heldout <- make.heldout(out$documents, out$vocab)
#save(heldout, file=paste("HeldOut", iter, "_Topics", K, ".RData", sep=""))
load(paste("HeldOut", iter, "_Topics", "100", ".RData", sep=""))

setwd("/nfs/projects_nobackup/l/ldaglm/HoldOut/SpectralAtScale")
#stm spectral
mod.spectral <- stm(documents = heldout$documents, vocab = heldout$vocab, K = K, prevalence = ~  sourc +
        s(as.numeric(Date)), content = ~ sourc, data = out$meta, max.em.its = 200, init.type="Spectral")

mod.spectral.save <- list("settings"=mod.spectral$settings, "beta"=mod.spectral$beta, "theta"=mod.spectral$theta)
file1 <- paste("Spectral", iter,"_Topics", K, ".RData", sep="")
save(mod.spectral.save, file=file1)
#load(file1)

setwd("/nfs/projects_nobackup/l/ldaglm/HoldOut/DMRAtScale")
#dmr
X <- mod.spectral.save$settings$covariates$X
mod.dmr <- stm:::dmr.control(heldout$documents, heldout$vocab,K=K,X, maxits=200, verbose=F)
mod.dmr.save <- list("document_sums"=mod.dmr$document_sums,"topics"=mod.dmr$topics)
file1 <- paste("DMR", iter,"_Topics", K, ".RData", sep="")
save(mod.dmr.save, file=file1)

setwd("/nfs/projects_nobackup/l/ldaglm/HoldOut/LDAAtScale")
#lda
zerodocs <- lapply(heldout$documents, function (x) rbind(as.integer(x[1,]-1), as.integer(x[2,])))
mod.lda <- lda.collapsed.gibbs.sampler(zerodocs, K, heldout$vocab, num.iterations=250,
                                       alpha=1, eta=.1)
file1 <- paste("LDA", iter,"_Topics", K, ".RData", sep="")
save(mod.lda, file=file1)

setwd("/nfs/projects_nobackup/l/ldaglm/HoldOut/SAGE")
source("SAGE.R")
source("SAGEkapp.R")
source("SAGEaux.R")

setwd("/nfs/projects_nobackup/l/ldaglm/HoldOut/SAGEAtScale")
#sage
mod.sage <- SAGE(heldout$documents, heldout$vocab, K=K,content=~sourc, max.em.its=200, data=out$meta)
mod.sage.save <- list("theta"=mod.sage$model$local$theta, "beta"=mod.sage$model$global$logbeta)
file1 <- paste("SAGE", iter,"_Topics", K, ".RData", sep="")
save(mod.sage.save, file=file1)

