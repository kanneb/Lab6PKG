#' Greedy heuristic approximation of the knapsack problem
#'
#' Solves the knapsack problem approximately by sorting items on value
#' per unit of weight and adding them in that order until the next item
#' no longer fits. An efficient way but not a guaranteed way to find
#' the optimal solution.
#'
#' @param x an object of class data.frame with two numeric columns: \code{w} (weights)
#'   and \code{v} (values). All integers must be positive
#' @param W A positive integer, the knapsack capacity.
#'
#' @return A list with two elements:
#'  \item{value}{The total value of the selected items}
#'  \item{elements}{The row numbers of the selected items in \code{x}}
#'
#' @references \url{en.wikipedia.org/wiki/Knapsack problem#Greedy approximation algorithm}
#'
#' @examples
#'
#' set.seed(42, kind = "Mersenne-Twister", normal.kind = "Inversion")
#' n <- 10000
#' knapsack_objects <- data.frame(w = sample(1:4000, size = n, replace = TRUE),
#'                                v = runif(n = n, 0, 10000))
#'
#' res1 <- greedy_knapsack(x = knapsack_objects[1:800,], W = 3500)
#' res1$value
#' res1$elements
#'
#' res2 <- greedy_knapsack(x = knapsack_objects[1:1200,], W = 2000)
#' res2$value
#' res2$elements
#'
#' @export
greedy_knapsack <- function(x, W){

  stopifnot(is.data.frame(x),
            all(c("w","v") %in% names(x)),
            all(x$v > 0),
            all(x$w > 0),
            W > 0
  )

  order <- order(x$v / x$w, decreasing = TRUE)

  tw <- 0
  tv <- 0
  elements <- c()

  for (i in order) {
    if(tw + x$w[i] > W) break
      tw <- tw + x$w[i]
      tv <- tv + x$v[i]
      elements <- c(i, elements)
  }

  return(list(value = round(tv), elements = elements))
}


# Runtime of algorithm
#rt <- matrix(0, nrow = 10, ncol = 3)
#colnames(rt) <- c("user", "system", "elapsed")
#
#for (i in 1:10) {
#  rt[i,] <- system.time(greedy_knapsack(x = knapsack_objects, W = 2000))[1:3]
#}
#
#mean(rt[,"elapsed"])
#
# Mean of systemtime when the function run 10 times is 0.065 seconds for the given run



