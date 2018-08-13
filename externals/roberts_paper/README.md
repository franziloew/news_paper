Replication for Roberts, Stewart and Airoldi (2016)
======

This is a replication file for Roberts, Stewart and Airoldi (2016) "A Model of Text for Experimentation in the Social Sciences" published in the *Journal of the American Statistical Association*

This file is for documentation purposes.  For those interested in using the Structural Topic Model, we highly recommend you go to structuraltopicmodel.com and use the stm package in R.  Much of the code that is included in this replication file was improved upon in the latest version of the package.  Most of the analysis for the article was completed before the initial submission in March 2014 and the package has evolved substantially since then.

If you have any questions please feel free to contact me: Brandon Stewart  at bms4@princeton.edu

Raw texts
-----
We unfortunately cannot provide the raw texts because we do not own the underlying intellectual property and they are not in the public domain.  We have provided the term document matrices and apologize for the inconvenience.

A note on organization
-----
Each folder contains what is needed to run that analysis so there is a lot of duplication over the file as a whole.

Figure 2
-----
This is a simple simulation comparing STM to LDA and contains only a single code file: Figure2_CosinePLot.R

Figure 3
-----
Start with Figure3_Simulation.R and then look at Figure3_Plot.R

Figure 4
-----
We include the script that originally was sent to the cluster to run the models (Figure4_RunModelsClusterScript.R) and include the reference implementations of DMR and SAGE.  SAGE has 4 scripts: SAGErunscript.R demonstrates the use of the other three.  

If you want to use DMR in your own research we recommend David Mimno's implementation in Mallet.  If you want to use SAGE you can simple using the content covariates in STM (the major difference is the logistic normal prior on the document-topic proportions rather than the dirichlet prior).

Figure 5
-----
ppc.RData contains the completed checks, ppc.R contains the script that loads the file and makes the plots, ppcfunctions.R provides the workhorse functions that actual do the calculations.

ChinaAnalysis
-----
China.R contains all the analyses in the application part of the paper.

