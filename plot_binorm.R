library(MASS)
library(plotly)

make_Sigma <- function(var_x, var_y, rho) {
  
  if(var_x <= 0 | var_y <= 0) {
    print('Variance must be greater than zero.')
    stop()
  }
  
  if(rho > 1 | rho < -1) {
    print('Correlation must be between -1 and 1 (included).')
    stop()
  }
  
  matrix(c(var_x, rho, rho, var_y), nrow = 2, ncol = 2)
}
  
plot_binorm <- function(n, mu, Sigma) {
  
  if(length(mu) > 2 | length(mu) < 2) {
    print('Provide a mean vector of length 2')
    stop()
  }
  
  data <- as.data.frame(mvrnorm(n, mu, Sigma))
  kd <- with(data, kde2d(V1, V2, n = 50))
  fig <- plot_ly(x = kd$x, y = kd$y, z = kd$z) %>% add_surface()
  
  fig
}


