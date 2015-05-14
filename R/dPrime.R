#' Function for calculating d prime
#'
#' This function will calculate d prime. This is common in discrimination experiments.
#' Note: If your participants are at ceiling, you may want to consider another analysis.
#' @param f Hit rate.
#' @param f False alarm rate.
#' @keywords d prime
#' @export
#' @examples
#' # Simple example
#' dPrime(.75, .25)
#' 
#' # Complex example
#' # Create some data
#' set.seed(1); library(dplyr)
#' axb <- data.frame(subj = sort(rep(1:10, each = 20, times = 10)),
#'                   group = gl(2, 1000, labels = c("g1", "g2")),
#'                   hit = c(rbinom(1000, size = c(0, 1), prob = .8), 
#'                           rbinom(1000, size = c(0, 1), prob = .6)),
#'                   fa =  c(rbinom(1000, size = c(0, 1), prob = .3), 
#'                           rbinom(1000, size = c(0, 1), prob = .4))
#' )
#' 
#' # Calculate d prime for each subject
#' # by group, plot it, and run a 
#' # linear model
#' axb %>%
#'   group_by(subj, group) %>%
#'   summarize(hRate = mean(hit), 
#'             faRate = mean(fa), 
#'             dp = dPrime(hRate, faRate)) %T>%
#'  {
#'   plot(dp ~ as.numeric(group), data = ., 
#'        main = "d' as a function of group", xaxt = "n", 
#'        xlab = "Group", ylab = "d' prime")
#'   axis(1, at = 1:2, labels = c("g1", "g2"))
#'   abline(lm(dp ~ as.numeric(group), data = .), col = "red")
#'  } %>%
#'  lm(dp ~ group, data = .) %>%
#'  summary()

dPrime <- function(h, f){
    dp <- qnorm(h) - qnorm(f)
    return(dp)
}