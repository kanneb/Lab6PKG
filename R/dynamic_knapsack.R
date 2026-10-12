set.seed(42, kind = "Mersenne-Twister", normal.kind = "Inversion")
n <- 2000
knapsack_objects <- data.frame(w = sample(1:4000, size = n, replace = TRUE),
                               v = runif(n = n, 0, 10000))


knapsack_dynamic <- function(x, W){
  n <- nrow(x)
  m <- matrix(0, nrow = n + 1, ncol = W + 1)

  for (i in 1:n) {
    wi <- x$w[i]; vi <- x$v[i]
    for (j in 0:W) {
      if(wi > j){
        m[i + 1, j + 1] <- m[i, j + 1]
      } else {
        m[i + 1, j + 1] <- max(m[i, j + 1], m[i,j - wi] + vi)
      }
    }
  }

  elements <- c(); j <- W

  for (i in n:1) {
    if(m[i + 1, j + 1] > m[i, j + 1]){
      elements <- c(i, elements)
      j <- j - x$w[i]
    }
  }


  return(list(value = round(m[n + 1, W + 1]),
              elements = elements))
}

#knapsack_dynamic(x = knapsack_objects[1:8,], W = 2000)
#knapsack_dynamic(x = knapsack_objects[1:12,], W = 3500)
