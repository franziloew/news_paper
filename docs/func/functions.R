Mode = function(x){ 
  ta = table(x)
  tam = max(ta)
  if (all(ta == tam))
    mod = NA
  else
    if(is.numeric(x))
      mod = as.numeric(names(ta)[ta == tam])
  else
    mod = names(ta)[ta == tam]
  return(mod)
}

#############################
## Topic proportion by Ylevel
#############################
plotNewspaperHistogram <- function(topic){
  tab <- tapply(stmOut$theta[,topic], stmOut$settings$covariates$betaindex, mean)
  tab <- as.data.frame(tab) %>% 
    mutate(site=stmOut$settings$covariates$yvarlevels)
  
  ggplot(data=tab, aes(x=site, y=tab)) +
    geom_col(fill=col[3]) +
    coord_flip() +
    theme(axis.text = element_text(size=8),
          axis.title = element_text(size=10)) +
    labs(x="", y=paste("expected frequency of topic",topics.df[topic,2], sep=" ")) 
}

##################################
## Topic correlation within Ylevel
##################################
topicCorrelation <- function(ylevel) {
  cormat <- cor(stmOut$theta[stmOut$settings$covariates$betaindex==ylevel,])
  adjmat <- ifelse(cormat > .05,1,0)
  
  corr <- list()
  corr$posadj <- adjmat
  corr$poscor <- cormat*adjmat
  corr$cor <- ifelse(abs(cormat)>.05,cormat,0)
  
  x <- corr$posadj[1:nrow(corr$posadj),1:nrow(corr$posadj)]
  
  g<- graph.adjacency(x, mode="undirected", weighted=TRUE, diag=FALSE)
  
  E(g)$size <- 1
  E(g)$lty <- 2
  E(g)$color <- "black"
  V(g)$label <- topics[,2]
  layout <- layout_nicely
  
  plot.igraph(g, layout=layout_nicely, vertex.color="white", label.font = "Roboto",
              vertex.frame.color="grey", vertex.size=1, vertex.label.cex=.7, edge.color="red",
              edge.width=1, main=paste("Topic correlation", stmOut$settings$covariates$yvarlevels[ylevel]))
}

##################################
## Topic correlation Network
##################################
topicCorrNetwork <- function(g, title) {
  
  toplot <- tidygraph::as_tbl_graph(g) %>%
    mutate(degree = tidygraph::centrality_degree(loops = FALSE)) %>%
    tidygraph::activate(edges) %>%
    filter(!tidygraph::edge_is_loop()) %>%
    mutate(weight = round(weight, 2),
           edge_label = '')
  
  plot <- toplot %>% ggraph(layout = 'fr') +
    geom_edge_link(
      aes(edge_width = weight, label =  edge_label),
      label_colour = '#fc8d62',
      edge_colour = '#377eb8',
      alpha = 0.5,
      label_size = 0.5,
      angle_calc = 'along'
      #label_dodge = unit(3, "mm")
    ) +
    geom_node_point(size = 2, colour = 'black')  +
    geom_node_label(
      aes(label = name),
      size = 2,
      colour = 'black',
      repel = TRUE,
      alpha = 0.85
    ) +
    theme_graph() +
    #scale_size(range = c(1, 3), labels = scales::percent) +
    labs(edge_width = 'Topic Correlation',
         title = title) +
    scale_edge_width(range = c(0, 3))
  
  return(plot)
  
}

