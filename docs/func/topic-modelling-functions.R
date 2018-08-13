# Topic Modelling Functions

# This section contains functions that assist with topic modelling.

computeJensenShannonPCA <- function(wtp) {
  # Adapted from https://github.com/cpsievert/LDAvis/blob/master/R/createJSON.R
  # 
  # Returns coordinates for plotting topics with Jensen Shannon distance as 
  # the distance measure, projected down to 2 dimensions using principal 
  # coordinates analysis.
  #
  # Args:    wtp:  word-topic probability matrix
  # Returns: data frame containing the x-y location of each topic 
  
  jensenShannon <- function(x, y) {
    c = .000000001
    x = x + c
    y = y + c
    m <- 0.5 * (x + y)
    0.5 * sum(x * log(x/m)) + 0.5 * sum(y * log(y/m))
  }
  
  wtp %>% 
    spread(term, beta) %>% 
    { .[, 2:ncol(.)] } %>%
    dist(x = ., method = jensenShannon) %>% 
    cmdscale(k = 2) %>% {
      data.frame(
        topic = 1:n_distinct(wtp$topic),
        x = .[, 1],
        y = .[, 2]
      )
    }
}

computeJensenShannonPCA2 <- function(dtp) {
  # Adapted from https://github.com/cpsievert/LDAvis/blob/master/R/createJSON.R
  # 
  # Returns coordinates for plotting topics with Jensen Shannon distance as 
  # the distance measure, projected down to 2 dimensions using principal 
  # coordinates analysis.
  #
  # Args:    dtp:  document-topic probability matrix
  # Returns: data frame containing the x-y location of each topic 
  
  jensenShannon <- function(x, y) {
    c = .000000001
    x = x + c
    y = y + c
    m <- 0.5 * (x + y)
    0.5 * sum(x * log(x / m)) + 0.5 * sum(y * log(y / m))
  }
  
  dtp %>% 
    { .[, 2:ncol(.)] } %>%
    dist(x = ., method = jensenShannon) %>% 
    cmdscale(k = 2) %>% {
      data.frame(
        document = unique(dtp$document),
        x = .[, 1],
        y = .[, 2]
      )
    }
}


