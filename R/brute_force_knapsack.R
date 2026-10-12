#'Knapsack brute force search
#'
#'Solves a knapsack problem using brute force search
#'
#'
#'@references \url{https://en.wikipedia.org/wiki/Knapsack_problem}
#'


brute_force_knapsack = function(x , W){

  stopifnot(is.data.frame(x),
            all(c("w","v") %in% names(x)),
            all(x$v > 0),
            all(x$w > 0),
            W > 0
            )

  result <- list(value = 0, elements = NULL)

  weights <- x$w
  values <- x$v

  for(combination in 1:(2^nrow(x))){

    binary_combination <- as.integer(intToBits(combination))[1:nrow(x)]
    elements <- binary_combination == 1

    idx_weights <- weights[elements]
    idx_values <- values[elements]

    combination_weight <- sum(idx_weights)
    combination_values <- sum(idx_values)

    if((result$value < combination_values) && (combination_weight <= W)){
      result$value <- combination_values
      result$elements <- which(elements == TRUE)
    }

  }

  return(result)




}

RNGversion(min(as.character(getRversion()),"3.5.3"))

set.seed(42, kind = "Mersenne-Twister", normal.kind = "Inversion")

n <- 2000

knapsack_objects <- data.frame(
  w = sample(1:4000, size = n, replace = TRUE),
  v = runif(n = n, 0, 10000)
)

head(knapsack_objects)


ans <- brute_force_knapsack(x = knapsack_objects[1:8,], W = 2000)
print(ans)
