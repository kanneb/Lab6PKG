set.seed(42, kind = "Mersenne-Twister", normal.kind = "Inversion")
n <- 1000000
knapsack_objects <- data.frame(w = sample(1:4000, size = n, replace = TRUE),
                               v = runif(n = n, 0, 10000))

greedy_knapsack <- function(x, W){
  sorted <- x %>%
    mutate(
      id = row_number(),
      ratio = v/w
    ) %>%
    arrange(desc(ratio))

  tw <- 0
  tv <- 0
  elements <- c()

  for (i in 1:nrow(sorted)) {
    if(tw + sorted$w[i] > W) break
      tw <- tw + sorted$w[i]
      tv <- tv + sorted$v[i]
      elements <- c(sorted$id[i], elements)
  }

  return(list(value = round(tv), elements = elements))
}


greedy_knapsack(x = knapsack_objects[1:800,], W = 3500)
greedy_knapsack(x = knapsack_objects[1:1200,], W = 2000)

# Runtime of algorithm
rt <- matrix(0, nrow = 10, ncol = 3)
colnames(rt) <- c("user", "system", "elapsed")

for (i in 1:10) {
  rt[i,] <- system.time(greedy_knapsack(x = knapsack_objects, W = 2000))[1:3]
}

mean(rt[,"elapsed"])

# Mean of systemtime when the function run 10 times is 0.065 seconds for the given run



