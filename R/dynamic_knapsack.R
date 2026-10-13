#' Dynamic programming solution for knapsack problem
#'
#' Solves the knapsack problem exactly using dynamic programming. A table \code{m}
#' is filled where \code{m[i,j]} is the highest value possible using the first
#' \code{i} items with capacity \code{j}.
#'
#' @param x A data.frame with two numeric columns: \code{w} (weights) and
#'   \code{v} (values). All integers must be positive
#' @param W A positive integer, the knapsack capacity.
#'
#' @return A list with two elements:
#'  \item{value}{The total value of the selected items}
#'  \item{elements}{The row numbers of the selected items in \code{x}}
#'
#' @references \url{en.wikipedia.org/wiki/Knapsack problem#Dynamic programming in-advance algorithm}
#'
#' @examples
#' set.seed(42, kind = "Mersenne-Twister", normal.kind = "Inversion")
#' n <- 500
#' knapsack_objects <- data.frame(w = sample(1:4000, size = n, replace = TRUE),
#'                                v = runif(n = n, 0, 10000))
#'
#' res1 <- knapsack_dynamic(x = knapsack_objects[1:8,], W = 2000)
#' res1$value
#' res1$elements
#'
#' res2 <- knapsack_dynamic(x = knapsack_objects[1:12,], W = 3500)
#' res2$value
#' res2$elements
#'
#' @export
knapsack_dynamic <- function(x, W){

  stopifnot(is.data.frame(x),
            all(c("w","v") %in% names(x)),
            all(x$v > 0),
            all(x$w > 0),
            W > 0
  )

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

# Runtime of algorithm
#rt <- matrix(0, nrow = 10, ncol = 3)
#colnames(rt) <- c("user", "system", "elapsed")
#
#for (i in 1:10) {
#  rt[i,] <- system.time(knapsack_dynamic(x = knapsack_objects, W = 3500))[1:3]
#}
#
#mean(rt[,"elapsed"])
#
# Mean of systemtime when the function run 10 times is 0.415 for the given run

