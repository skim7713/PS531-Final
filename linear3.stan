data {
  int<lower=0> N; // number of data items
  int<lower=0> K; // number of predictors
  matrix[N, K] x; // predictor matrix
  vector[N] y; // outcome vector
}
parameters {
  vector[K] beta; // coefficients for predictors
  real<lower=0> sigma; // error scale
}
model {
    for(l in 1:K){
    beta[l] ~ normal(0, 2); 
   }
  for (n in 1:N){
     y[n] ~ normal(x[n] * beta, sigma);
     }
  }
generated quantities{
  vector[N] mu;
  for ( n in 1:N ) {
    mu[n] = x[n]*beta;
  }
}