#############################################
## Topic correlation / compared between ylevel
#############################################
topicCorrCompare <- function(ylevel1, ylevel2) {
  
  # find all edges between topics where they exhibit a positive correlation above 0.1
  # Ylevel 1
  cormat <- cor(stmOut$theta[stmOut$settings$covariates$betaindex==ylevel1,])
  cor1 <- ifelse(abs(cormat)>.05,cormat,0)
  # Ylevel 2
  cormat <- cor(stmOut$theta[stmOut$settings$covariates$betaindex==ylevel2,])
  cor2 <- ifelse(abs(cormat)>.05,cormat,0)
  
  # Prepare plot
  g.1 <- graph.adjacency(cor1, mode="undirected", weighted = T, diag = F) 
  g.2 <- graph.adjacency(cor2, mode = "undirected", weighted = T, diag = F)
  
  # create the intersection of two or more graphs: only edges present in all graphs will be included
  inter.graph <- graph.intersection(g.1, g.2)
  # create the difference of two graphs. Only edges present in the first graph but not in the second will be be included in the new graph. 
  added.subgraph <- graph.difference(g.1, inter.graph)
  subs.subgraph <- graph.difference(g.2, inter.graph)
  # combine all graphs
  g.whole<-graph.union(inter.graph,added.subgraph,subs.subgraph)
  
  inter.list <- get.edgelist(inter.graph)
  list.1 <- get.edgelist(added.subgraph)
  list.2 <- get.edgelist(subs.subgraph)
  
  # Set Frame
  cormat <- matrix(0, nrow=100, ncol=100)
  for(i in 1:nrow(inter.list)){
    cormat[inter.list[i,1], inter.list[i,2]] <- .5
    cormat[inter.list[i,2], inter.list[i,1]] <- .5
  }
  
  for(i in 1:nrow(list.1)){
    cormat[list.1[i,1], list.1[i,2]] <- -1
    cormat[list.1[i,2], list.1[i,1]] <- -1
  }
  
  for(i in 1:nrow(list.2)){
    cormat[list.2[i,1], list.2[i,2]] <- 1
    cormat[list.2[i,2], list.2[i,1]] <- 1
  }
  
  # Create axis-label cormat
  cormat <- cormat[as.numeric(topics[,1]),as.numeric(topics[,1])]
  topics2 <- sapply(topics[,2], function (x) str_replace(x, "\n", ""))
  rownames(cormat) <- colnames(cormat) <- topics.df$topic_name
  
  only.1 <- apply(cormat,1, function (x) sum(x==1))
  only.2 <- apply(cormat,1, function (x) sum(x==-1))
  both <- apply(cormat,1, function (x) sum(x==.5))
  all <- apply(cormat,1, function (x) sum(x!=0))
  disagree <- only.1/all + only.2/all
  
  disagreed <- order(disagree, decreasing=F)
  list <- topics[disagreed,2]
  disagreemat <- cormat[disagreed, disagreed]
  rownames(disagreemat) <- topics2[disagreed]
  colnames(disagreemat) <- topics2[disagreed]
  
  corrplot(disagreemat, cl.pos="n", tl.col="black", tl.cex=.5)
  legend(40,20, c(paste(stmOut$settings$covariates$yvarlevels[ylevel1]), paste(stmOut$settings$covariates$yvarlevels[ylevel2]), "Both", "None"),
         col=c("darkred", "darkblue", "lightblue", "white"), 
         pch=c(15,15,16,16), cex = 0.7, box.lty = 0)
}

####################
## Distance Measures
####################

# Cosine Similarity
CosSim <- function(x,y) {
  
  sum(x * y) / (sqrt(sum(x*x)) * sqrt(sum(y*y)))
  
}

# Jensen Shanon Divergence
JSD<- function(x,y) {
  sqrt(0.5 * KLD(x, (x+y)/2) + 0.5 * KLD(y, (x+y)/2))
}

# Kullback Leibler Divergence
KLD <- function(x,y) {
  sum(x * log(x/y))
}

#####################
## Standartization ##
#####################

normalize_data <- function(x) {
  if (is.numeric(x)) {
    y <- (x - min(x, na.rm = T)) / (max(x, na.rm = T) - min(x, na.rm = T))
    return(y)
  } else {
    return(x)
  }

}

###########
## Dates ##
###########

calculate_month = function(month, year) {
  date <- ymd(paste(year, 1, 1, sep="-"))
  month(date) = month
  return(date)
}

calculate_week = function(week, year) {
  date <- ymd(paste(year, 1, 1, sep="-"))
  week(date) = week
  return(date)
}

###################################
# insert linebreak for long strings
###################################

linebreak <- function(s) {
  gsub('(.{1,15})(\\s|$)', '\\1\n', s)
}

linebreak_n <- function(s,n) {
  gsub(paste0('(.{1,',n,'})(\\s|$)'), '\\1\n', s)
}
